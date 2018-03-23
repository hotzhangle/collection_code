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

#-----------------------------CHECK HEADER Structure------------------------------
#
#     struct md_check_header_comm{
#                 unsigned char check_header[12];        /* magic number is "CHECK_HEADER" */
#                 unsigned int    header_verno;             /*  header structure version number */
#                 unsigned int    product_ver;                /* 0x0: invalid; 0x1: debug version; 0x2: release version*/
#                 unsigned int    image_type;                /* 0x0: invalid; 0x1: 2G modem; 0x2: 3G modem */
#                 unsigned char platform[16];               /* MT6xxx_S00 */
#                 unsigned char build_time[64];            /* build time string */
#                 unsigned char build_ver[64];             /* project version, ex: 11A_MD.W11.28 */
#
#                 unsigned char build_sys_id;               /* bind to md sys id, MD SYS1: 1, MD SYS2: 2 */
#                 unsigned char ext_attr;                     /* no shrink: 0 shrink: 1*/
#                 unsigned char reserved[2];               /* for reserved */
#
#                 unsigned int    mem_size;                 /* md ROM/RAM image size requested by md */
#                 unsigned int    md_img_size;             /* md image size, exclude head size */
#                 unsigned int    reserved;                   /* for reserved */
#                 unsigned int    size;
#      }__attribute__((packed));
#
#-----------------------------------------------------------------------------------------

my ($bin_file,$platform,$chip_ver,$verno,$Image_Mode,$production_release,$map_file) = @ARGV;
my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
$year += 1900;
$mon  += 1;
$build_time = "$year/$mon/$mday $hour:$min";

&error_handler("BIN_NAME: $bin_name should NOT exceed 127 bytes", __FILE__, __LINE__) if(length($bin_name) > 127);
&error_handler("VERNO: $verno should NOT exceed 63 bytes", __FILE__, __LINE__) if(length($verno) > 63);


#************************************************************
#Start to write infomation to BIN file for MODEM
#************************************************************
#MODEM mechanism

  my $structure_size = 188;
  my $check_header_str = "CHECK_HEADER";
  my $header_version = "01";
  my $image_size = -s "$bin_file";
  my $append_padding = $image_size%4;
  my $append_padding = ($append_padding == 0) ? 0 : (4 - $append_padding);
  my $mem_size = &get_mem_size($platform);
  my $md_ro_size= &get_modem_RO_size($platform, $image_size, $map_file);
  open (FILE, "+<$bin_file") or die "cannot open image files:$bin_file\n";
  binmode(FILE);
  seek(FILE, 0, 2);

 #Tail Info must be 4-byte align
  print FILE "\0" x $append_padding;
  print FILE "$check_header_str";
  print FILE "\0" x (12 -length($check_header_str));

  print FILE pack("V1",$header_version);
  
  #Debug/Release mode check
  #0x1: debug mode
  #0x2: release mode  
  if($production_release eq "RELEASE") {
    print FILE pack("V1",2);
  } elsif($production_release eq "DEVELOPMENT") {
    print FILE pack("V1",1);
  } else {
    print FILE pack("V1",0);
  }
  
  #2G/3G check
  #0x1: 2G (1X ONLY)
  #0x2: 3G (1X+EVDO)
  #print "Image_Mode:".$Image_Mode."\n";
  if ($Image_Mode eq "modem_3_2g_n.img"){
    print FILE pack("V1",1);
  }else {
    print FILE pack("V1",2);
  }
  
  #platfrom
  my $plat_chip_info = $platform."_".$chip_ver;
  print FILE "$plat_chip_info";
  print FILE "\0" x (16 -length($plat_chip_info));
  #build time
  print FILE "$build_time";
  print FILE "\0" x (64 -length($build_time));

  # build version
  if($verno =~ /(.+W\d\d\.\d\d).*/) {
     $build_verno = $1;
  }
  print FILE "$build_verno";
  print FILE "\0" x (64 -length($build_verno));

  # md sys id
  # 1: MD SYS1
  # 2: MD SYS2
  # 3: MD SYS3 
 
  print FILE pack("C1",3);

  # fill mem_size and md_ro_size
  seek(FILE, 3, 1);
  print FILE pack("V2", $mem_size,  $md_ro_size);
  seek(FILE, 4, 1);
  print FILE pack("V1",$structure_size);

#print "Done\n";
exit 0;

#****************************************************************************
#
# Get Memory Size
#*****************************************************************************
sub get_mem_size{
  my ($loc_platform) = @_;
  my $ret_size;
  if($loc_platform eq "MT6735" ||$loc_platform eq "MT6753"){
     $ret_size = 0;
  }else{
     $ret_size = 0xC00000;
  }
  return $ret_size;
}

#****************************************************************************
#
# Search Image$$RO_REGION$$Limit in map file
#*****************************************************************************
sub get_modem_RO_size{
  my ($loc_platform, $loc_image_size, $loc_map) = @_;
  my $ro_size = 0;
  if($loc_platform eq "MT6735" ||$loc_platform eq "MT6753"){
    $ro_size = 0;
  }else{
    open MAP_FILE, "<$loc_map" or die "Can't open $loc_map\n";
    while(<MAP_FILE>){
      if(/^\s+(0x[\dA-Fa-f]{8})\s+Image\$\$RO_REGION\$\$Limit\s+=\s+\./){
        $ro_size = hex($1);
        last;
      }
    }
    close(MAP_FILE);
    die "Invalid RO_REGION Size $ro_size\n" if($ro_size == 0);
  }
  return $ro_size;
}
#******************************************************************************
#*******************
# Error Handling Message
#******************************************************************************
#*******************
sub error_handler
{
       my ($error_msg, $file, $line_no) = @_;
       my $final_error_msg = "Error: $error_msg at $file line $line_no\n";
       print "$final_error_msg";
       die $final_error_msg;
}

