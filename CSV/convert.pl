#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;


#########################################
#####                               #####
#####         Variables             #####
#####                               #####
#########################################

# separators
my $initialSeparator = ";";
my $futureSeparator  = ",";

# quiet mode
my $quiet = 0;

#########################################
#####                               #####
#####          Modes                #####
#####                               #####
#########################################
# Write while read
my $MODE_STREAM = "STREAM";
# Read the write
my $MODE_BULK   = "BULK";

my $mode = $MODE_STREAM;

# check that we have at least a file to convert
if( @ARGV < 1) {
    print "Usage: $0 <options> filenameToConvert\nOptions: \n\t-b: bulk mode (read, then write)\n\t-s: stream mode (read and write) [default]";
    exit(-1);
}

########
## Read options from command line
########
GetOptions ('quiet|q' => \$quiet, 'stream|s' => sub {$mode = $MODE_STREAM}, 'bulk|b' => sub { $mode = $MODE_BULK});

if(!$quiet) {
    print "File ".$ARGV[0] ." will be converted\n";
}

# Manage file names
my $filename = $ARGV[0];
my $outfile  = $ARGV[0] .".out";

convertFile($filename, $mode);



if(!$quiet) {
    print "File $filename has been converted in $outfile in mode ". $mode . "\n";
}

sub convertFile {
    my ($filename, $mode) = @_;

    # open files
    open( my $fh => $filename) || die "Cannot open $filename: $!";
    open( my $fo , '>', $outfile ) || die "Cannot open $outfile: $!";

    my $convertedStr = "";

    while(my $line = <$fh>) {
        my $convertedLine = convertLine($line);
        if($mode eq $MODE_STREAM) {
            print $fo $convertedLine;
        } elsif($mode eq $MODE_BULK) {
            $convertedStr .= $convertedLine;
        }
            #my @row = split("\t",$line);
    }

    if($mode eq $MODE_BULK) {
        print $fo $convertedStr;
    }


    # Release opened files
    close($fh);
    close($fo);
}

sub convertLine {
    my ($line) = @_;
    $line =~ s/$initialSeparator/$futureSeparator/ig;
    return $line;
}