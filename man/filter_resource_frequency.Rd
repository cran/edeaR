% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_resource_frequency.R
\name{filter_resource_frequency}
\alias{filter_resource_frequency}
\alias{filter_resource_frequency.log}
\alias{filter_resource_frequency.grouped_log}
\title{Filter Resource Frequency}
\usage{
filter_resource_frequency(
  log,
  interval = NULL,
  percentage = NULL,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_resource_frequency}{log}(
  log,
  interval = NULL,
  percentage = NULL,
  reverse = FALSE,
  eventlog = deprecated()
)

\method{filter_resource_frequency}{grouped_log}(
  log,
  interval = NULL,
  percentage = NULL,
  reverse = FALSE,
  eventlog = deprecated()
)
}
\arguments{
\item{log}{\code{\link[bupaR]{log}}: Object of class \code{\link[bupaR]{log}} or derivatives (\code{\link[bupaR]{grouped_log}}, \code{\link[bupaR]{eventlog}}, \code{\link[bupaR]{activitylog}}, etc.).}

\item{percentage, interval}{The target coverage of activity instances. Provide either \code{percentage} or \code{interval}.\cr
\code{percentage} (\code{\link{numeric}}): A percentile of p will return the most common resource types of the log,
which account for at least p\% of the activity instances.\cr
\code{interval} (\code{\link{numeric}} vector of length 2): A resource frequency interval. Half open interval can be created using \code{\link{NA}}.\cr
For more information, see 'Details' below.}

\item{reverse}{\code{\link{logical}} (default \code{FALSE}): Indicating whether the selection should be reversed.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\value{
When given an object of type \code{\link[bupaR]{log}}, it will return a filtered \code{\link[bupaR]{log}}.
When given an object of type \code{\link[bupaR]{grouped_log}}, the filter will be applied in a stratified way (i.e. each separately for each group).
The returned log will be grouped on the same variables as the original log.
}
\description{
Filters the log based on frequency of resources
}
\details{
Filtering the log based on resource frequency can be done in two ways: using an \code{interval} of allowed frequencies,
or specify a coverage \code{percentage}:

\itemize{
\item \code{percentage}: When filtering using a percentage p\%, the filter will return p\% of the activity instances,
starting from the resource labels with the highest frequency. The filter will retain additional resource labels
as long as the number of activity instances does not exceed the percentage threshold.
\item \code{interval}: When filtering using an interval, resource labels will be retained when their absolute frequency fall in this interval.
The interval is specified using a numeric vector of length 2. Half open intervals can be created by using \code{\link{NA}},
e.g., \code{c(10, NA)} will select resource labels which occur 10 times or more.
}
}
\section{Methods (by class)}{
\itemize{
\item \code{filter_resource_frequency(log)}: Filters resources for a \code{\link[bupaR]{log}}.

\item \code{filter_resource_frequency(grouped_log)}: Filters resources for a \code{\link[bupaR]{grouped_log}}.

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
