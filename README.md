# Submission Formula 1 dataset

This folder contains all of my files used for the Data Engeneering 1 Term Project. I built a MySQL schema using the Formula 1 dataset available on Kaggle - https://www.kaggle.com/rohanrao/formula-1-world-championship-1950-2020

## Operational layer

The operational layer contains 6 csv files, all centered around Formula 1 races, which happend between 1950 and 2021. The EER diagram represents a schemawith races table in the middel as a sort of fact tbale.
![alt text](https://github.com/SalgaBeni/TermP_DE1/blob/main/EER.png)
- Status table contains all the different race ending possibilities (Finished, +1 Lap, Brake problem...)
- Results table has the results of every driver by races.
- In Races table the user can find all the Grand Prix names.
- Qualifying table contains all the qualification results.
- Drivers table has all the driver names ever raced in Formula 1.
- In Driver_Stndings table the user can find information about the championships. 

Operational layer was created using the folowing queries: https://github.com/SalgaBeni/TermP_DE1/blob/main/assignmentF1.sql

## Analytics Plan

Analytics plan illustrated in the below picture:
![alt text](https://github.com/SalgaBeni/TermP_DE1/blob/main/analytics_plan.png)
1. Load up the acquired data
2. Create an ETL pipeline to create a data warehouse
3. Create an ETL pipeline to create data marts for three analytical view

## Analytical layer

In the analytical layer I created one central denormalised data warehouse with drivers in each observation in a given years and races. Firstly, I did not transposed quilfying table. With this move I sacrificed information such as the fastest lap times from every Saturdays, it's unnecessary in the context of the task. Secondly, I joined the tables with races, results, driver and ,status taking care on conecting the right races to the right date, when the table had a date dimension. Also, I used races between 2008 and 2020, since the current drivers are on the Formula 1 since 2008 (except Alonso and Räikkönen, but they already retired once). The below figure gives a glimpse of the information stored in the data warehouse.

Analytical layer made by the following queries: https://github.com/SalgaBeni/TermP_DE1/blob/main/ETLtoCREATEdw.sql
![alt text](https://github.com/SalgaBeni/TermP_DE1/blob/main/DW.png)

## Data Marts

### Disqualification_View

This view shows a very intersting statistic, which the number of retirement from a race and the type of it. I did not use those status informacion, which represents finished races (Finished, +1 Lap, +2 Laps). 

### Driver_Develop_View

The goal of this view is that the user can see the names of the drivers, the names of the tracks they raced on and some performance data, which helps to analyze driver development. I took the SUM of got points earned in a year and the average position of the driver. This view is excellent to provide information to analyze and compare driver performance by year. It is verry intrestiong to see, how drivers compare to each other and to himself as well.

### Most_Laps_View

The Most_Laps_View is great to understand how many laps a driver did during a Forumula 1 carrier. I used the SUM of laps by every racing driver. 

Data Marts created by folowwing queries: https://github.com/SalgaBeni/TermP_DE1/blob/main/F1_DataMarkt.sql
