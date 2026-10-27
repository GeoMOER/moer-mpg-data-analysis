---
title: "Assignments and GitHub"
toc: true
toc_label: In this info
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Your course repository on GitHub
Within this course, you will submit your individual solutions to one personal GitHub-hosted learning log created through Classroom 50. You will use this course repository for all assignments, even if you have other GitHub repositories.

Find both invitation links in ILIAS and follow the two [Classroom 50 setup steps](/moer-mpg-data-analysis/unit00/unit00-01_learning_environment.html#classroom-50-and-github). Your instructors must add you to the course roster before the links will let you join. Accept the invitation to **GeoMOER-Students-Space**, then accept the course repository assignment. Classroom 50 provides the repository link under **My submission**.
Your course repository will be hosted in GeoMOER-Students-Space on GitHub.
Submissions generally include the R script or R Markdown source AND the generated HTML files.
For details see the [Deliverables](/moer-mpg-data-analysis/unit00/unit00-02_deliverables.html) section.



If you do not yet have a GitHub account, create one before following the setup steps above.
Keep the same learning log repository until the end of the course.
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

4. Open your repository on GitHub from **My submission** in Classroom 50. Copy its URL from the **Code** menu and insert it into the project wizard in RStudio.
{% include figure image_path="/assets/images/units/u01/Step4.png" alt="RStudio Git project wizard with fields for the repository URL and local project directory." caption="" %}

5. If prompted, authenticate using the method configured for your repository connection. See [GitHub's authentication documentation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github) for guidance.

6. Create an R Markdown document (`.Rmd`) beside the project's `.Rproj` file and knit it to HTML. The [shared project layout]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html#common-project-layout) explains the folders introduced as the course progresses.

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

