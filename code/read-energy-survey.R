# Aim: read in and clean energy survey results

nrow(readr::read_csv("~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/energy-survey-clean.csv"))

library(tidyverse)
energy_data_original = readxl::read_excel("~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/Chaco energy survey.xlsx") %>% 
  janitor::clean_names()
View(energy_data_original)
d = energy_data_original %>% 
  slice(-(1:2)) %>% 
  filter(!(str_detect(what_is_your_name, "Mary|Burj") # duplicates
         & is.na(if_you_know_how_much_gas_your_household_uses_per_year_please_enter_the_amount_below_in_k_wh_or)
         )) %>% 
  mutate_at(vars(matches("number")), as.numeric)


# names and % households --------------------------------------------------

hh = read_csv("~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/households.csv")
# View(hh)
nrow(d) / nrow(hh)
nrow(hh) - nrow(d)


d_names_clean = str_replace_all(string = d$what_is_your_name, pattern = "& |and ", replacement = "")
hh_names = word(string = d_names_clean, start = 2, end = 2)

nrow(d)

View(d)

# preliminary analysis ----------------------------------------------------

# number of people
sum(d$current_number_of_adults_living_in_your_house) 
sum(d$current_number_of_children_people_aged_under_16_living_in_your_house, na.rm = TRUE) 


ggplot(d) +
  geom_bar(aes(current_number_of_adults_living_in_your_house))

d %>% ggplot() +
  geom_bar(aes(current_number_of_children_people_aged_under_16_living_in_your_house))



readr::write_csv(d, "~/Dropbox/Chapeltown Cohousing/Energy/energySurvey/energy-survey-clean.csv")