library(envimaR)

root_folder = "~/edu/mpg-data-analysis/"

project_folders = c("data/",
                    "data/csv/", "data/rdata", "data/tmp/", "data/dwd/")

libs = c("reshape2", "car", "plotly", "forecast", "zoo", "TSA", "Kendall",
         "dtw", "TSclust")

envrmt = createEnvi(root_folder = root_folder, folders = project_folders, 
                    path_prefix = "path_", libs = libs,
                    alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP",
                    alt_env_root_folder = "F:\\BEN\\edu")
