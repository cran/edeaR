#' @title Filter Throughput Time
#'
#' @description Filters cases based on their [`throughput_time`].
#'
#' This filter can be used by using an `interval` or by using a `percentage`.
#' The percentage will always start with the shortest cases first and stop
#' including cases when the specified percentile is reached. On the other hand, an absolute
#' interval can be defined instead to filter cases which have a throughput time in this interval. The time units
#' in which this interval is defined can be supplied with the `units` argument.
#'
#' @inherit filter_activity params references seealso return
#' @inherit filter_processing_time params
#'
#' @seealso [`throughput_time()`],[`difftime()`]
#'
#' @family filters
#'
#' @concept filters_case
#'
#' @export filter_throughput_time
filter_throughput_time <- function(log,
								   interval = NULL,
								   percentage = NULL,
								   reverse = FALSE,
								   units = c("secs", "mins", "hours", "days", "weeks"),
								   eventlog = deprecated()) {
	UseMethod("filter_throughput_time")
}

#' @describeIn filter_throughput_time Filters cases for a [`log`][`bupaR::log`].
#' @export
filter_throughput_time.log <- function(log,
									   interval = NULL,
									   percentage = NULL,
									   reverse = FALSE,
									   units = c("secs", "mins", "hours", "days", "weeks"),
									   eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_processing_time(eventlog)",
			with = "filter_processing_time(log)")
		log <- eventlog
	}

	units <- rlang::arg_match(units)

	check_interval_percentage_args(interval, percentage)

	if(!is.null(percentage))
		filter_throughput_time_percentile(log,
										  percentage = percentage,
										  reverse = reverse)
	else
		filter_throughput_time_threshold(log,
										 lower_threshold = interval[1],
										 upper_threshold = interval[2],
										 reverse = reverse,
										 units = units)
}

#' @describeIn filter_throughput_time Filters cases for a [`grouped_log`][`bupaR::grouped_log`].
#' @export
filter_throughput_time.grouped_log <- function(log,
											   interval = NULL,
											   percentage = NULL,
											   reverse = FALSE,
											   units = c("secs", "mins", "hours", "days", "weeks"),
											   eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "filter_processing_time(eventlog)",
			with = "filter_processing_time(log)")
		log <- eventlog
	}

	bupaR:::apply_grouped_fun(log, fun = filter_throughput_time.log, interval, percentage, reverse, units, .ignore_groups = FALSE, .keep_groups = TRUE, .returns_log = TRUE)
	#grouped_filter(eventlog, filter_throughput_time, interval, percentage, reverse, units, ...)
}

#' @keywords internal
#' @rdname ifilter
#' @export ifilter_throughput_time
ifilter_throughput_time <- function(eventlog) {

	lifecycle::deprecate_warn("0.9.0", "ifilter_throughput_time()")

	ui <- miniPage(
		gadgetTitleBar("Filter Througput Time"),
		miniContentPanel(
			fillCol(
				fillRow(
					radioButtons("filter_type", "Filter type:", choices = c("Interval" = "int", "Use percentile cutoff" = "percentile")),
					radioButtons("units", "Time units: ", choices = c("weeks","days","hours","mins"), selected = "hours"),
					radioButtons("reverse", "Reverse filter: ", choices = c("Yes","No"), selected = "No")
				),
				uiOutput("filter_ui")
			)
		)
	)

	server <- function(input, output, session){

		output$filter_ui <- renderUI({
			if(input$filter_type == "int") {
				sliderInput("interval_slider", "Throguhput time interval",
							min = 0, max = max(eventlog %>% throughput_time("case", units = input$units) %>% pull(throughput_time)), value = c(0,1))

			}
			else if(input$filter_type == "percentile") {
				sliderInput("percentile_slider", "Percentile cut off:", min = 0, max = 100, value = 80)
			}
		})

		observeEvent(input$done, {
			if(input$filter_type == "int")
				filtered_log <- filter_throughput_time(eventlog,
													   interval = input$interval_slider,
													   reverse = ifelse(input$reverse == "Yes", TRUE, FALSE),
													   units = input$units)
			else if(input$filter_type == "percentile") {
				filtered_log <- filter_throughput_time(eventlog,
													   percentage = input$percentile_slider/100,
													   reverse = ifelse(input$reverse == "Yes", TRUE, FALSE),
													   units = input$units)
			}

			stopApp(filtered_log)
		})
	}
	runGadget(ui, server, viewer = dialogViewer("Filter Througput Time", height = 400))

}

