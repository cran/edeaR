% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trace_length.R
\name{trace_length}
\alias{trace_length}
\alias{trace_length.eventlog}
\alias{trace_length.grouped_eventlog}
\alias{trace_length.activitylog}
\alias{trace_length.grouped_activitylog}
\title{Trace Length}
\usage{
trace_length(
  log,
  level = c("log", "trace", "case"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{trace_length}{eventlog}(
  log,
  level = c("log", "trace", "case"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{trace_length}{grouped_eventlog}(
  log,
  level = c("log", "trace", "case"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{trace_length}{activitylog}(
  log,
  level = c("log", "trace", "case"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{trace_length}{grouped_activitylog}(
  log,
  level = c("log", "trace", "case"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)
}
\arguments{
\item{log}{\code{\link[bupaR]{log}}: Object of class \code{\link[bupaR]{log}} or derivatives (\code{\link[bupaR]{grouped_log}}, \code{\link[bupaR]{eventlog}}, \code{\link[bupaR]{activitylog}}, etc.).}

\item{level}{\code{\link{character}} (default \code{"log"}): Level of granularity for the analysis: \code{"log"} (default),
\code{"trace"}, or \code{"case"}. For more information, see \code{vignette("metrics", "edeaR")} and \strong{Details} below.}

\item{append}{\code{\link{logical}} (default \code{FALSE}) \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}: The arguments \code{append} and \code{append_column}
have been deprecated in favour of \code{\link{augment}}.\cr
Indicating whether to append results to original log. Ignored when level is \code{"log"} or \code{"trace"}.}

\item{append_column}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}} The arguments \code{append} and \code{append_column} have been deprecated in favour of \code{\link{augment}}.\cr
Which of the output columns to append to log, if \code{append = TRUE}. Default column depends on chosen level.}

\item{sort}{\code{\link{logical}} (default \code{TRUE}): Sort output on count. Only for levels with frequency count output.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\description{
Analysis of trace lengths

This metric provides an overview of the number of activities that occur in each trace.

An important remark is that this metric takes into account each instance of an activity, but not the individual lifecycle events.
}
\details{
Argument \code{level} has the following options:
\itemize{
\item At \code{"log"} level, the summary statistics describing the trace length of cases in an aggregated fashion.
\item On \code{"trace"} level, the trace length of the different process variants or traces in the log are calculated.
\item On \code{"case"} level, the trace lengths for each case are computed.
}
}
\section{Methods (by class)}{
\itemize{
\item \code{trace_length(eventlog)}: Computes trace length for an \code{\link[bupaR]{eventlog}}.

\item \code{trace_length(grouped_eventlog)}: Computes trace length for a \code{\link[bupaR]{grouped_eventlog}}.

\item \code{trace_length(activitylog)}: Computes trace length for an \code{\link[bupaR]{activitylog}}.

\item \code{trace_length(grouped_activitylog)}: Computes trace length for a \code{\link[bupaR]{grouped_activitylog}}.

}}
\references{
Swennen, M. (2018). Using Event Log Knowledge to Support Operational Exellence Techniques (Doctoral dissertation). Hasselt University.
}
\seealso{
Other metrics: 
\code{\link{activity_frequency}()},
\code{\link{activity_presence}()},
\code{\link{end_activities}()},
\code{\link{idle_time}()},
\code{\link{number_of_repetitions}()},
\code{\link{number_of_selfloops}()},
\code{\link{number_of_traces}()},
\code{\link{processing_time}()},
\code{\link{resource_frequency}()},
\code{\link{resource_involvement}()},
\code{\link{resource_specialisation}()},
\code{\link{start_activities}()},
\code{\link{throughput_time}()},
\code{\link{trace_coverage}()}
}
\concept{metrics}
\concept{metrics_structuredness}
