---
title: "Assignments and Working Environment"
toc: true
toc_label: In this info
---

## A note on individual learning log assignments with GitHub
Within this course, you will individually submit your personal solutions for the course assignments to your personal GitHub-hosted learning log, i.e. your personal classroom repository. Don't get confused about "your personal repository". Once you have a GitHub account, you can create as many repositories as you like at your account but for assignments within our courses, always use your respective classroom repository.  

The classroom repository will be created automatically by following a link to the respective classroom assignment which will be provided by the instructors. Your classroom repository will be hosted as part of GeoMOER, our learning log space at GitHub for Marburg Open Educational Ressources.

If not stated otherwise, the deadline for an assignment is the date and time of the next course session. The submissions generally encompass R or R markdown with compiled html files.

To start with, get yourself a GitHub account if you have not one already and create your personal learning log using the link provided by the course lecturers. Be aware that once the learning log repository is created, you will stick to this until the end of the course.
{: .notice--info}

Aside from submitting assignments, you should use your repository for everything related to this course which is a potential subject to version control, team collaboration and issue tracking.
{: .notice--success}


Now it's time for your first R code which will be put into an R markdown document.

## Working environment
For this course, we do not provide a mandatory template for your working environment. However it is a good idea to have something like this:

  * top level folder for this course, e.g. *<some-path-to-your-data-disk>\data_analysis*,
  * a *data* folder within your top level folder which also contains a *tmp* folder for temporary files and different subfolders for datasets and/or assignments within this course,
  * a folder for your personal GitHub classroom repository and different subfolders within, one for each assignment and one for scripts and functions which are useful for more than one assignment.
  
Hence, your data structure could look like this:

```yaml
<some-path-to-your-data-disk>\data_analysis
  |-- data
    |-- assignment01
    |-- assignment02
    |-- ...
    |-- tmp
  |-- <your-github-learning-log-repository>
    |-- assignment01
    |-- assignment02
    |-- ...
    |-- functions
```

Be aware that your git repository will ignore folders as long as there are no files within them.
{: .notice--info}

Do not use any spaces within your folder or filenames until you become an expert. **At no time**. **Never**. 
{: .notice--danger}


