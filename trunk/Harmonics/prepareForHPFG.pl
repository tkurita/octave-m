#!/usr/bin/perl -w
#interactive perl -d -e 1
#escapeChars {return}
#output > '/Users/tkurita/WorkSpace/シンクロトロン/2倍高調波/特性データ/HP FG用データ/C660_10_200-200-400-50/PhaseCtrl_forSUMINV.txt'

use strict;
use warnings;
use File::Spec;
use Cwd;
use Data::Dumper;


sub strip_headspaces {
	my $string = shift @_;
	if ($string =~ /^\s*(.*)/) {
		$string = $1;
	}
	return $string;
}

{
	foreach my $input_file (@ARGV){
        #warn cwd()."\n";
		open(my $in, "<$input_file") or die "I cant't open $input_file";
		while (defined(my $line = <$in>)) {
			chomp($line);
			if ($line =~ /^#/) {next};
			$line = strip_headspaces($line);
			print "$line\r\n";
			#print STDERR "hello\n";
		}
	}
}