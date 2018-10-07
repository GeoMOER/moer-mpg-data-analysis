# Move markdown files and related figures to jekyll
files = list.files(dirname(rstudioapi::getActiveDocumentContext()$path), 
                   recursive = TRUE, full.names = TRUE)


# Copy MD files
md_files = files[grep("\\.md$", files)]

target_folder = paste0(substr(md_files[1], 1, gregexpr(pattern ='staging', md_files[1])[[1]][1]-1),
                       "docs/_includes/")
dir.create(target_folder, showWarnings = FALSE)

for(f in md_files){
  f_in = readLines(f)
  title_line = grep("title:", f_in)
  header_start = grep("---", f_in)[1]
  header_end = grep("---", f_in)[2]
  
  new_header = c(f_in[header_start], f_in[title_line], "toc: true", 
                 "toc_label: In this example", f_in[header_end])

  if(!is.na(header_end)){
    f_in = c(new_header, f_in[-seq(header_end)])
    fc = file(f, "w")
    writeLines(f_in, fc)
    close(fc)
  }
  file.copy(from=f, to=target_folder, 
            overwrite = TRUE, recursive = TRUE, 
            copy.mode = TRUE)  
}


# Copy RMD figures
rmd_image_folder = dirname(files[grep("rmd_images", files)])

target_folder = paste0(substr(rmd_image_folder[1], 1, gregexpr(pattern ='staging', rmd_image_folder[1])[[1]][1]-1),
                       "docs/assets/images/rmd_images/")
dir.create(target_folder, showWarnings = FALSE)

for(f in rmd_image_folder){
  file.copy(from=f, to=target_folder, 
            overwrite = TRUE, recursive = TRUE, 
            copy.mode = TRUE)  
}


# Clean up
unlink(rmd_image_folder, recursive = TRUE)
file.remove(md_files)
html_files = files[grep("\\.html$", files)]
file.remove(html_files)

