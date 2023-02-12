# Amzat-Ridwan

# Google Data Analytics Capstone Project
 A case study on How cyclistics Bike sharing company Riders use bike differently 

 


## Intro:


Cyclistic is a fictional company launched in 2016 to provide successful bike sharing system across Chicago. 

Since then, the program has grown to a ﬂeet of 5,824 bicycles that
are geo-tracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the ﬂexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders while Customers
who purchase annual memberships are Cyclistic members. 
 
Although, The Marketing manager believes that Annual members are more profitable than Casual riders and maximising the number of Annual member will be a key strategys to the future growth of the company.

To do that, they needs to understand how member and casual riders use their bike differently.
In this case study, 
As an Analyst, I will be analyzing the available data to identify trends over the year based on user types and bike types to find similarities between Riders behaviour and make recommendation based on insight generated from the analysis to helps marketing to design a marketing strategy in converting Casual Riders to member users.

## Note:
The Case Study was break down into six phases of analysis process

- [Ask](#Ask-Phase)
- [Prepare](#Prepare-Phase)
- [Process](#Process-Phase)
- [Analyze](#Analyze-Phase)
- [Share](#Share-Phase)
- [Act](#Act-Phase) 

## Ask Phase 
__Business Goal__ - The business objectives is to design a marketing strategy aimed at converting casual riders into Annual member rider 

__Business Task__ - The business task is to analyse the dataset to helps in discovering 

- how cyclistic riders use bike differently
- Why would casual rider subscribe for the membership plan and 
- How to use digital media to influence casual riders to become a annual members

__Stakeholder__ - Cyclistic Executive team, Director of marketing

## Prepare phase:
The dataset used was Cyclistic historical trips data and can be found [ here](https://divvy-tripdata.s3.amazonaws.com/index.html)
The data had been made available by motivate international inc under this [license](https://www.divvybikes.com/data-license-agreement)

The dataset was stored in a relational database organised in csv format which can be easily exported into spreadsheet or any other tool for Analysis

Then I proceed in downloading the 12 months dataset from `January 1 to December 31 2021`  and merged it into a single files using command line

For this project I will be using R for the manipulation and Tableau for visualization

## Process Phase:
First, I am going to merged the dataset into one using the below command line

```{cmd}
copy *.csv combined-CSV-files.csv
```
Then, Export it to R studio for further exploration.
The dataset consist of `5595074` observations (rows) and 13 field (columns):

- Ride_id, Rideable_type
- Started_at, Ended_at
- Start_staion_name, start_station_id
- end_station_name, end_station_id
- start_lat, start_lng
- end_lat_end_lng, member_casual

with an approximate number of 106772 null values and 116 negatives value which would be later dealt with in this case study. 
Data consistency, validation and bias check was run, It shows that all data field contain no errors but it has gender and age limitation which would may also affect our analysis findings.
start_lng, start_lat, end_lng, end_lat column was dropped since it would not be useful for the analysis
I, also created six (6) additional field to perform calculation and compare user usage behavior over time 
The __ride_length__ column is the `differences` between __started_at__ and __ended_at__ column

The __Year__, __week_days__, __ride_hours__ and __month__, were extracted from __date__ column using date time function in R 
The __Route__ Column was created from __start_station_name__ and __End_Station_name__ to get top route used by riders

## Analyze Phase:
Further Analysis was conducted, All data anomalies were removed 
All cleaning steps and codes used for Exploratory Data analysis (EDA) was in the file named `Cyclistics_Bike_Share_Analysis` 
## Share Phase:
All findings and Insigth generated was compilled into a slide preparation file  `Cyclistics Bike Share Analysis.pptx`

## Act Phase 
                         TOP 3 RECOMMENDATION BASED ON FINDINGS

__GIVING DISCOUNT TO ANNUAL MEMBER RIDES LONGER THAN 24HRS__

Giving discount on trips length longer than 24hrs for Annual member will attract casual riders to subscribe for membership plan. since most of their trips duration are longer than 24hrs

__BILL BOARD PLACEMENT__
Placing bill board advert on the most widely used ROUTE by casual riders 
Streeter Dr & grand Ave, Millennium Park and Michigan and oak St And
Displaying the benefit of subscribing to Membership plan on bill board 

__WEEKEND BONUS MAIL REMINDER__
Sending mail notification to casual riders on weekend to stand a chance to win a weekend bonus when subscribing to their  Annual membership plan

                      CONCLUSION
- All recommendations are made based on insight generated from analysis conducted
- Additional data like user  Riders’ data (`eg. personal details, address`) will facilitate more targeted marketing strategies
- Personal detail will help to discover  the typical age of a rider and  How does it will influence bike usage
- Rider usage data – asking the riders pertinent questions (eg, via survey) like
Why do they use the bikes?  For work, leisure? might help in determining whether casual riders would be able to subscribe to membership plan

- The Recommendation made may not work for  Casual riders that came for tour since they are not living in Chicago

thanks!
               






