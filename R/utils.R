
#' @export
magrittr::`%>%`


#' @importFrom rlang sym
#'

case_id_ <- function(eventlog) sym(case_id(eventlog))
activity_id_ <- function(eventlog) sym(activity_id(eventlog))
activity_instance_id_ <- function(eventlog) sym(activity_instance_id(eventlog))
resource_id_ <- function(eventlog) sym(resource_id(eventlog))
timestamp_ <- function(eventlog) sym(timestamp(eventlog))
lifecycle_id_ <- function(eventlog) sym(lifecycle_id(eventlog))




deprecated_level <- function(level,...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("level_of_analysis",names(l)))) {
		warning("Argument level_of_analysis is deprecated. Use level instead.")
		l[stringr::str_detect("level_of_analysis",names(l))][[1]]
	} else {
		level
	}
}

deprecated_perc <- function(perc,...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("percentile_cut_off",names(l)))) {
		warning("Argument percentile_cut_off is deprecated. Use percentage instead.")
		l[stringr::str_detect("percentile_cut_off",names(l))][[1]]
	} else {
		perc
	}
}

deprecated_lower_thr <- function(int_1,...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("lower_threshold",names(l)))) {
		warning("Arguments lower_threshold and upper_threshold are deprecated. Use interval instead.")
		l[stringr::str_detect("lower_threshold",names(l))][[1]]
	} else {
		int_1
	}
}

deprecated_upper_thr <- function(int_2,...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("upper_threshold",names(l)))) {
		warning("Arguments lower_threshold and upper_threshold are deprecated. Use interval instead.")
		l[stringr::str_detect("upper_threshold",names(l))][[1]]
	} else {
		int_2
	}
}

deprecated_starting_point <- function(s, ...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("start_point",names(l)))) {
		warning("Arguments start_point and end_point are deprecated. Use interval instead.")
		l[stringr::str_detect("start_point",names(l))][[1]]
	} else {
		s
	}
}

deprecated_end_point <- function(e, ...) {
	l <- list(...)
	if(length(l) > 0 && any(stringr::str_detect("end_point",names(l)))) {
		warning("Arguments start_point and end_point are deprecated. Use interval instead.")
		l[stringr::str_detect("end_point",names(l))][[1]]
	} else {
		e
	}
}

is_attached <- function(x) {
	paste0("package:", x) %in% search()
}

grouped_metric <- function(grouped_eventlog, FUN, ...) {
	# grouped_metric function should be replaced with bupaR:::apply_grouped_fun
	bupaR:::apply_grouped_fun(grouped_eventlog, FUN, ...)
}




grouped_metric_raw_log <- function(grouped_eventlog, FUN, ...) {

	## Apply function on a grouped eventlog at the log-level


	mapping <- mapping(grouped_eventlog)

	#apply function for each group
	grouped_eventlog %>%
		nest %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, FUN, ...)) -> temp

	#select the raw data for each group

	temp %>%
		mutate(raw = map(data, attr, "raw")) %>%
		select(-data) %>%
		unnest(cols = c(raw)) -> raw

	#unnest result
	temp %>%
		mutate(data = map(data, ~as.data.frame(as.list(.x)))) %>%
		unnest(cols = c(data)) -> output

	# attach raw data
	output <- ungroup(output)
	attr(output, "raw") <- raw
	attr(output, "groups") <- groups(grouped_eventlog)

	return(output)
}

grouped_filter <- function(eventlog, FILTER, ...) {
	mapping <- mapping(eventlog)

	eventlog %>%
		nest %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, FILTER, ...)) %>%
		unnest %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups(eventlog))))) -> output

	output
}

return_metric <- function(eventlog, output, level, append, append_column, metric , n_result_col = 2, empty_label = F) {

	append <- maybe_missing(append, default = FALSE)

	if(append && level != "log" && level != "trace") {
		ncol <- ncol(output)
		ids <- 1:(ncol-n_result_col)
		res <- (ncol+1-n_result_col):ncol

		output %>%
			select(ids, !!sym(append_column)) -> output


		if(empty_label) {
		output %>%
			set_names(c(names(.)[ids], paste0(append_column, "_", level))) -> output
		}
		else {
			output %>%
				set_names(c(names(.)[ids], paste0(append_column, "_", level, "_", metric))) -> output
		}
		#	rename_( paste0(metric, "_", level, "_", append_column) == append_column) -> output

		# output %>%
		# 	set_names(c(names(.)[ids], paste0(metric, "_",level,"_",names(.)[res]))) -> output

		suppressMessages(left_join(eventlog, output)) %>%
			re_map(mapping(eventlog)) -> output

		if("grouped_eventlog" %in% class(eventlog)) {
			output <- group_by_at(output, vars(one_of(paste(groups(eventlog)))))
		}
		output


	} else {
		class(output) <- c(str_replace(paste0(level, "_metric"), "-", "_"),metric, class(output)) #replace for resource-activity
		attr(output, "level") <- level
		attr(output, "mapping") <- mapping(eventlog)
		attr(output, "metric_type") <- metric
		if("grouped_eventlog" %in% class(eventlog)) {
			attr(output, "groups") <- groups(eventlog)
		}
		return(output)
	}
}


summary_statistics <- function(vector) {

  vector %>%
    as_tibble() %>%
    summarise("min" = suppressWarnings(min(vector, na.rm = T)),
              "q1" = quantile(vector, probs = 0.25, na.rm = T),
              "median" = median(vector, na.rm = T),
              "mean" = mean(vector, na.rm = T),
              "q3" = quantile(vector, probs = 0.75, na.rm = T),
              "max" = max(vector, na.rm = T),
              "st_dev" = suppressWarnings(sd(vector, na.rm = T)),
              "iqr" = .data[["q3"]] - .data[["q1"]]) -> s

  return(s)
}

grouped_summary_statistics <- function(data.frame, values, na.rm = T, ...) {
	values <- sym(values)
	data.frame %>%
		summarize(min = suppressWarnings(min(!!values,na.rm = na.rm)),
				  q1 = quantile(!!values, 0.25, na.rm = na.rm),
				  mean = mean(!!values, na.rm = na.rm),
				  median = median(!!values, na.rm = na.rm),
				  q3 = quantile(!!values, 0.75, na.rm = na.rm),
				  max = suppressWarnings(max(!!values, na.rm = na.rm)),
				  st_dev = sd(!!values, na.rm = na.rm),
				  iqr = IQR(!!values, na.rm = na.rm),
				  total = sum(!!values, na.rm = na.rm),
				  ...)
}

# Warning: The `eventlog` argument of `func()` is deprecated as of edeaR 0.9.0.
# Please use the `log` argument instead.
# WARNING: Works only on exported functions!
lifecycle_warning_eventlog <- function (log, eventlog = deprecated()) {

	cl <- sys.call(-1L)
	func <- get(as.character(cl[[1L]]), mode = "function", envir = sys.frame(-2L))
	func_name <- match.call(definition = func, call = cl)[[1L]]

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = paste0(func_name, "(eventlog)"),
			with = paste0(func_name, "(log)"))
		return(eventlog)
	}

	return(log)
}

lifecycle_warning_append <- function (append = deprecated(), append_column = deprecated()) {

	cl <- sys.call(-1L)
	func <- get(as.character(cl[[1L]]), mode = "function", envir = sys.frame(-2L))
	func_name <- match.call(definition = func, call = cl)[[1L]]

	if (lifecycle::is_present(append) ) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = paste0(func_name, "(append)"),
			with = "augment()"
		)
	} else {
		append <- rlang::missing_arg()
	}

	return(rlang::maybe_missing(append))
}

check_activities <- function(specified_activities, found_activities, arg = "activities", call = caller_env(), emit_warning = TRUE) {
	wrong <- specified_activities[!(specified_activities %in% found_activities)]
	if (length(wrong) > 0 && emit_warning) {
		cli_warn(c("{.val {length(wrong)}} specified activit{?y/ies} in {.arg {arg}} not found in {.arg log}.",
				   "!" = "Activit{?y/ies} not found and ignored: {.val {wrong}}."),
				 call = call)
	}
	specified_activities[!(specified_activities %in% wrong)]
}

