---
title: "Assignments and GitHub"
toc: true
toc_label: In this info
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## A note on individual learning log assignments with GitHub
Within this course, you will individually submit your personal solutions for the course assignments to your personal GitHub-hosted learning log, i.e. your personal classroom repository. Don't get confused about "your personal repository". Once you have a GitHub account, you can create as many repositories as you like in your account, but for assignments within our courses always use your respective classroom repository.

The classroom repository will be created automatically by following a link to the respective classroom assignment, which you can find in Ilias. 
Your classroom repository will be hosted as part of GeoMOER, our learning log space at GitHub for Marburg Open Educational Resources.
Submissions generally include the R script or R Markdown source AND the generated HTML files.
For details see the [Deliverables](/moer-mpg-data-analysis/unit00/unit00-02_deliverables.html) section.



To start with, get yourself a GitHub account if you do not already have one and create your personal learning log using the link provided by the course lecturers.
Be aware that once the learning log repository is created, you will stick to this until the end of the course.
Please also add your full name or your student account name to your GitHub profile.
{: .notice--info}

Aside from submitting assignments, you should use your repository for everything related to this course which is potentially subject to version control, team collaboration and issue tracking.
{: .notice--success}


Now it's time to write your first R code in an R Markdown document.

## How to connect RStudio with GitHub

Work through the [R and RStudio introduction](https://geomoer.github.io/moer-base-r/unit01/unit01-01_Intro.html) and the [RStudio version control guide](https://docs.posit.co/ide/user/ide/guide/tools/version-control.html). Before cloning a repository in RStudio, install Git and make sure RStudio can find it. GitHub Desktop is an optional graphical client.

1. In RStudio, choose **File → New Project**.
{% include figure image_path="/assets/images/units/u01/Step1.png" alt="RStudio File menu with New Project selected." caption="" %}

2. Choose **Version Control** to create a project from an existing repository.
{% include figure image_path="/assets/images/units/u01/Step2.png" alt="RStudio New Project wizard with the Version Control option." caption="" %}

3. Choose **Git**.
{% include figure image_path="/assets/images/units/u01/Step3.png" alt="RStudio version control wizard with Git selected." caption="" %}

4. Copy your personal repository URL from GitHub-Classroom and insert it into the project wizard in RStudio.
{% include figure image_path="/assets/images/units/u01/Step4.png" alt="RStudio Git project wizard with fields for the repository URL and local project directory." caption="" %}

5. If prompted, authenticate using the method configured for your repository connection. See [GitHub's authentication documentation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github) for guidance.

6. Create an R Markdown document (`.Rmd`) in your project and knit it to HTML.

7. To record your changes locally, open the **Git** menu and choose **Commit**.
{% include figure image_path="/assets/images/units/u01/Step7.png" alt="RStudio Git menu with the Commit command." caption="" %}

8. In the commit window, select (stage) the files you want to include, such as your `.Rmd` source and generated HTML file (1). Write a commit message describing your changes (2), then click **Commit** (3). This saves the changes in your local repository.
{% include figure image_path="/assets/images/units/u01/Step8.png" alt="RStudio commit window showing selected files, a commit message, and the Commit button." caption="" %}

9. Click **Push** to send your committed changes to GitHub. Check the output to confirm that the push succeeded.
{% include figure image_path="/assets/images/units/u01/Step9.png" alt="RStudio output confirming that changes were pushed to GitHub." caption="" %}

10. Open your repository on GitHub and check that both the `.Rmd` source and generated HTML file are present.
{% include figure image_path="/assets/images/units/u01/Step10.png" alt="GitHub repository file list showing the R Markdown source and generated HTML file." caption="" %}

You can review previous commits in RStudio's **Git History** window.
{% include figure image_path="/assets/images/units/u01/Step11.png" alt="RStudio Git history showing previous commits." caption="" %}

