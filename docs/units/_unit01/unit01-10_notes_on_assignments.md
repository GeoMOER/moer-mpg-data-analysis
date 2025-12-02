---
title: "Assignments and GitHub"
toc: true
toc_label: In this info
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## A note on individual learning log assignments with GitHub
Within this course, you will individually submit your personal solutions for the course assignments to your personal GitHub-hosted learning log, i.e. your personal classroom repository. Don't get confused about "your personal repository". Once you have a GitHub account, you can create as many repositories as you like at your account, but for assignments within our courses always use your respective classroom repository.  

The classroom repository will be created automatically by following a link to the respective classroom assignment, which you can find in Ilias. 
Your classroom repository will be hosted as part of GeoMOER, our learning log space at GitHub for Marburg Open Educational Resources.
The submissions generally encompass R or R markdown AND the compiled html files.
For details see the ["Deliverables*](/moer-mpg-data-analysis/unit00/unit00-02_deliverables.html) section.



To start with, get yourself a GitHub account if you have not one already and create your personal learning log using the link provided by the course lecturers. 
Be aware that once the learning log repository is created, you will stick to this until the end of the course.
Please also add your full name or your student account name to your GitHub profile.
{: .notice--info}

Aside from submitting assignments, you should use your repository for everything related to this course which is a potential subject to version control, team collaboration and issue tracking.
{: .notice--success}


Now it's time for your first R code, which will be put into an R markdown document.

## How to connect RStudio with GitHub

Once you worked through the [R/RStudio](https://geomoer.github.io/moer-base-r/unit01/unit01-01_Intro.html) and [Git/GitHub](https://geomoer.github.io/moer-base-r/unit99/sl02_github.html) installations, it's time to connect them.

'1. Create a new project in RStudio.
{% include figure image_path="/assets/images/units/u01/Step1.png" caption="" %}

'2. Use the version control kind to allow a Git connection.
{% include figure image_path="/assets/images/units/u01/Step2.png" caption="" %}

'3. Choose Git.
{% include figure image_path="/assets/images/units/u01/Step3.png" caption="" %}

'4. Copy your personal repository URL from GitHub-Classroom and insert it into the project wizard in RStudio.
{% include figure image_path="/assets/images/units/u01/Step4.png" caption="" %}

'5. Your browser will open a window with environmental settings for GitHub. Accept those.

'6. Create a new file of your choice in RStudio. In this course you might want to use a Markdown file (.Rmd).

'7. To upload your file to GitHub, click the "GIT" button in the menu above your script and choose "Commit".
{% include figure image_path="/assets/images/units/u01/Step7.png" caption="" %}

'8. A Window will open. Select all files, which you want to upload (1) and leave a note (2) to later identify what you've done. Than commit (3).
{% include figure image_path="/assets/images/units/u01/Step8.png" caption="" %}

'9. Once you are done committing all the changes, click "Push" to load them into your online repository. A text message will confirm what just habbened.
{% include figure image_path="/assets/images/units/u01/Step9.png" caption="" %}

'10. Take a look at your repository on GitHub. The files will show up there.
{% include figure image_path="/assets/images/units/u01/Step10.png" caption="" %}

Additionally, the history of changes is saved in a change log in RStudio.
{% include figure image_path="/assets/images/units/u01/Step11.png" caption="" %}

