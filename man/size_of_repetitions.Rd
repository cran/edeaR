% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/size_of_repetitions.R
\name{size_of_repetitions}
\alias{size_of_repetitions}
\title{Metric: Size of repetitions}
\usage{
size_of_repetitions(eventlog, type, level_of_analysis, raw = F)
}
\arguments{
\item{eventlog}{The event log to be used. An object of class
\code{eventlog}.}

\item{type}{Type of repetitions, repeat or redo.}

\item{level_of_analysis}{At which level the analysis of selfloops should be performed: log, case, activity, resource, resource-activity.}

\item{raw}{Return raw data (only applicable for log level)}
}
\description{
Provides summary statistics on the sizes of repetitions at the level of activity types, cases, traces or log. A selfloop of size x refers to the occurrence of x consecutive events
of that activity type.
}
