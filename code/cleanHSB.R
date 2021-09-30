# ***********************************************************************
# Title: Clean High School and Beyond data
# Author: William Murrah
# Description: prepare hsb data for mixed-effects models.
# Created: Monday, 27 September 2021
# R version: R version 4.1.1 (2021-08-10)
# Project(working) directory: /Users/wmm0017/Projects/Courses/
#  ERMA_Multilevel_Modeling
# ***********************************************************************

# Import raw data
hsb <- read.csv("data/hsb.csv", header = TRUE)


# Transform categorical variables in hsb data frame
hsb <- transform(hsb,
                 school = factor(school),
                 minority = factor(minority, 
                                   levels = c(0, 1),
                                   labels = c("non-minority", "minority")),
                 female = factor(female, 
                                 levels = c(0,1),
                                 labels = c("male", "female")),
                 sector = factor(sector, 
                                 levels = c(0, 1),
                                 labels = c("public", "Catholic")),
                 himinty = factor(himinty,
                                  levels = c(0, 1),
                                  labels = c("Less than 40 percent minority",
                                             "More than 40 percent minority"))
                 )

