#' @title Referral matrix selfloops
#'
#' @description Provides a list of initatiors and completers of  redo selfloops
#'

#' @inherit activity_frequency params references seealso return

#' @seealso \code{\link{number_of_selfloops}}

#'
#' @concept metrics_repetition
#'
#' @export
#'
redo_selfloops_referral_matrix <- function(log, eventlog = deprecated()) {
	UseMethod("redo_selfloops_referral_matrix")
}

#' @describeIn redo_selfloops_referral_matrix Compute matrix for eventlog
#' @export

redo_selfloops_referral_matrix.eventlog <- function(log, eventlog = deprecated()) {
	first_resource <- NULL
	last_resource <- NULL

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "redo_selfloops_referral_matrix(eventlog)",
			with = "redo_selfloops_referral_matrix(log)")
		log <- eventlog
	}

	eventlog %>%
		redo_selfloops() %>%
		group_by(first_resource, last_resource) %>%
		summarize(absolute = n()) -> output

	class(output) <- c("referral_matrix", class(output))
	attr(output, "type") <- "selfloop"
	attr(output, "mapping") <- mapping(eventlog)

	return(output)
}

#' @describeIn redo_selfloops_referral_matrix Compute matrix for activitylog
#' @export

redo_selfloops_referral_matrix.activitylog <- function(log, eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "redo_selfloops_referral_matrix(eventlog)",
			with = "redo_selfloops_referral_matrix(log)")
		log <- eventlog
	}

	log %>%
		to_eventlog() %>%
		redo_selfloops_referral_matrix()
}
