# CSV tools

Bunch of tools to manage CSV files

## Convert

Convert a CSV file from American to European format or a custom format.
 
Usage: *perl convert.pl \<options\> filenameToConvert*

Options:

    -b: bulk mode (read, then write)
    -s: stream mode (read and write) [default]
    -[out|o]=outputFile
 
 Examples:
    
    perl convert.pl file.csv
    perl convert.pl -o=out.csv -b file.csv
    