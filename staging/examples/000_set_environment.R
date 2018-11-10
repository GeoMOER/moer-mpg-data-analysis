library(envimaR)

root_folder = "~/edu/mpg-data-analysis/"

project_folders = c("data/",
                    "data/csv/", "data/rdata", "data/tmp/")

libs = c("reshape2")

envrmt = createEnvi(root_folder = root_folder, folders = project_folders, 
                    path_prefix = "path_", libs = libs,
                    alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP",
                    alt_env_root_folder = "F:\\BEN\\edu")


