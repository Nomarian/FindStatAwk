
# awkstat

A wrapper around find and stat so you can use awk

# Synopsis

awkfind 'awk expression' [--options-for-find]

# Examples

* awkfind  # The same as find $PWD
* awkfind '/\.c$|\.h$/' # Will look for all .c and .h files  
* awkfind '{print sizeb "\t" file}' -maxdepth 1 # semi du like output
* awkfind 'filetype == "directory"' $HOME  # print all directories in $HOME
* awkfind 'tolower(ext) ~ /mkv|mp4|avi/' $HOME # Look for video files in $HOME

# Requires

* Byron's rc shell
* GNU Coreutils (find, stat, xargs)
* gawk

### Optional

* [Walk](https://github.com/google/walk)

# Installing

* pkg-manager install rc busybox coreutils
* rc make.rc
* mv awkfind to one of your directories in $PATH

# Notes

Look at module.awk for the variables used that you can call within awk
look at the output of stat if you are unsure on what to match for or how it should look like
