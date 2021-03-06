% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/number_of_selfloops.R
\name{number_of_selfloops}
\alias{number_of_selfloops}
\alias{number_of_selfloops.eventlog}
\alias{number_of_selfloops.grouped_eventlog}
\title{Metric: Number of selfloops in trace}
\usage{
number_of_selfloops(eventlog, type, level, append, ...)

\method{number_of_selfloops}{eventlog}(
  eventlog,
  type = c("all", "repeat", "redo"),
  level = c("log", "case", "activity", "resource", "resource-activity"),
  append = FALSE,
  append_column = NULL,
  sort = TRUE,
  ...
)

\method{number_of_selfloops}{grouped_eventlog}(
  eventlog,
  type = c("all", "repeat", "redo"),
  level = c("log", "case", "activity", "resource", "resource-activity"),
  append = FALSE,
  append_column = NULL,
  sort = TRUE,
  ...
)
}
\arguments{
\item{eventlog}{The dataset to be used. Should be a (grouped) eventlog object.
\code{eventlog}.}

\item{type}{The type of repetitions, either all, repeat or redo.}

\item{level}{Level of granularity for the analysis: log,  case, activity, resource or resource-activity.
For more information, see \code{vignette("metrics", "edeaR")}}

\item{append}{Logical, indicating whether to append results to original event log. Ignored when level is log or trace.}

\item{...}{Deprecated arguments}

\item{append_column}{Which of the output columns to append to log, if append = T. Default column depends on chosen level.}

\item{sort}{Sort output on count. Defaults to TRUE. Only for levels with frequency count output.}
}
\description{
Provides information statistics on the number of selfloops.
}
\details{
Activity instances of the same activity type that are executed more than
once immediately after each other by the same resource are in a self-loop (length-1-loop).
If an activity instance of the same activity type is executed 3 times
after each other by the same resource, this is defined as a size 2 self-loop.

Two types of self-loops are defined, which are repeat self-loops and redo self-loops. Repeat self-loops are
activity executions of the same activity type that are executed immediately following
each other by the same resource. Redo self-loops are activity executions of the
same activity type that are executed immediately following each other by a different
resource. Repeat and redo repetitions are explained further on.

These metrics are presented on five different levels of analysis, which are the
complete event log, cases, activities, resources and resource-activity combinations.

\itemize{

\item On the level of the complete event log, the summary statistics of the
number of self-loops within a trace can give a first insight in the amount of
waste in an event log. As stated earlier, each combination of two occurrences of
the same activity executed by the same resource will be counted as one repeat
	self-loop of this activity.

	\item This metric on the level of cases provides
	an overview of the absolute and relative number of repeat and redo self-loops
	in each case.  To calculate the relative number, each (repeat or
	 redo) self-loop is counted as 1 occurrence, and the other
	 activity instances are also counted as 1.

	 \item On the level of the distinct activities in the event log, the absolute and relative number of self-loops per
	 activity can be an indication for the company which activities are causing the
	 most waste in the process.

	 \item Similar to the metric on the level of the
	 activities, the number of self-loops on the level of the resources executing the
	 activities can give a company insights in which employee needs to repeat his or
	 her work most often within a case, or for which employee the work he or she
	 did should be redone by another employee within the same case. This metric
	 shows the absolute and relative number of both repeat and redo self-loops for
	 each resource in the event log.

 \item Finally, the metric can be applied
 to the level of the specifc resource-activity combinations, in order to get an
 insight in which activities are the most crucial for which resources. This metric
 shows the absolute and relative number of both repeat and redo self-loops for
 each of the resource-activity combinations that occur in the event log. Two
 different relative numbers are provided here, one from the resource perspective
 and one from the activity perspective. At the resource perspective, the denominator
 is the total number of executions by the resource under consideration.
 At the activity perspective, the denominator is the total number of occurrences
 of the activity under consideration.



}
}
\section{Methods (by class)}{
\itemize{
\item \code{eventlog}: Compute number of selfloops for eventlog

\item \code{grouped_eventlog}: Compute number of selfloops for grouped eventlog
}}

\references{
Swennen, M. (2018). Using Event Log Knowledge to Support Operational Exellence Techniques (Doctoral dissertation). Hasselt University.
}
