% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_infrequent_flows.R
\name{filter_infrequent_flows}
\alias{filter_infrequent_flows}
\alias{filter_infrequent_flows.eventlog}
\alias{filter_infrequent_flows.grouped_eventlog}
\alias{filter_infrequent_flows.activitylog}
\alias{filter_infrequent_flows.grouped_activitylog}
\title{Filter Infrequent Flows}
\usage{
filter_infrequent_flows(log, min_n = 2, eventlog = deprecated())

\method{filter_infrequent_flows}{eventlog}(log, min_n = 2, eventlog = deprecated())

\method{filter_infrequent_flows}{grouped_eventlog}(log, min_n = 2, eventlog = deprecated())

\method{filter_infrequent_flows}{activitylog}(log, min_n = 2, eventlog = deprecated())

\method{filter_infrequent_flows}{grouped_activitylog}(log, min_n = 2, eventlog = deprecated())
}
\arguments{
\item{log}{\code{\link[bupaR]{log}}: Object of class \code{\link[bupaR]{log}} or derivatives (\code{\link[bupaR]{grouped_log}}, \code{\link[bupaR]{eventlog}}, \code{\link[bupaR]{activitylog}}, etc.).}

\item{min_n}{\code{\link{numeric}} (default \code{2}): Cases containing a flow that occurs less than \code{min_n} times are discarded.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\value{
When given an object of type \code{\link[bupaR]{log}}, it will return a filtered \code{\link[bupaR]{log}}.
When given an object of type \code{\link[bupaR]{grouped_log}}, the filter will be applied in a stratified way (i.e. each separately for each group).
The returned log will be grouped on the same variables as the original log.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Filter cases based on infrequent flows.
}
\section{Methods (by class)}{
\itemize{
\item \code{filter_infrequent_flows(eventlog)}: Filters infrequent flows for an \code{\link[bupaR:eventlog]{eventlog}}.

\item \code{filter_infrequent_flows(grouped_eventlog)}: Filters infrequent flows for a \code{\link[bupaR:grouped_eventlog]{grouped_eventlog}}.

\item \code{filter_infrequent_flows(activitylog)}: Filters infrequent flows for an \code{\link[bupaR:activitylog]{activitylog}}.

\item \code{filter_infrequent_flows(grouped_activitylog)}: Filters infrequent flows for a \code{\link[bupaR:grouped_activitylog]{grouped_activitylog}}.

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
\code{\link{filter_lifecycle}()},
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
\concept{filters_case}
