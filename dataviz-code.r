# Assignment 3

# Author: Radhika Kaul

# Dataset used: Quality of government dataset

#Summary: Is a compilation of several datasets and consists more than 2000 variables
    
# Exploration of percepetion of corruption practices and its impact on Ease of Doing Business Scores for selected countries.
    
    ### DATA VISUALIZATION PROJECT - ASSIGNMENT 3
    ### Author: Radhika Kaul
    ### Date: 2/14/2020
    ```{r setup, include=FALSE}
  knitr::opts_chunk$set(message = FALSE)
  knitr::opts_chunk$set(warning = FALSE)
  ```
  
  ```{r load-packages}
  library(tidyverse)
  ```
  
  ### Preliminary data exploration
  
  ``` {r load-data}
  
  # Loading the Quality of Government Dataset
  
  # For extra credit assignment
  Data <- read_csv("data/qog_std_cs_jan20.csv")
  class(Data)  ##Determining the class the datasets belong to
  ```
  
  ```{r summary}
  # Mean of Fragile State Index by Region across the world, but names have not transported.
  Data %>%
    group_by(ht_region) %>%
    summarize(FSI_mean = mean(ffp_fsi))
  
  ```
  
  ```{r Loading_Libraries}
  
  # Loading necessary packages
  
  library(tidyverse)
  library(haven)
  ```
  
  ```{r Loading_Data}
  
  # Loading the Quality of Government Dataset
  
  Data_cs <- read_csv("data/qog_std_cs_jan20.csv")
  ```
  
  
  ```{r Plot_1_wrangling}
  # Visualization 1: Correlation b/w Fragile States and Corruption Perception in the country
  
  df_1 <- select(Data_cs, cname, ffp_fsi, ti_cpi, ht_region) 
  
  region_df <- data.frame(ht_region = 1:10, 
                          region = c("Eastern Europe",
                                     "Latin America",
                                     "MENA",
                                     "Sub-Sharan Africa", 
                                     "Western Europe and North America",
                                     "East Asia",
                                     "South East Asia",
                                     "South Asia",
                                     "The Pacific",
                                     "The Caribbean"))
  
  df_1_joined <- left_join(df_1, region_df, by = "ht_region")
  ```
  
  ```{r ggplot_1}
  
  #Creating Plot 1: Comparing fragile states and level of the corruption perception
  
  ggplot(df_1_joined, mapping = aes(x = ffp_fsi, 
                                    y = ti_cpi, 
                                    color = region))+
    geom_point()+
    labs(title = paste("Relation between corruption and fragility of states across different \ncountries in the world in 2019 "),
         subtitle = "States with a higher fragility index are associates with higher corruption index",
         caption ="The Quality of Government Standard Dataset(2020).\nThe Quality of Government Institute \nFSI=0(least corrupt); FSI=100(most corrupt)\nCPI=0(most corrupt);CPI=100(least corrupt)",         
         x = "Fragile States Index",
         y = "Corruption \nPerceptions Index",
         color = "Region")+
    scale_x_continuous(limits=c(0,120),
                       breaks=c(0, 30, 60, 90, 120))+
    scale_y_continuous(limits=c(0,100),
                       breaks= c(0, 20, 40, 60, 80, 100))+
    theme_minimal()+
    theme(axis.title.x=element_text(hjust=+0.5),
          axis.title.y=element_text(angle=0, hjust=+1, vjust = 0.5),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          axis.title = element_text(face = "bold"),
          axis.text.x = element_text(angle = 0),
          axis.text.y = element_text(angle = 0),
          axis.line.x = element_line(linetype = "solid"),
          axis.line.y = element_line(linetype = "solid"),
          axis.ticks.x = element_line(),
          axis.ticks.y = element_line(),
          plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"))
  ```
  
  #### The above graph shows how corruption and its implications in international business trading and investments represent an increasing interest for policymakers. Corruption is mostly studied with respect to economic welfare indicators such as per capita GDP, however, it also is a contributing factor in influencing doemestic entrpreneurship practices and foreign investment in country.
  
  #### Purpose of expressing the above graph with the fragile state index was to explore that due to weak institutions characterized by the high FSI score, it is more likely, on average to plauged by corrupt practices more often, thus hindering any emergence of healthy business practices.
  
  ```{r plot_2_wrangling}
  
  #Limiting data to 10 countries and for years between 2012 and 2019, from the time series dataset.
  
  Data_ts <- read_csv("data/qog_std_ts_jan20.csv")
  Data_ts_new <- Data_ts %>%
    filter(cname %in% c("Afghanistan", "Pakistan", "United States", "Germany", "Saudi Arabia", "Turkey", "India", "China", "South Sudan")) %>%
    filter(year>2011)
  
  ```
  
  ```{r create_dataframe}
  
  #Create a dataframe for region for now.
  
  region_df <- data.frame(ht_region = 1:10, 
                          region = c("Eastern Europe",
                                     "Latin America",
                                     "MENA",
                                     "Sub-Sharan Africa", 
                                     "Western Europe and North America",
                                     "East Asia",
                                     "South East Asia",
                                     "South Asia",
                                     "The Pacific",
                                     "The Caribbean"))
  
  df_2_joined <- left_join(Data_ts_new, region_df, by = "ht_region")
  
  df_2_joined$year <- as.character(df_2_joined$year)
  df_2_joined$year <- as.factor(df_2_joined$year)
  df_2_joined$cname <-as.factor(df_2_joined$cname)
  df_2_joined <- select(df_2_joined, cname, year, ti_cpi, ht_region, region)
  ```
  
  ```{r plot_2_plot}
  
  #Creating Plot 2: Change in Corruption Index across years.
  
  ggplot(df_2_joined, aes(x= year , 
                          y=ti_cpi,
                          color = cname,
                          group = cname))+
    geom_path(size = 1)+
    geom_point(size = 1.5)+
    scale_color_brewer(palette = "Set1")+
    theme_minimal()+
    theme(axis.title.x=element_text(hjust=+0.5),
          axis.title.y=element_text(angle=0, hjust=+1, vjust = 0.5),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          axis.title = element_text(face = "bold"),
          axis.text.x = element_text(angle = 0),
          axis.text.y = element_text(angle = 0),
          axis.line.x = element_line(linetype = "solid"),
          axis.line.y = element_line(linetype = "solid"),
          axis.ticks.x = element_line(),
          axis.ticks.y = element_line(),
          plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"))+
    labs(title = paste("Corruption Perception Indices over time for selected \ncountries between years 2012-2019 "),
         subtitle = "The CPI generally defines corruption as the misuse of public power \nfor private benefit.The CPI currently ranks 176 countries \non a scale of 100(very clean) to 0(highly corrupt)",
         caption ="Source:The Quality of Government Standard Dataset(2020).",
         fill = "Country",
         x = "Year",
         y = "Corruption \nPerceptions Index ")
  ```
  
  #### The above graph represents the trajectly of corruption indices for 10 countries overtime. We can observe that Saudi Arabia seems to have experienced an improvement in the corruption score overtime, while Turkey observes the steepest decline among all countries. Turkey currently suffers from an annual inflation rate of 20.3% and the government in a bid to retain its power decided to boost consumer credit by subsidizing fruits and vegetables in the wholesale market in the run-up to the 2019 elections. Not surprising, it observes a relatively high Ease of Doing Business score, expressed in Plot 3, because the government strong-arms the local and state-owned banks to keep the lending rates artifically low so that the corporate sector backing the incumbent government stands to benefit from this arrangement(Bircan and Saka 2017).
  
  #### Higher values for both indices and a smaller gap may be indicative of a robust entrepreneurial sector in a country.
  
  
  ```{r plot_3_libraries}
  
  #Loading necessary packages
  
  library(ggalt)
  library(tidyr)
  library(readxl)
  ```
  
  ```{r plot3_wrangling}
  
  # Creating a dumbbell plot.
  
  #Loading datasets
  Data_cs <- read_csv("data/qog_std_cs_jan20.csv")
  eodb <- read_excel("data/eodb.xlsx")
  
  #Joining the Ease of doing Business data onto to the Quality of Government Data
  df_3_joined <- left_join(Data_cs, eodb, by = "cname")
  
  #Selecting variables required for the visualizations
  df_3_joined <- select(df_3_joined, cname, wdi_pop, DB_2019, ti_cpi)
  df_3_joined <- df_3_joined  %>%
    filter(cname %in% c("Afghanistan", "Pakistan", "United States", "Germany", "Saudi Arabia", "Turkey", "India", "China", "South Sudan"))
  ```
  
  
  ```{r tidy data}  
  #Converting data for tidy format to generate a legend
  df_3_joined_long <- gather(df_3_joined, key = cpi_eodb, value = value, 3:4)
  
  index <- data.frame(cpi_eodb = c("DB_2019", "ti_cpi"), 
                      index_2019 = c("Ease of Doing Business Score",
                                     "Corruption Perception Index"))
  
  df_3_final <- left_join(df_3_joined_long, index, by = "cpi_eodb")
  ```
  
  
  ```{r [plot_3]}
  
  #Creating Plot 3: Gap b/w EoDB and CPI scores across differnt countries.
  
  ggplot(df_3_joined) +
    geom_point(data = df_3_final, aes(x = value, 
                                      y = cname,
                                      color = index_2019), size = 2)+
    scale_color_manual(name = "Index value", values = c("blue", "red"))+
    geom_dumbbell(data = df_3_joined,aes(y = cname,
                                         x = ti_cpi, xend = DB_2019),
                  colour = "#D8D8D8", size = 1.5,
                  colour_x = "blue", colour_xend = "red")+
    scale_x_continuous(limits = c(0,100), 
                       breaks = c(0,20, 40, 60, 80, 100))+
    theme_minimal()+
    theme(axis.text.x = element_text(angle = 0),
          axis.text.y = element_text(angle = 0),
          panel.spacing = unit (1.5, "lines"),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_line(linetype = "dashed"),
          axis.line.x = element_line(linetype = "solid"),
          axis.ticks.x = element_line(),
          plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"))+
    labs(x = "Index values",
         y = "Countries",
         caption = "Source:The Quality of Government Standard Dataset(2020).",
         title = "Lower values of Ease of Doing Business Scores usually \nfollows countries with bad corruption practices.",
         subtitle = "Germany is surpisingly the only country that despite being less corrupt, has a lesser EoDB score.\nLargest gap  between the two indices is observed for Turkey and China.")
  ```
  

    
