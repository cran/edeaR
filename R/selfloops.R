

selfloops <- function(eventlog) {

	stop_eventlog(eventlog)


	log <- eventlog

	ca <- cases_light(eventlog)

	colnames(log)[colnames(log) == timestamp(eventlog)] <- "timestamp_classifier"
	colnames(log)[colnames(log) == case_id(eventlog)] <- "case_classifier"
	colnames(log)[colnames(log) == activity_id(eventlog)] <- "event_classifier"
	colnames(log)[colnames(log) == activity_instance_id(eventlog)] <- "activity_instance_classifier"



	log %>%
		group_by(case_classifier, event_classifier, activity_instance_classifier) %>%
		summarize(ts = min(timestamp_classifier)) %>%
		group_by(case_classifier) %>%
		arrange(ts) %>%
		mutate(r = row_number(ts), next_event = lead(event_classifier)) %>%
		filter(event_classifier == next_event) %>%
		select(case_classifier, event_classifier, r, ts) %>%
		mutate(length = 1) -> t

	t %>%
		arrange(ts) %>%
		mutate(next_act = lead(event_classifier), next_r = lead(r)) %>%
		mutate(length = ifelse(!is.na(next_act) & event_classifier == next_act & r + 1 == next_r, length + 1, length),
			   remove_next = ifelse(!is.na(next_act) & event_classifier == next_act & r + 1 == next_r, T,F) ) %>%
		mutate(remove = lag(remove_next)) %>%
		filter(!remove | is.na(remove)) %>%
		select(case_classifier, event_classifier, length) -> t

	colnames(t) <- c(case_id(eventlog), activity_id(eventlog), "length")

	t %>%
		merge(ca) %>%
		select_("trace", "length", activity_id(eventlog)) %>%
		unique -> t

	return(t)


	tr <- traces(eventlog)
	output <- data.frame(trace = character(0), length = numeric(0), Activity = character(0) , stringsAsFactors = FALSE)
	r <- 1
	for(i in 1:nrow(tr)) {

		act_seq <- strsplit(tr$trace[i], split = ",")[[1]]
		if(length(act_seq) > 1){
			current_act <- act_seq[1]
			length <- 1
			for(j in 2:length(act_seq)){
				if(current_act == act_seq[j])
					length <- length + 1
				else {
					if(length > 1){
						output <- bind_rows(output, data.frame(t(c(trace = tr$trace[i],length = 9999, Activity = current_act))))
						output$length[r] <- length
						r <- r + 1
					}
					length <- 1
					current_act <- act_seq[j]
				}
			}
			if(length > 1){
				output <- bind_rows(output, data.frame(t(c(trace = tr$trace[i],length = 9999, Activity = current_act))))
				output$length[r] <- length
				r <- r + 1
			}
		}
	}
	output <- tbl_df(output)
	colnames(output)[colnames(output) == "Activity"] <- activity_id(eventlog)
	return(output)
}
