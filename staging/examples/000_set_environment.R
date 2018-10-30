library(link2GI)

# Set path ---------------------------------------------------------------------
filepath_base = "C:/Users/tnauss/permanent/edu/mpg-data-analysis/"

# Set project specific subfolders
project_folders = c("data/",
                    "data/csv/", "data/tmp/")

envrmt = initProj(projRootDir = filepath_base, GRASSlocation = "data/grass",
                  projFolders = project_folders, path_prefix = "path_", 
                  global = FALSE)