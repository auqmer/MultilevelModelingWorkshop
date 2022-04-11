# ***********************************************************************
# Title: Modeling Math Achievement 
# Author: William Murrah
# Description: Modeling math achievement by ses with MEM.
# Created: Monday, 27 September 2021
# R version: R version 4.1.1 (2021-08-10)
# Project(working) directory: /Users/wmm0017/Projects/Courses/ERMA_Multilevel_Modeling/products/projects/HighSchoolBeyond
# ***********************************************************************

# Load mixed-effects package
library(psych)
library(nlme)

# Explore the data --------------------------------------------------------

hist(hsb$mathach, breaks = "fd")
boxplot(hsb$mathach)

hist(hsb$ses, breaks = "fd")
boxplot(hsb$ses)

describe(hsb[ ,c("mathach", "ses")])

plot(mathach ~ ses, data = hsb)
# Modeling Math Achievement and SES ---------------------------------------


# First create a model ignoring the nested structure
complete.pool.model <- lm(mathach ~ ses, data = hsb)
summary(complete.pool.model)

# Plot the residuals of the complete.pooling.model
plot(resid(complete.pool.model) ~ predict(complete.pool.model))
abline(h = 0, col = "red")

# Create a boxplot of the residuals by school in order of median residuals.
resdf <- data.frame(resids = resid(complete.pool.model), school = hsb$school)
school.order <- with(resdf, reorder(school, resids, median, na.rm = TRUE))
boxplot(resids ~ school.order, resdf, main = "Complete Pooling Model")


# Next, create separate models for each school
no.pooling.model <- lmList(mathach ~  ses| school, data = hsb)

no.pooling.model
summary(no.pooling.model)

# Plot residuals
plot(no.pooling.model)
# Plot coefficient 
plot(coef(no.pooling.model))

# Look for patterns in the relation between coefficients
pairs(no.pooling.model, id = 0.01, adj = -.2, xlim = c(0, 22))

# Plot coefficients and their precision 
plot(intervals(no.pooling.model))

# Create a boxplot of the residuals by school in order of median residuals.
resdf <- data.frame(resids = resid(no.pooling.model), school = hsb$school)
school.order <- with(resdf, reorder(school, resids, median, na.rm = TRUE))
boxplot(resids ~ school.order, resdf, main = "No Pooling Model")
# Finally, create a multilevel model

partial.pooling.model <- lme(mathach ~ ses, data = hsb,
                              random = ~ 1 | school)
summary(partial.pooling.model)



# Create a boxplot of the residuals by school in order of median residuals.
resdf <- data.frame(resids = resid(partial.pooling.model), school = hsb$school)
school.order <- with(resdf, reorder(school, resids, median, na.rm = TRUE))
boxplot(resids ~ school.order, resdf, main = "Partial Pooling Model")

partial2 <- lme(mathach ~ ses, data = hsb,
                random = ~ 1 + ses | school)
summary(partial2)
