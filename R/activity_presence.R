#' @title Metric: Activity Presence
#'
#' @description Calculates for each activity type in what percentage of cases it is present.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#'
#' @examples
#'
#' data <- data.frame(case = rep("A",5),
#' activity_id = c("A","B","C","D","E"),
#' activity_instance_id = 1:5,
#' lifecycle_id = rep("complete",5),
#' timestamp = 1:5,
#' resource = rep("resource 1", 5))
#'
#' log <- bupaR::eventlog(data,case_id = "case",
#' activity_id = "activity_id",
#' activity_instance_id = "activity_instance_id",
#' lifecycle_id = "lifecycle_id",
#' timestamp = "timestamp",
#' resource_id = "resource")
#'
#'activity_presence(log)
#'
#' @export activity_presence


activity_presence <- function(eventlog) {
	stop_eventlog(eventlog)

	eventlog %>% rename_("case_classifier" = case_id(eventlog)) %>%
		group_by_(activity_id(eventlog)) %>%
		summarize("absolute" = n_distinct(case_classifier)) %>%
		mutate(relative = absolute/n_cases(eventlog)) %>%
		arrange(-absolute) %>%
	return()
}
