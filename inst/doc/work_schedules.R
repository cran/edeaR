## ----warning = F, message = F-------------------------------------------------
library(edeaR)
create_work_schedule()

## -----------------------------------------------------------------------------
create_work_schedule(start_time = "08:30:00", end_time = "16:00:00")

## -----------------------------------------------------------------------------
create_work_schedule(start_time = "08:30:00", end_time = "16:00:00") %>%
	change_day(5, start_time = "08:30:00", end_time = "13:00:00")

## -----------------------------------------------------------------------------
create_work_schedule(start_time = "08:30:00", end_time = "16:00:00") %>%
	change_day(5, start_time = "08:30:00", end_time = "13:00:00") %>%
	add_fixed_holiday("Belgian National Holiday", 07, 21)

## -----------------------------------------------------------------------------
library(lubridate)
create_work_schedule(start_time = "08:30:00", end_time = "16:00:00") %>%
	change_day(5, start_time = "08:30:00", end_time = "13:00:00") %>%
	add_fixed_holiday("Belgian National Holiday", 07, 21) %>%
	add_floating_holiday("Easter Monday", ymd(c(20170417, 20180402)))

## -----------------------------------------------------------------------------
library(lubridate)
create_work_schedule(start_time = "08:30:00", end_time = "16:00:00") %>%
	change_day(5, start_time = "08:30:00", end_time = "13:00:00") %>%
	add_fixed_holiday("Belgian National Holiday", month =  07, day = 21) %>%
	add_floating_holiday("Easter Monday", dates = ymd(c(20170417, 20180402))) %>%
	add_holiday_periods(from = ymd(20171226), to = ymd(20171231))

## -----------------------------------------------------------------------------
ws <- create_work_schedule(start_time = "08:30:00", end_time = "16:00:00") %>%
	change_day(5, start_time = "08:30:00", end_time = "13:00:00") %>%
	add_fixed_holiday("Belgian National Holiday", month =  07, day = 21) %>%
	add_floating_holiday("Easter Monday", dates = ymd(c(20170417, 20180402))) %>%
	add_holiday_periods(from = ymd(20171226), to = ymd(20171231))

## -----------------------------------------------------------------------------
library(eventdataR)
patients %>% throughput_time()

## -----------------------------------------------------------------------------
patients %>% throughput_time(work_schedule = ws)

## -----------------------------------------------------------------------------
patients %>%
	processing_time(level = "activity")

## -----------------------------------------------------------------------------
patients %>%
	processing_time(level = "activity", work_schedule = ws)

