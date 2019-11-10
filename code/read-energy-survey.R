# Aim: read in and clean energy survey results

library(tidyverse)
energy_data_original = readxl::read_excel("~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/Chaco energy survey.xlsx") %>% 
  janitor::clean_names()
View(energy_data_original)
d$name
d = energy_data_original %>% 
  slice(-(1:2)) %>% 
  filter(!(str_detect(what_is_your_name, "Mary") 
         & is.na(if_you_know_how_much_gas_your_household_uses_per_year_please_enter_the_amount_below_in_k_wh_or)
         ))
readr::write_csv(d, "~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/energy-survey-clean.csv")

# preliminary analysis
ggplot(d) +
  geom_bar(aes(current_number_of_adults_living_in_your_house))

d %>% ggplot() +
  geom_bar(aes(current_number_of_children_people_aged_under_16_living_in_your_house))

