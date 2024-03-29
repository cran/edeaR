#' @title Filter Trace Length
#'
#' @description Filters cases on \code{\link{trace_length}}, using a percentile threshold or interval.
#'
#' This filter can be used by using an \code{interval} or by using a \code{percentage}.
#' The percentage will always start with the shortest cases first and stop
#' including cases when the specified percentile is reached. On the other hand, an absolute
#' interval can be defined instead to filter cases which have a length in this interval.
#'
#' @param interval,percentage Provide either \code{interval} or \code{percentage}.\cr
#' \code{interval} (\code{\link{numeric}} vector of length 2): A trace length interval. Half open interval can be created using \code{\link{NA}}.\cr
#' \code{percentage} (\code{\link{numeric}}): A percentage p to be used for relative filtering.
#'
#' @inherit filter_activity params references seealso return
#'
#' @seealso \code{\link{trace_length}}
#'
#' @family filters
#'
#' @concept filters_case
#'
#' @export filter_trace_length
filter_trace_length <- function(log,
								interval = NULL,
								percentage = NULL,
								reverse = FALSE,
								eventlog = deprecated()) {
	UseMethod("filter_trace_length")
}

#' @describeIn filter_trace_length Filters cases for a \code{\link[bupaR]{log}}.
#' @export
filter_trace_length.log <- function(log,
									interval = NULL,
									percentage = NULL,
									reverse = FALSE,
									eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_trace_length(eventlog)",
			with = "filter_trace_length(log)")
		log <- eventlog
	}

	if(!is.null(interval) && (length(interval) != 2 || !is.numeric(interval) || any(interval < 0, na.rm = T) || all(is.na(interval)) )) {
		stop("Interval should be a positive numeric vector of length 2. One of the elements can be NA to create open intervals.")
	}
	if(!is.null(percentage) && (!is.numeric(percentage) || !between(percentage,0,1) )) {
		stop("Percentage should be a numeric value between 0 and 1.")
	}

	if(is.null(interval) & is.null(percentage))
		stop("At least an interval or a percentage must be provided.")
	else if((!is.null(interval)) & !is.null(percentage))
		stop("Cannot filter on both interval and percentage simultaneously.")
	else if(!is.null(percentage))
		filter_trace_length_percentile(log,
									   percentage = percentage,
									   reverse = reverse)
	else
		filter_trace_length_threshold(log,
									  lower_threshold = interval[1],
									  upper_threshold = interval[2],
									  reverse = reverse)
}

#' @describeIn filter_trace_length Filters cases for a \code{\link[bupaR]{grouped_log}}.
#' @export
filter_trace_length.grouped_log <- function(log,
											interval = NULL,
											percentage = NULL,
											reverse = FALSE,
											eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_trace_length(eventlog)",
			with = "filter_trace_length(log)")
		log <- eventlog
	}

	bupaR:::apply_grouped_fun(log, fun = filter_trace_length.log, interval, percentage, reverse, .ignore_groups = FALSE, .keep_groups = TRUE, .returns_log = TRUE)
}


#' @keywords internal
#' @rdname ifilter
#' @export ifilter_trace_length
ifilter_trace_length <- function(eventlog) {

	lifecycle::deprecate_warn("0.9.0", "ifilter_trace_length()")

	ui <- miniPage(
		gadgetTitleBar("Filter on Trace Length"),
		miniContentPanel(
			fillCol(
				fillRow(
					radioButtons("filter_type", "Filter type:", choices = c("Interval" = "int", "Use percentile cutoff" = "percentile")),
					radioButtons("reverse", "Reverse filter: ", choices = c("Yes","No"), selected = "No")
				),
				uiOutput("filter_ui")
			)
		)
	)

	server <- function(input, output, session){

		output$filter_ui <- renderUI({
			if(input$filter_type == "int") {
				sliderInput("interval_slider", "Process time interval",
							min = min(eventlog %>% group_by_case %>%
									  	summarize(n = n_distinct(!!activity_instance_id_(eventlog))) %>%
									  	pull(n)),
							max = max(eventlog %>% group_by_case %>%
									  	summarize(n = n_distinct(!!activity_instance_id_(eventlog))) %>%
									  	pull(n)),
							value = c(-Inf,Inf), step = 1)

			}
			else if(input$filter_type == "percentile") {
				sliderInput("percentile_slider", "Percentile cut off:", min = 0, max = 100, value = 80)
			}
		})

		observeEvent(input$done, {
			if(input$filter_type == "int")
				filtered_log <- filter_trace_length(eventlog,
													   interval = input$interval_slider,
													   reverse = ifelse(input$reverse == "Yes", T, F))
			else if(input$filter_type == "percentile") {
				filtered_log <- filter_trace_length(eventlog,
													   percentage = input$percentile_slider/100,
													   reverse = ifelse(input$reverse == "Yes", T, F))
			}

			stopApp(filtered_log)
		})
	}
	runGadget(ui, server, viewer = dialogViewer("Filter Trace Length", height = 400))

}
