---
title: "Assignment: Hello R, hello GitHub"
toc: true
toc_label: In this worksheet
---

This worksheet introduces you to R, R scripts and R markdown. Your submission will be pushed to your class repository at GitHub. After completion you should have gained some experience in running R commands within scripts, R markdown for running code and documentation within one file and Git/GitHub.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/) — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/) — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads) environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/).

## Your first learning log assignment with R markdown and GitHub
Within this module, we will use R or R markdown files for submitting the solutions of worksheets like this to your GitHub-based learning log. The R stuff that should you be compiled in the following might be your first contact with R. The same is much more likely true for Git and/or GitHub. 

Don't worry. 

This course is heavily based on problem-oriented working, the deconstruction of a task into simpler to handle pieces and training how to keep the focus on what you actually want at the end of the road. If you remember that, jump head first into the problem solving task and help others in finding a solution, you will intensively train and build up your skills and confidence level in your data analysis proficiency. And remember: Internet search engines are your friend.

## A note on learning log assignments with GitHub
Many of the assignments in our courses have to be submitted to GitHub. To initialize the repository at GitHub, we use its classroom assignment functionality. In general you will work with two types of assignment:

  * individual assignments: you will have to submit your own solution to your own classroom respository at GitHub. Don't get confused about "your own repository". Once you have a GitHub account, you can create as many respositories as you like at your account but for assignments within our courses, always use the respective classroom repository.
  
  * team assignments: you will have to submit your solution as a team to the team classroom repository at GitHub.
  
Both your individual and team repositories will be created automatically by following a link to the respective classroom assignments which will be provided by the instructors. They will be hosted as part of GeoMOER, our learning log space at GitHub for Marburg Open Educational Ressources.

To start with, get yourself a GitHub account if you have not one already and create your personal learning log using the link provided by the course lecturers.
{: .notice--info}

Please create the following folder structure in your GitHub checkout: ''data_analysis/unit_01''. Please note that ''unit_01'' is a sub-folder of ''data_analysis'' which in turn is a sub-folder of your main repository folder (i.e. the one you get from the link provided by the lecturers). 

Do not use any spaces within your folder or filenames until you become an expert. **At no time**. **Never**. 
{: .notice--danger}

Now it's time for your first R code which will be put into an R markdown document.

## Programming assignment with GitHub submission
Please write an R script as an Rmd file with html output for the following task and commit it to your GitHub-based learning log:

  * Assign the value of 2 to a variable called ''a'' and the value of 5 to a variable called ''b''.
  * Compute the sum, difference, product and ratio of a and b (a always in the first place) and store the results to four different variables called ''r1'', ''r2'', ''r3'', and ''r4''.
  * Create a vector ''v1'' which contains the values stored within the four variables from step 2.
  * Add a fifth entry to vector ''v1'' which represents ''a'' by the power of ''b'' (i.e. ''a**b'').
  * Show the content of vector ''v1'' (e.g. use the ''print'' function or just type the variable name in a separate row).
  * Create a second vector ''v2'' which contains information on the type of mathematical operation used to derive the five results. Hence this vector should have five entries of values "sum", "difference",...
  * Show the content of vector ''v2''.
  * Combine the two vectors ''v1'' and ''v2'' into a data frame called ''df''. Each vector should become one column of the data frame so you will end up with a data frame having 5 rows and 2 columns.
  * Make sure that the column with the data of ''v1'' is named "Results" and ''v2'' is named "Operation".
  * Show the entire content of ''df''.
  * Show just the entry of the 3 row and 1 column.

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.

As you might become aware by reading this assignment, there is a great chance that you have to gather considerable more information to actually solve the given assignment. More precisely, once you have solved the R programming task you are not be off the hook since you have to familiarize yourself with Git and GitHub to actually submit your solution.
{: .notice--warning}