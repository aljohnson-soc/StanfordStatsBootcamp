*Statistics Bootcamp 2019
*Day 4
*Do file created by Amy Johnson
*Last updated: 9/18/19

*Topics: Scatter plots, intro to regression

*These commands go at the top of every .do file
clear all
capture log close
global date: display %tdYYNNDD date(c(current_date), "DMY")
	*Here's an example of the date global that we talked about yesterday.

*Remember to set your working directory!
cd "/Users/amyjohnson/Box Sync/Stanford/Teaching/Bootcamp/" 

*Starting a log file, using the date global
log using "Bootcamp_${date}", append text
	/*Here I'm appending instead of replacing, so that I will just keep adding
	to the bottom of the log file instead of writing over it.
	You can do whatever you want, but I wanted to show you a different option.*/

*Data sets are available in the Bootcamp Box Folder
	*Workshop.dta from Day 1
	*Twitter Celebrities.dta from Day 4
	*Two More Examples.dta from Day 4
	*CPS March 2000.dta from Day 4
*You should save them all to your working directory!

*There are questions below. Please answer them in the .do file or on paper!

*************************
** STATA CODE OVERVIEW ** 
*************************

* y is the dependent variable (y-axis) and x is the independent variable (x-axis)

* graph twoway (scatter y x)

* graph twoway (scatter y x) (lfit y x)

* reg y x

*******************************
** TWITTER CELEBRITY EXAMPLE ** 
*******************************

*Open data set (remember that it needs to be in your working directory)
use "TwitterCelebrities.dta", clear

*Look at data
list
	*the list function works well for small data sets

*Example 1: What is the relationship between how much a celebrity is
*paid for a sponsored tweet and the number of followers they have?

*Create scatterplot with line of best fit
graph twoway (scatter value followers) (lfit value followers), ///
	ytitle("Tweet value, in dollars") ///
	title("Figure 1. Relationship between number of twitter followers and value of sponsored tweets", size(small) color(black) position(6)) ///
	legend(off) graphregion(fcolor(white))

*Run regression
reg value followers

*Write this regression output as an equation.
*E.g. Y = Bo + B1X1


*What is the slope of the regression line? How would you interpret it?


*What is the y-intercept? How would you interpret it?


*What happens if we drop Tia Mowry? How does our regression line change...

graph twoway (scatter value followers) (lfit value followers) ///
			(lfit value followers if celeb != "Tia Mowry"), ///
	ytitle("Tweet value, in dollars") ///
	title("Figure 1. Relationship between number of twitter followers and value of sponsored tweets", size(small) color(black) position(6))  ///
	legend(order(2 "Including Tia Mowry" 3 "Excluding Tia Mowry")) ///
	graphregion(fcolor(white))
		   
*What happens if you drop someone else? Does the regression line change as much?


clear

***********************
** TWO MORE EXAMPLES ** 
***********************

*Set working directory and open data set
use "TwoMoreExamples.dta", clear

*Take a look at our data
list
	*this works less well for larger data sets

*We could also browse our data

*Let's run some initial summary statistics
sum childs
	*What does this tell us?
	
tab drunk
	*What proportion of the sample has ever drank too much?
	
sum hrs1
	*What does this tell us?


*Example 2: What is the relationship between number of children and
*whether one ever gets too drunk?

*Here we have one continuous variable (childs) and one binary variable (drunk)
bysort drunk: sum childs
	*This sorts across categories of drunk and sums the number of children
	*Bysort is a really useful command!

*Create histogram

twoway (histogram childs if drunk==1, w(1) color(ltblue) freq) ///
	(histogram childs if drunk==0, w(1) fcolor (none) lcolor(black) freq), ///
	title("Figure 2. Number of children by whether R ever drinks too much", size(medium small) color(black) position(6)) ///
	legend(order(1 "Drinks Too Much" 2 "Never Drinks Too Much") size(small)) ///
	xline(1.452, lcolor(blue)) ///
	xline(1.77, lcolor(black)) ///
	graphregion(fcolor(white))
	
	*Note the vertical lines for the group means!!

*Run a regression
reg childs drunk

*Write this regression output as an equation.
*E.g. Y = Bo + B1X1

*Interpret the slope (in words)


*How can we use this regression to calculate the group means?


*******************************************************************************

*Example 3: What is the relationship between number of children and
*hours worked?

*Create a scatter plot with a line of best fit showing the relationship

*Run regression
reg hrs1 childs

*Write this regression output as an equation.
*E.g. Y = Bo + B1X1

*Interpret the slope (in words)



*****************************
** MORE THAN ONE PREDICTOR ** This is a preview into multiple regression.
*****************************
*Let's use some data from the 2000 Current Population Survey
use "CPSMarch2000.dta", clear

*I need to clean this up a little bit... 
*Here's some IRL variable creation
generate white = 0
replace white = 1 if race == 100 
generate female = 0 
replace female = 1 if sex == 2 
gen married = 0
replace married = 1 if marst==1
replace married = 1 if marst==2
gen veteran = 0
replace veteran = 1 if vetlast==8
gen citizen_dummy = 0
replace citizen_dummy = 1 if citizen == 0 | citizen == 2

/*Example 4: What if we predict income based on age, race, sex, health status, 
citizenship status, veteran status, and marital status? */

*Run a regression (note syntax for multiple predictors)

reg incwage age white female health citizen_dummy veteran married

*We don't know how to interpret this yet!!! We will learn in 381!

*Write this regression output as an equation.
*E.g. Y = Bo + B1X1 + B2X2 + ... + B3X3


/*Wasn't that annoying??? If only there were another way to write an equation
with lots of predictors... 

There is! Matrix notation! And Rebecca will teach you tomorrow*/

log close
