
## awkstat

A wrapper around find and stat so you can use awk

Example: awkfind 'awk expression' --options-for-find

### Examples

* awkfind '{print filename}' /  # Prints filename of all subdirectories directories in /
* awkfind '{print sizeb "\t" file}' -maxdepth 1 # same as du -a $PWD
* awkfind 'filetype == "directory"' $HOME  # print all directories in $HOME
* awkfind 'tolower(ext) ~ /mkv|mp4|avi/' $HOME # Look for video files in $HOME

### Requires

* Byron's rc shell
* gawk
* busybox stat (or maybe gnu stat)
* xargs

### Build/Install

rc make.rc and awkfindstat will be created from the modules, you can put it in your $PATH after

### Notes

Look at module.awk for the variables used that you can call within awk
look at the output of stat if you are unsure on what to match for or how it should look like

### Bugs

a file containing a newline could ruin everything, its dirty, but it works most times
