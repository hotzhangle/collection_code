use strict;

###################################################
# Main Body
###################################################    

my $set_1 = $ARGV[0];
my $set_2 = $ARGV[1];
my $outputFile = $ARGV[2];

my $zone = "";
my %hash;

my @OTA1;
my $OTA1_Count = 0;
my @MSG1;
my $MSG1_Count = 0;

if (!-e "$set_1")
{
	print "Error: The layout description file $set_1 is not available!\n";
	exit(1);
}

if (!-e "$set_2")
{
	print "Error: The layout description file $set_2 is not available!\n";
	exit(1);
}
		
open FH1, $set_1;
while (my $line = <FH1>)
{
	chomp($line);
	
	my $sectionFlag = 0;
	if ($line =~ /#/)
	{
		$zone = "";
		if ($line =~ /#OTA_INFO/)
		{
			$zone = "OTA";
		}
		if ($line =~ /#MSG_INFO/)
		{
			$zone = "MSG";
		}
		$sectionFlag = 1;
	}
	
	if ($sectionFlag) {next;}

	if ($zone =~ /OTA/)
	{
		if ($line =~ /^.+,.+,.+,.+/)
		{
			$OTA1[$OTA1_Count++] = $line;
		}
	}
	
	if ($zone =~ /MSG/)
	{
		if ($line =~ /^.+,.+,.+,.+/)
		{
			$MSG1[$MSG1_Count++] = $line;
		}
	}	
}
close FH1;

open (FH3, ">$outputFile") || die "Cannot create $outputFile!\n";
open FH2, $set_2;
$zone = ""; #reset
while (my $line = <FH2>)
{
	chomp($line);

	if ($line =~ /^#[^#]+/)
	{
		if ($zone =~ /OTA/) #previous zone
		{
			for my $savedLine (@OTA1)
			{
				print FH3 $savedLine."\n";				
			}
			$zone = ""; #reset
		}
		if ($zone =~ /MSG/) #previous zone
		{
			for my $savedLine (@MSG1)
			{
				print FH3 $savedLine."\n";				
			}
			$zone = ""; #reset
		}		

		if ($line =~ /#OTA_INFO/)
		{
			$zone = "OTA";
			
		}
		if ($line =~ /#MSG_INFO/)
		{
			$zone = "MSG";
		}
		
		print FH3 "\n";	
	}

	if (length($line) > 0)
	{
		print FH3 $line."\n";	
	}
}

close FH2;
close FH3;

print "Info: Output $outputFile Done!\n";
exit(0);