% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/resource_specialisation.R
\name{resource_specialisation}
\alias{resource_specialisation}
\alias{resource_specialization}
\alias{resource_specialisation.log}
\alias{resource_specialisation.grouped_log}
\title{Resource Specialisation}
\usage{
resource_specialisation(
  log,
  level = c("log", "activity", "resource"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

resource_specialization(
  log,
  level = c("log", "activity", "resource"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{resource_specialisation}{log}(
  log,
  level = c("log", "activity", "resource"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)

\method{resource_specialisation}{grouped_log}(
  log,
  level = c("log", "activity", "resource"),
  append = deprecated(),
  append_column = NULL,
  sort = TRUE,
  eventlog = deprecated()
)
}
\arguments{
\item{log}{\code{\link[bupaR]{log}}: Object of class \code{\link[bupaR]{log}} or derivatives (\code{\link[bupaR]{grouped_log}}, \code{\link[bupaR]{eventlog}}, \code{\link[bupaR]{activitylog}}, etc.).}

\item{level}{\code{\link{character}} (default \code{"log"}): Level of granularity for the analysis: \code{"log"} (default),
, \code{"activity"}, or \code{"resource"}. For more information, see \code{vignette("metrics", "edeaR")} and 'Details' below.}

\item{append}{\code{\link{logical}} (default \code{FALSE}) \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}: The arguments \code{append} and \code{append_column}
have been deprecated in favour of \code{\link{augment}}.\cr
Indicating whether to append results to original log. Ignored when level is \code{"log"} or \code{"trace"}.}

\item{append_column}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}} The arguments \code{append} and \code{append_column} have been deprecated in favour of \code{\link{augment}}.\cr
Which of the output columns to append to log, if \code{append = TRUE}. Default column depends on chosen level.}

\item{sort}{\code{\link{logical}} (default \code{TRUE}): Sort output on count. Only for levels with frequency count output.}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\description{
Analyses whether resources specialise in specific activities.

This metric can give an overview of which resources are performing certain activities more than others, and which resources
are responsible for containing all knowledge or capabilities on one topic.
}
\details{
Argument \code{level} has the following options:
\itemize{
\item At \code{"log"} level, this metric provides summary statistics on the number of distinct activities executed per resource.
\item On \code{"activity"} level, this metric provides an overview of the absolute and relative number of different resources
executing this activity within the complete log. This will give insights into which activities resources are specialised in.
\item On \code{"resource"} level, this metric shows the absolute and relative number of distinct activities that each resource executes.
}
}
\section{Methods (by class)}{
\itemize{
\item \code{resource_specialisation(log)}: Computes the resource specialisation for a \code{\link[bupaR]{log}}.

\item \code{resource_specialisation(grouped_log)}: Computes the resource specialisation for a \code{\link[bupaR]{grouped_log}}.

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
\code{\link{start_activities}()},
\code{\link{throughput_time}()},
\code{\link{trace_coverage}()},
\code{\link{trace_length}()}
}
\concept{metrics}
\concept{metrics_organizational}
