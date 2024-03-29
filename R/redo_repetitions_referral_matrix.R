
#' @title Referral matrix repetitons
#'
#' @description Provides a list of initatiors and completers of  redo repetitons
#'
#'
#'
#'
#' @inherit activity_frequency params references seealso return
#' @seealso \code{\link{number_of_repetitions}}
#'
#' @concept metrics_repetition
#'
#' @export
#'
redo_repetitions_referral_matrix <- function(log, eventlog = deprecated()) {
	UseMethod("redo_repetitions_referral_matrix")
}

#' @describeIn redo_repetitions_referral_matrix Compute matrix for eventlog
#' @export

redo_repetitions_referral_matrix.eventlog <- function(log, eventlog = deprecated()) {
	first_resource <- NULL
	last_resource <- NULL

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "redo_repetitions_referral_matrix(eventlog)",
			with = "redo_repetitions_referral_matrix(log)")
		log <- eventlog
	}

	log %>%
		redo_repetitions() %>%
		group_by(first_resource, last_resource) %>%
		summarize(absolute = n()) -> output

	class(output) <- c("referral_matrix", class(output))
	attr(output, "type") <- "repetitions"
	attr(output, "mapping") <- mapping(log)

	return(output)
}

#' @describeIn redo_repetitions_referral_matrix Compute matrix for activitylog
#' @export
#'
redo_repetitions_referral_matrix.activitylog <- function(log, eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn(
			when = "0.9.0",
			what = "redo_repetitions_referral_matrix(eventlog)",
			with = "redo_repetitions_referral_matrix(log)")
		log <- eventlog
	}

	log %>%
		to_eventlog() %>%
		redo_repetitions_referral_matrix()
}


