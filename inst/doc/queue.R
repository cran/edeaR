## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning = F-------------------------------------------------------
library(edeaR)
library(dplyr)

## -----------------------------------------------------------------------------
library(eventdataR)
calculate_queuing_times(sepsis) -> queuing_times

## -----------------------------------------------------------------------------
queuing_times

## -----------------------------------------------------------------------------
library(ggplot2)
#> Warning: package 'ggplot2' was built under R version 3.6.3
queuing_times %>%
  ggplot(aes(activity, time_in_queue)) +
  geom_boxplot()

## -----------------------------------------------------------------------------
queuing_times %>%
  ggplot(aes(resource, time_in_queue)) +
  geom_boxplot()

## -----------------------------------------------------------------------------
queuing_times %>%
  filter(resource != "?") %>%
  ggplot(aes(resource, time_in_queue)) +
  geom_boxplot()

## -----------------------------------------------------------------------------
queuing_times %>%
  calculate_queuing_length(time_interval = "week")

## -----------------------------------------------------------------------------
queuing_times %>%
  calculate_queuing_length(time_interval = "week") %>%
  ggplot(aes(date, queue_length)) +
  geom_line()

## -----------------------------------------------------------------------------
queuing_times %>%
  calculate_queuing_length(time_interval = "week", level = "resource") 
queuing_times %>%
  calculate_queuing_length(time_interval = "week", level = "activity") 

## -----------------------------------------------------------------------------
queuing_times %>%
  filter(resource != "?") %>%
  calculate_queuing_length(time_interval = "week", level = "resource") %>%
  ggplot(aes(date, queue_length, color = resource)) +
  geom_line()

## -----------------------------------------------------------------------------
queuing_times %>%
  filter(resource != "?") %>%
  calculate_queuing_length(time_interval = "month", level = "resource") %>%
  ggplot(aes(date, queue_length, color = resource)) +
  geom_line()

## -----------------------------------------------------------------------------
queuing_times %>%
  filter(resource != "?") %>%
  calculate_queuing_length(time_interval = 3, level = "resource") %>%
  ggplot(aes(date, queue_length, color = resource)) +
  geom_line()

