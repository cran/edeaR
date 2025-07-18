% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_time_period.R
\name{filter_time_period}
\alias{filter_time_period}
\alias{filter_time_period.eventlog}
\alias{filter_time_period.grouped_eventlog}
\alias{filter_time_period.activitylog}
\alias{filter_time_period.grouped_activitylog}
\title{Filter Time Period}
\usage{
filter_time_period(
  log,
  interval = NULL,
  filter_method = c("contained", "intersecting", "start", "complete", "trim"),
  force_trim = FALSE,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_time_period}{eventlog}(
  log,
  interval = NULL,
  filter_method = c("contained", "intersecting", "start", "complete", "trim"),
  force_trim = FALSE,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_time_period}{grouped_eventlog}(
  log,
  interval = NULL,
  filter_method = c("contained", "intersecting", "start", "complete", "trim"),
  force_trim = FALSE,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_time_period}{activitylog}(
  log,
  interval = NULL,
  filter_method = c("contained", "intersecting", "start", "complete", "trim"),
  force_trim = FALSE,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_time_period}{grouped_activitylog}(
  log,
  interval = NULL,
  filter_method = c("contained", "intersecting", "start", "complete", "trim"),
  force_trim = FALSE,
  reverse = FALSE,
  eventlog = deprecated()
)
}
\arguments{
\item{log}{\code{\link[bupaR]{log}}: Object of class \code{\link[bupaR]{log}} or derivatives (\code{\link[bupaR]{grouped_log}}, \code{\link[bupaR]{eventlog}}, \code{\link[bupaR]{activitylog}}, etc.).}

\item{interval}{\code{\link[base]{Date}} or \code{\link[base]{POSIXct}} vector: A time interval (vector of length 2
of type \code{\link[base]{Date}} or \code{\link[base]{POSIXct}}). Half-open intervals can be created with \code{\link{NA}}.}

\item{filter_method}{\code{\link{character}} (default \code{"contained"}): Filtering method: \code{"contained"} (default),
\code{"intersecting"}, \code{"start"}, \code{"complete"}, or \code{"trim"}. For more information, see 'Details' below.}

\item{force_trim}{\code{\link{logical}} (default \code{FALSE}): If \code{TRUE} in combination with \code{filter_method}
\code{"trim"}, activity instances on the edges of the interval are cut at the exact edge of the \code{interval}.}

\item{reverse}{\code{\link{logical}} (default \code{FALSE}): Indicating whether the selection should be reversed.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\value{
When given an object of type \code{\link[bupaR]{log}}, it will return a filtered \code{\link[bupaR]{log}}.
When given an object of type \code{\link[bupaR]{grouped_log}}, the filter will be applied in a stratified way (i.e. each separately for each group).
The returned log will be grouped on the same variables as the original log.
}
\description{
Function to filter the log using a time period.
}
\details{
Event data can be filtered by supplying a time window to the method \code{filter_time_period}. There are 5 different
values for \code{filter_method}:

\itemize{
\item \code{"contained"}: Keeps all the events related to cases contained in the time period.
\item \code{"intersecting"}: Keeps all the events related to cases in which at least one event started and/or ended in the time period.
\item \code{"start"}: Keeps all the events related to cases started in the time period.
\item \code{"complete"}: Keeps all the events related to cases complete in the time period.
\item \code{"trim"}: Keeps all the events which started and ended in the time frame.
}
}
\section{Methods (by class)}{
\itemize{
\item \code{filter_time_period(eventlog)}: Filters activity instances for an \code{\link[bupaR]{eventlog}}.

\item \code{filter_time_period(grouped_eventlog)}: Filters activity instances for a \code{\link[bupaR]{grouped_eventlog}}.

\item \code{filter_time_period(activitylog)}: Filters activity instances for an \code{\link[bupaR]{activitylog}}.

\item \code{filter_time_period(grouped_activitylog)}: Filters activity instances for a \code{\link[bupaR]{grouped_activitylog}}.

}}
\references{
Swennen, M. (2018). Using Event Log Knowledge to Support Operational Exellence Techniques (Doctoral dissertation). Hasselt University.
}
\seealso{
Other filters: 
\code{\link{filter_activity}()},
\code{\link{filter_activity_frequency}()},
\code{\link{filter_activity_instance}()},
\code{\link{filter_activity_presence}()},
\code{\link{filter_case}()},
\code{\link{filter_case_condition}()},
\code{\link{filter_endpoints}()},
\code{\link{filter_endpoints_condition}()},
\code{\link{filter_flow_time}()},
\code{\link{filter_idle_time}()},
\code{\link{filter_infrequent_flows}()},
\code{\link{filter_lifecycle}()},
\code{\link{filter_lifecycle_presence}()},
\code{\link{filter_precedence}()},
\code{\link{filter_precedence_condition}()},
\code{\link{filter_precedence_resource}()},
\code{\link{filter_processing_time}()},
\code{\link{filter_resource}()},
\code{\link{filter_resource_frequency}()},
\code{\link{filter_throughput_time}()},
\code{\link{filter_trace}()},
\code{\link{filter_trace_frequency}()},
\code{\link{filter_trace_length}()},
\code{\link{filter_trim}()},
\code{\link{filter_trim_lifecycle}()}
}
\concept{filters}
\concept{filters_event}
