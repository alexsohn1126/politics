#### Preamble ####
# Purpose: Downloads and saves the data from harvard server
# Author: Moohaeng Sohn
# Date: March 5th, 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(dataverse)

#### Download data ####
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, gender, educ)

write_csv(ces2020, "data/raw_data/ces2020.csv")

