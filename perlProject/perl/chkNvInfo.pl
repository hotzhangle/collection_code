#!/usr/bin/perl
#
#  Copyright Statement:
#  --------------------
#  This software is protected by Copyright and the information contained
#  herein is confidential. The software may not be copied and the information
#  contained herein may not be used or disclosed except with the written
#  permission of MediaTek Inc. (C) 2015
#
#  BY OPENING THIS FILE, BUYER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
#  THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
#  RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO BUYER ON
#  AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
#  NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
#  SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
#  SUPPLIED WITH THE MEDIATEK SOFTWARE, AND BUYER AGREES TO LOOK ONLY TO SUCH
#  THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. MEDIATEK SHALL ALSO
#  NOT BE RESPONSIBLE FOR ANY MEDIATEK SOFTWARE RELEASES MADE TO BUYER'S
#  SPECIFICATION OR TO CONFORM TO A PARTICULAR STANDARD OR OPEN FORUM.
#
#  BUYER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND CUMULATIVE
#  LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
#  AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
#  OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY BUYER TO
#  MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
#  THE TRANSACTION CONTEMPLATED HEREUNDER SHALL BE CONSTRUED IN ACCORDANCE
#  WITH THE LAWS OF THE STATE OF CALIFORNIA, USA, EXCLUDING ITS CONFLICT OF
#  LAWS PRINCIPLES.  ANY DISPUTES, CONTROVERSIES OR CLAIMS ARISING THEREOF AND
#  RELATED THERETO SHALL BE SETTLED BY ARBITRATION IN SAN FRANCISCO, CA, UNDER
#  THE RULES OF THE INTERNATIONAL CHAMBER OF COMMERCE (ICC).
#
#*****************************************************************************
#*
#* Filename:
#* ---------
#*   chkNvInfo.pl
#*
#* Project:
#* --------
#*   JADE
#*
#* Description:
#* ------------
#*   This script is used checking C2K NVRAM LID Info
#*
#*============================================================================

my $cp_map = shift @ARGV;
my $cp_rom = shift @ARGV;

my $lid_entry_size = 32;
my $log_level = 0;
my $lid_table_addr;
my $lid_table_size;
my $flag = 0;
my %addr_href;

my %lid_id_href;
my %lid_rec_href;
my %lid_size_href;
my %default_ptr_href;
my %catergory_href;
my %attr_href;
my %lid_name_href;
my %lid_verno_href;
my %lid_name_to_id_href;

open CP_MAP, "<$cp_map" or die "Can't open $cp_map\n";
while(<CP_MAP>){
	if(/^\s+(0x[\da-fA-F]{8})\s+_nvram_ltable\$\$Base/){
		$addr_href{"TABLE_BASE"} = $1;
		$flag = $flag + 1;
	}elsif(/^\s+(0x[\da-fA-F]{8})\s+_nvram_ltable\$\$Limit/){
		$addr_href{"TABLE_LIMIT"} = $1;
		$flag = $flag + 2;
	}elsif(/^\s+(0x[\da-fA-F]{8})\s+Load\$\$SRAM\$\$Base/){
		$addr_href{"SRAM_LMA"} = $1;
		$flag = $flag + 4;
	}elsif(/^\s+(0x[\da-fA-F]{8})\s+Image\$\$SRAM\$\$Base\s\=/){
		$addr_href{"SRAM_VMA"} = $1;
		$flag = $flag + 8;
	}
}

close CP_MAP;

if($flag != 15){
	die "$flag, Invalid map file, can't find _nvram_ltable or Load\$\$SRAM\$\$Base\n"
}

&DBG_LOG("%s\n", $addr_href{"TABLE_BASE"});
&DBG_LOG("%s\n", $addr_href{"TABLE_LIMIT"});
&DBG_LOG("%s\n", $addr_href{"SRAM_LMA"});
&DBG_LOG("%s\n", $addr_href{"SRAM_VMA"});
$lid_table_addr = hex($addr_href{"SRAM_LMA"}) + (hex($addr_href{"TABLE_BASE"}) - hex($addr_href{"SRAM_VMA"}));
$lid_table_size = hex($addr_href{"TABLE_LIMIT"}) - hex($addr_href{"TABLE_BASE"});
&DBG_LOG("lid table addr $lid_table_addr, $lid_table_size\n"); 

open CP_ROM, "<$cp_rom" or die "Can't open $cp_rom\n";
binmode(CP_ROM);
sysseek CP_ROM, $lid_table_addr, 0;
my $read_size = 0;
while($read_size < $lid_table_size){
	sysread(CP_ROM, $buf, $lid_entry_size);
	my ($lid_id, $lid_rec, $lid_size, $default_ptr, $catergory, $attr, $lid_name, $lid_verno) = unpack("v2V3vZ5Z4", $buf);
	
	#First check lid entry
	if(exists $lid_id_href{$lid_id}){
		die "[NVRAM INFO CHECK ERROR:] LID $lid_id nvram entry is defined more than once, please check it\n";
	}
	$lid_id_href{$lid_id} = $lid_id;
	
	#Second check lid name unique
	if(exists $lid_name_to_id_href{$lid_name}){
		die "[NVRAM INFO CHECK ERROR:] LID $lid_id name $lid_name is conflict with LID $lid_name_to_id_href{$lid_name}, please use unique name\n"
	}
  $lid_name_to_id_href{$lid_name} = $lid_id;
  
  #record infomation
  $lid_rec_href{$lid_id} = $lid_rec;
  $lid_size_href{$lid_id} = $lid_size;
  $default_ptr_href{$lid_id} = $default_ptr;
  $catergory_href{$lid_id} = $catergory;
  $attr_href{$lid_id} = $attr;
  $lid_name_href{$lid_id} = $lid_name;
  $lid_verno_href{$lid_id} = $lid_verno;
  
  $read_size = $read_size + $lid_entry_size;
}

foreach my $lid_id (sort {$a<=>$b} keys %lid_id_href){
	&DBG_LOG("LID       : $lid_id_href{$lid_id}\n");
	&DBG_LOG("REC       : $lid_rec_href{$lid_id}\n");
	&DBG_LOG("SIZE      : $lid_size_href{$lid_id}\n");
	&DBG_LOG("CATERGORY : $catergory_href{$lid_id}\n");
	&DBG_LOG("ATTR      : $attr_href{$lid_id}\n");
	&DBG_LOG("NAME      : $lid_name_href{$lid_id}\n");
	&DBG_LOG("VERNO     : $lid_verno_href{$lid_id}\n");
	&DBG_LOG("\n\n");
}
&DBG_LOG("pass\n");

sub DBG_LOG{
	if($log_level == 1){
		printf(@_);
	}
}