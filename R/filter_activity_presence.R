#' @title Filter Activity Presence
#'
#' @description Filters cases based on the presence (or absence) of activities.
#'
#' @param method [`character`] (default `"all"`): Filter method: `"all"` (default), `"none"`, `"one_of"`, `"exact"`,
#' or `"only"`. For more information, see **Details** below.
#'
#' @details
#' This functions allows to filter cases that contain certain activities. It requires as input a vector containing one or more activity labels
#' and it has a `method` argument with following options:
#' * `"all"` means that all the specified activity labels must be present for a case to be selected.
#' * `"none"` means that they are not allowed to be present.
#' * `"one_of"` means that at least one of them must be present.
#' * `"exact"` means that only exactly these activities can be present (although multiple times and in random orderings).
#' * `"only"` means that only (a set of) these activities are allowed to be present.
#'
#' When only one activity label is supplied, note that `method`s `"all"` and `"one_of"` will be identical.
#'
#' @inherit filter_activity params references seealso return
#'
#' @family filters
#'
#' @concept filters_case
#'
#' @export filter_activity_presence
filter_activity_presence <- function(log,
									 activities = NULL,
									 method = c("all", "none", "one_of", "exact", "only"),
									 reverse = FALSE,
									 eventlog = deprecated()){
	UseMethod("filter_activity_presence")
}

#' @describeIn filter_activity_presence Filters activities for a [`log`][`bupaR::log`].
#' @export
filter_activity_presence.log <- function(log,
										 activities = NULL,
										 method = c("all", "none", "one_of", "exact", "only"),
										 reverse = FALSE,
										 eventlog = deprecated()) {

	in_selection <- NULL
	in_ <- NULL
	out_ <- NULL

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_activity_presence(eventlog)",
			with = "filter_activity_presence(log)")
		log <- eventlog
	}

	method <- arg_match(method)

	#check if function is called because on grouped_log
	grouped <- any(str_detect(as.character(rlang::trace_back()$call), "filter_activity_presence.grouped_log"))
	#remove activities not in log. Emit warning when not grouped
	correct_activities <- check_activities(activities, activity_labels(log), emit_warning = !grouped)

	#if no activities are valid, return empty log
	if(length(correct_activities) == 0) {
		log %>%
			filter(FALSE)
	} else {

		log %>%
			select(!!as.symbol(activity_id(log)), !!as.symbol(case_id(log)), force_df = T) %>%
			unique() %>%
			mutate(in_selection = !!activity_id_(log) %in% activities) %>%
			group_by(!!as.symbol(case_id(log)), in_selection) %>%
			summarize(n = n_distinct(!!activity_id_(log))) %>%
			mutate(in_selection = ifelse(in_selection, "in_", "out_")) %>%
			spread(in_selection, n, fill = 0) -> selection

		if(method == "all")
			filter_case(log, selection %>% filter(in_ == length(activities)) %>% pull(1), reverse)
		else if(method == "one_of")
			filter_case(log, selection %>% filter(in_ >= 1) %>% pull(1), reverse)
		else if (method == "none")
			filter_case(log, selection %>% filter(in_ == 0) %>% pull(1), reverse)
		else if (method == "exact")
			filter_case(log, selection %>% filter(in_ == length(activities), out_ == 0) %>% pull(1), reverse)
		else if (method == "only")
			filter_case(log, selection %>% filter(out_ == 0) %>% pull(1), reverse)

	}


	# if(method == "all") {
	# 	log %>%
	# 		group_by_case %>%
	# 		filter(all(activities %in% !!activity_id_(log))) %>%
	# 		ungroup_eventlog
	#
	# } else if (method == "one_of") {
	# 	log %>%
	# 		group_by_case %>%
	# 		filter(any(activities %in% !!activity_id_(log))) %>%
	# 		ungroup_eventlog()
	# } else if (method  == "none") {
	# 	log %>%
	# 		group_by_case %>%
	# 		filter(!any(activities %in% !!activity_id_(log))) %>%
	# 		ungroup_eventlog
	# 	}

}


#' @describeIn filter_activity_presence Filters activities for a [`grouped_log`][`bupaR::grouped_log`].
#' @export
filter_activity_presence.grouped_log <- function(log,
												 activities = NULL,
												 method = c("all", "none", "one_of", "exact", "only"),
												 reverse = FALSE,
												 eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_activity_presence(eventlog)",
			with = "filter_activity_presence(log)")
		log <- eventlog
	}

	method <- arg_match(method)

	#check activities are valid
	activities <- check_activities(activities, activity_labels(ungroup_eventlog(log)))

	bupaR:::apply_grouped_fun(log, fun = filter_activity_presence.log, activities, method, reverse, .ignore_groups = FALSE, .keep_groups = TRUE, .returns_log = TRUE)
	#grouped_filter(eventlog, filter_activity_presence, activities, method)
}

#' @keywords internals
#' @rdname ifilter
#' @export ifilter_activity_presence
ifilter_activity_presence <- function(eventlog) {

	lifecycle::deprecate_warn("0.9.0", "ifilter_activity_presence()")

	ui <- miniPage(
		gadgetTitleBar("Filter activities based on presence"),
		miniContentPanel(
			fillCol(flex = c(2,1),
					fillRow(flex = c(10,1,8),
							selectizeInput("selected_activities",
										   label = "Select activities:",
										   choices = eventlog %>% pull(!!as.symbol(activity_id(eventlog))) %>%
										   	unique, selected = NA,  multiple = TRUE), " ",
							radioButtons("method", "Method: ", choices = c("All" = "all","One of"= "one_of","None" = "none", "Exact" = "exact","Only" = "only"), selected = "all")
					),
					"If \"all\", each of the activities should be present.
              If \"one_of\", at least one of them should be present. If \"none\", none of the activities are allowed to occur in the filtered traces."
			))
	)

	server <- function(input, output, session){
		observeEvent(input$done, {

			filtered_log <- filter_activity_presence(eventlog,
													 activities = input$selected_activities,
													 method = input$method)


			stopApp(filtered_log)
		})
	}
	runGadget(ui, server, viewer = dialogViewer("Filter activities based on presence", height = 400))

}
