#' @title Filter Life Cycle Presence
#'
#' @description Filters activity instances based on the presence (or absence) of life cycles.
#'
#' @details
#' This function allows to filter activity instances that (do not) contain certain life cycle identifiers. It requires as
#' input a vector containing one or more life cycle labels and it has a \code{method} argument with following options:
#' \itemize{
#' \item \code{"all"} means that all the specified life cycle labels must be present for an activity instance to be selected.
#' \item \code{"none"} means that they are not allowed to be present.
#' \item \code{"one_of"} means that at least one of them must be present.
#' \item \code{"exact"} means that only exactly these life cycle labels can be present (although multiple times and in random orderings).
#' \item \code{"only"} means that only (a set of) these life cycle labels are allowed to be present.
#' }
#'
#' @inherit filter_lifecycle params references seealso return
#' @inherit filter_activity_presence params
#'
#' @seealso \code{\link[bupaR]{lifecycle_id}}
#'
#' @family filters
#'
#' @concept filters_event
#'
#' @export filter_lifecycle_presence
filter_lifecycle_presence <- function(log,
									  lifecycles,
									  method = c("all", "none", "one_of", "exact", "only"),
									  reverse = FALSE,
									  lifecycle = deprecated(),
									  eventlog = deprecated()) {
	UseMethod("filter_lifecycle_presence")
}

#' @describeIn filter_lifecycle_presence Filters activity instances on the presence of life cycle labels for an \code{\link[bupaR]{eventlog}}.
#' @export
filter_lifecycle_presence.eventlog <- function(log,
											   lifecycles,
											   method = c("all", "none", "one_of", "exact", "only"),
											   reverse = FALSE,
											   lifecycle = deprecated(),
											   eventlog = deprecated()){

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_lifecycle_presence(eventlog)",
			with = "filter_lifecycle_presence(log)")
		log <- eventlog
	}
	if(lifecycle::is_present(lifecycle)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_lifecycle_presence(lifecycle)",
			with = "filter_lifecycle_presence(lifecycles)")
		lifecycles <- lifecycle
	}

	method <- rlang::arg_match(method)

	in_selection <- NULL
	in_ <- NULL
	out_ <- NULL

	log %>%
		select(!!lifecycle_id_(log), !!activity_instance_id_(log), force_df = T) %>%
		unique() %>%
		mutate(in_selection = !!lifecycle_id_(log) %in% lifecycles) %>%
		group_by(!!as.symbol(activity_instance_id_(log)), in_selection) %>%
		summarize(n = n_distinct(!!lifecycle_id_(log))) %>%
		mutate(in_selection = ifelse(in_selection, "in_", "out_")) %>%
		spread(in_selection, n, fill = 0) -> selection

	if(method == "all")
		filter_activity_instance(log, selection %>% filter(in_ == length(lifecycles)) %>% pull(1), reverse)
	else if(method == "one_of")
		filter_activity_instance(log, selection %>% filter(in_ >= 1) %>% pull(1), reverse)
	else if (method == "none")
		filter_activity_instance(log, selection %>% filter(in_ == 0) %>% pull(1), reverse)
	else if (method == "exact")
		filter_activity_instance(log, selection %>% filter(in_ == length(lifecycles), out_ == 0) %>% pull(1), reverse)
	else if (method == "only")
		filter_activity_instance(log, selection %>% filter(out_ == 0) %>% pull(1), reverse)

	# if(method == "all") {
	# 	eventlog %>%
	# 		group_by_case %>%
	# 		filter(all(activities %in% !!activity_id_(eventlog))) %>%
	# 		ungroup_eventlog
	#
	# } else if (method == "one_of") {
	# 	eventlog %>%
	# 		group_by_case %>%
	# 		filter(any(activities %in% !!activity_id_(eventlog))) %>%
	# 		ungroup_eventlog()
	# } else if (method  == "none") {
	# 	eventlog %>%
	# 		group_by_case %>%
	# 		filter(!any(activities %in% !!activity_id_(eventlog))) %>%
	# 		ungroup_eventlog
	# 	}
}

#' @describeIn filter_lifecycle_presence Filters activity instances on the presence of life cycle labels for a \code{\link[bupaR]{grouped_eventlog}}.
#' @export
filter_lifecycle_presence.grouped_eventlog <- function(log,
													   lifecycles,
													   method = c("all", "none", "one_of", "exact", "only"),
													   reverse = FALSE,
													   lifecycle = deprecated(),
													   eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)
	if(lifecycle::is_present(lifecycle)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_lifecycle_presence(lifecycle)",
			with = "filter_lifecycle_presence(lifecycles)")
		lifecycles <- lifecycle
	}

	method <- rlang::arg_match(method)

	bupaR:::apply_grouped_fun(log, fun = filter_lifecycle_presence.eventlog, lifecycles, method, reverse, .ignore_groups = TRUE, .keep_groups = TRUE, .returns_log = TRUE)
}


#' @keywords internal
#' @rdname ifilter
#' @export ifilter_lifecycle_presence
ifilter_lifecycle_presence <- function(eventlog) {

	lifecycle::deprecate_warn("0.9.0", "ifilter_lifecycle_presence()")

	ui <- miniPage(
		gadgetTitleBar("Filter activities based on presence"),
		miniContentPanel(
			fillCol(flex = c(2,1),
					fillRow(flex = c(10,1,8),
							selectizeInput("selected_activities",
										   label = "Select life cycle:",
										   choices = eventlog %>% pull(!!as.symbol(lifecycle_id(eventlog))) %>%
										   	unique, selected = NA,  multiple = TRUE), " ",
							radioButtons("method", "Method: ", choices = c("All" = "all","One of"= "one_of","None" = "none", "Exact" = "exact","Only" = "only"), selected = "all")
					),
					"If \"all\", each of the life cycle labels should be present.
					If \"one_of\", at least one of them should be present. If \"none\", none of the life cycle labels are allowed to occur in the filtered traces."
			))
	)

	server <- function(input, output, session){
		observeEvent(input$done, {

			filtered_log <- filter_lifecycle_presence(eventlog,
													 lifecycle = input$selected_activities,
													 method = input$method)


			stopApp(filtered_log)
		})
	}
	runGadget(ui, server, viewer = dialogViewer("Filter activity instances based on presence of life cycle labels", height = 400))

}
