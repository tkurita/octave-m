#!/usr/bin/perl -w
#interactive perl -d -e 1
#escapeChars {return}
#output > '/Users/tkurita/WorkSpace/�V���N���g����/2�{�����g/�����f�[�^/HP FG�p�f�[�^/C660_10_200-200-400-50/PhaseCtrl_forSUMINV.txt'

use strict;
use warnings;
use Data::Dumper;
use File::Spec;

sub strip_headspaces {
	my $string = shift @_;
	if ($string =~ /^\s*(.*)/) {
		$string = $1;
	}
	return $string;
}

{
	foreach my $input_file (@ARGV){
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