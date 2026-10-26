---
title: "Organize Your Data Files"
toc: true
toc_label: On this page
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Before importing data, give the file a clear place in your project. In this example, you will download one small text file and locate it using a relative path. We will reuse it on the [R Syntax and Help page]({{ site.baseurl }}/unit03/unit03-02a_r_syntax_and_help.html).

## Download and organize the example

1. Open your existing RStudio course project using its `.Rproj` file.
2. Create a folder named `Data` inside the project folder if it does not already exist.
3. <a href="{{ site.baseurl }}/assets/data/example.txt" download="example.txt">Download example.txt</a> and save it in `Data/`, keeping the name `example.txt`. If your browser displays the text, save that file using **Save As**. Move it from your Downloads folder into `Data/` if necessary.

Your project should contain the following files and folder; the project name will be your own:

```text
course-project/
├── course-project.Rproj
└── Data/
    └── example.txt
```

The file contains a header and three invented observations for practicing imports. The heights are in meters:

```text
tree;height_m
beech;18,5
oak;21,0
pine;16,2
```

Each line is one row. Semicolons separate the columns, and commas mark decimals. The `.txt` extension tells you this is a text file; its contents determine the import settings.

## Understand the working directory and relative path

The **working directory** is the folder R uses as the starting point for relative file paths. Opening your RStudio project sets it to the project folder. Check it with:

```r
getwd()
```

The path `Data/example.txt` means: start in the working directory, enter `Data`, and find `example.txt`. The slash separates the folder name from the filename. This relative path can stay the same when another person opens their copy of the project on another computer.

Keep the project folder as the working directory. The `Data/` part of the path already tells R where to look inside it.

When you use these paths in an R Markdown document, save the `.Rmd` in the project folder, alongside the `.Rproj` file. By default, knitting uses the folder containing the `.Rmd` as its working directory. This placement lets the same `Data/example.txt` path work in the console and when knitting. See the [R Markdown working-directory guide](https://bookdown.org/yihui/rmarkdown-cookbook/working-directory.html) for other folder arrangements.

## Check that R can find the file

```r
file.exists("Data/example.txt")
```

The result should be `TRUE`. If it is `FALSE`, check the working directory, the folder name and the exact filename. In particular, check capitalization and that the file was not saved as `example.txt.txt`.

You have now prepared the local file. On the [next page]({{ site.baseurl }}/unit03/unit03-02a_r_syntax_and_help.html), we will read it with `read.table()` and use the help page to understand the call.
