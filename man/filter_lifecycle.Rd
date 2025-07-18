% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_lifecycle.R
\name{filter_lifecycle}
\alias{filter_lifecycle}
\alias{filter_lifecycle.eventlog}
\alias{filter_lifecycle.grouped_eventlog}
\title{Filter Life Cycle}
\usage{
filter_lifecycle(
  log,
  lifecycles,
  reverse = FALSE,
  lifecycle = deprecated(),
  eventlog = deprecated()
)

\method{filter_lifecycle}{eventlog}(
  log,
  lifecycles,
  reverse = FALSE,
  lifecycle = deprecated(),
  eventlog = deprecated()
)

\method{filter_lifecycle}{grouped_eventlog}(
  log,
  lifecycles,
  reverse = FALSE,
  lifecycle = deprecated(),
  eventlog = deprecated()
)
}
\arguments{
\item{log}{\code{\link[bupaR]{eventlog}}: Object of class \code{\link[bupaR]{eventlog}} or derivatives (\code{\link[bupaR]{grouped_eventlog}}).}

\item{lifecycles}{\code{\link{character}} vector: A vector of life cycle identifiers.}

\item{reverse}{\code{\link{logical}} (default \code{FALSE}): Indicating whether the selection should be reversed.}

\item{lifecycle}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{lifecycles} instead.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\value{
When given an object of type \code{\link[bupaR]{log}}, it will return a filtered \code{\link[bupaR]{log}}.
When given an object of type \code{\link[bupaR]{grouped_log}}, the filter will be applied in a stratified way (i.e. each separately for each group).
The returned log will be grouped on the same variables as the original log.
}
\description{
Filters the log based on the life cycle identifier.
}
\section{Methods (by class)}{
\itemize{
\item \code{filter_lifecycle(eventlog)}: Filters based on life cycle identifiers for an \code{\link[bupaR]{eventlog}}.

\item \code{filter_lifecycle(grouped_eventlog)}: Filters based on life cycle identifiers a \code{\link[bupaR]{grouped_eventlog}}.

}}
\references{
Swennen, M. (2018). Using Event Log Knowledge to Support Operational Exellence Techniques (Doctoral dissertation). Hasselt University.
}
\seealso{
\code{\link[bupaR]{lifecycle_id}}

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
\code{\link{filter_lifecycle_presence}()},
\code{\link{filter_precedence}()},
\code{\link{filter_precedence_condition}()},
\code{\link{filter_precedence_resource}()},
\code{\link{filter_processing_time}()},
\code{\link{filter_resource}()},
\code{\link{filter_resource_frequency}()},
\code{\link{filter_throughput_time}()},
\code{\link{filter_time_period}()},
\code{\link{filter_trace}()},
\code{\link{filter_trace_frequency}()},
\code{\link{filter_trace_length}()},
\code{\link{filter_trim}()},
\code{\link{filter_trim_lifecycle}()}
}
\concept{filters}
\concept{filters_event}
