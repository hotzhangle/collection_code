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
#*   genNvDatabase.pl
#*
#* Project:
#* --------
#*   JADE
#*
#* Description:
#* ------------
#*   This script is to generate C2K NVRAM database
#*
#*============================================================================

my $parameter_num = 5;
if($#ARGV != $parameter_num-1){
	&Usage();
	die "\nError parameter number, should be $parameter_num\n";
}

my $pro_dir = shift @ARGV;
my $cc = shift @ARGV;
my $tool_dir = shift @ARGV;
my $version = shift @ARGV;
my $nvram_database = shift @ARGV;

my $nv_dir = $pro_dir."\/auto_gen_nvram";
my $editor_h = $nv_dir."\/nvram_editor.h";
my $def_via = $pro_dir."\/via\/dbm.via";
my $inc_via = $pro_dir."\/via\/dbm_inc.via";
my $nvram_editor_db = $nv_dir."\/nvram_editor.db";
#my $nvram_database  = $nv_dir."\/md3_database";
my $nvram_enum_file = $nv_dir."\/nvram_enum.txt";
my $nv_log = $nv_dir."\/nvram_auto_gen.log";
my $cgen = $tool_dir."\/Cgen";
my $pc_cfg = $tool_dir."\/Pc_Cnf";
my $tgt_cfg = $tool_dir."\/Tgt_Cnf_GCC";

if(-e $nv_dir){
	my @filelist = <$nv_dir\/*>;
	unlink @filelist;
}else{
	mkdir $nv_dir, 0755;
}

#step 1. generate nvram_editor.h
my $editor_text = &get_head_text();
$editor_text = $editor_text."\n\n\n";
$editor_text = $editor_text."#include \"nvram_editor_data_item.h\"\n";
open EDITOR_H, ">$editor_h" or die "Can't open $editor_h\n";
printf EDITOR_H $editor_text;
close EDITOR_H;

#step 2. Pre-process nvram_editor.h
$result = system("$cc \@$def_via -DGEN_FOR_PC \@$inc_via -E -W -P -o $nvram_editor_db $editor_h> $nv_log");
die "please check $nv_log for detail\n" if ($result != 0);
#step 3. Cgen database
$result = system("$cgen -c $nvram_editor_db $tgt_cfg $pc_cfg $nvram_database $nvram_enum_file swVer $version >> $nv_log");
die "please check $nv_log for detail\n" if ($result != 0);

sub Usage(){
	printf "perl genNvDatabase.pl parm1, parm2, parm3, parm4\n";
	printf "   parm1 : project build out bin file directory\n";
	printf "   parm2 : gcc.exe full path\n";
	printf "   parm3 : cgen tools directory path\n";
	printf "   parm4 : current database version\n";
	printf "   parm5 : NVRAM Database name\n";
}

sub get_head_text(){
	my $text = <<"__TEMPLATE";

typedef char kal_char;

typedef unsigned short kal_wchar;


typedef unsigned char kal_uint8;

typedef signed char kal_int8;

typedef unsigned short int kal_uint16;

typedef signed short int kal_int16;

typedef unsigned int kal_uint32;

typedef signed int kal_int32;

typedef enum {
	TST_NULL_COMMAND
} tst_command_type;

typedef kal_uint8 tst_null_command_struct;

typedef struct
{
   tst_command_type  command_type;
   kal_uint16        cmd_len;
} tst_command_header_struct;

typedef struct
{
	kal_uint32     dummy;
} tst_log_prim_header_struct;

typedef struct
{
	kal_uint32     dummy;
} tst_index_trace_header_struct;

typedef struct
{
	kal_uint32     dummy;
} tst_prompt_trace_header_struct;

typedef struct
{
	kal_uint8   index;
	kal_uint8   string[128];
} tst_inject_string_struct;






typedef kal_uint8 tst_null_command_struct ;

typedef kal_uint8 tst_set_l1_trc_filter_struct;

typedef kal_uint8 tst_reboot_target_cmd_struct;

typedef kal_uint8 tst_query_memory_range_cmd_struct;

typedef kal_uint8 tst_query_soft_fc_char_cmd_struct;

typedef kal_uint8 tst_force_assert_cmd_struct;

typedef kal_uint8 tst_flush_swdbg_cmd_struct;

typedef kal_uint8 tst_st_stop_cmd_struct;

typedef kal_uint8 tst_reboot_for_mmi_auto_test_cmd_struct;

typedef enum
{
   TRACE_FUNC,
   TRACE_STATE,
   TRACE_INFO,
   TRACE_WARNING,
   TRACE_ERROR,
   TRACE_GROUP_1,
   TRACE_GROUP_2,
   TRACE_GROUP_3,
   TRACE_GROUP_4,
   TRACE_GROUP_5,
   TRACE_GROUP_6,
   TRACE_GROUP_7,
   TRACE_GROUP_8,
   TRACE_GROUP_9,
   TRACE_GROUP_10,
   TRACE_PEER
}trace_class_enum;

typedef enum {
    SAP_ID_NULL

}sap_type;

typedef enum {
    MOD_ID_NULL

}module_type;

typedef enum {
    MSG_ID_NULL

}msg_type;
__TEMPLATE
 
  return $text;
}