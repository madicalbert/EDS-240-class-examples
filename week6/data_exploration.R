#load libraries
library(tidyverse)
library(here)
library(readxl)
library(janitor)

#load data
cts_data_2022 <- read_excel(here("data/clean_cts_data/Data_CTS-CRLF TrappingData_2023-2024.xlsx")) %>% 
  clean_names()
cts_data_2010 <- read_excel(here("data/clean_cts_data/Copy of CTS_2010-2021.xlsx")) %>% 
  clean_names()

#clean up data 
cts_2010 <- cts_data_2010 %>% 
  select(date, site, species_6, species_7, class, weight, svl, tl) %>% 
  rename(species = species_6,
         scientific_name = species_7,
         age_class = class)

cts_2022 <- cts_data_2022 %>% 
  select(date, site, species, scientific_name, age_class, weight_grams, sv_mm, tl_mm) %>%
  rename(svl = sv_mm, 
         tl = tl_mm,
         weight = weight_grams) %>% 
  mutate(svl = as.numeric(svl)) %>% 
  drop_na()

#combine data
cts <- bind_rows(cts_2010, cts_2022)


#data exploration
#summary of data
summary(cts)
