package lib.wordstrage;
using StringTools;
import system.*;
import anonymoustypes.*;

class Store
{
    public static inline var rgst_key:String = "Software\\psgg\\v01";
    public static inline var rgst_lang:String = "lang";
    public static inline var rgst_keysub_save:String = "save";
    public static inline var rgst_item_templatedir:String = "templatedir";
    public static inline var rgst_item_templateidx:String = "templateidx";
    public static inline var rgst_item_prefix:String = "prefix";
    public static inline var rgst_item_xlsdir:String = "xlsdir";
    public static inline var rgst_item_gendir:String = "gendir";
    public static inline var rgst_item_srceditcmd:String = "srceditcmd";
    public static inline var rgst_item_srceditcmd_option:String = "srceditcmd_option";
    public static inline var rgst_item_findhist:String = "findhist";
    public static inline var rgst_item_starterkitpath:String = "starterkitpath";
    public static inline var rgst_item_starterkit_root:String = "starterkit_root";
    public static inline var rgst_item_statemachine:String = "statemachine";
    public static inline var rgst_item_force_control:String = "force_control";
    public static inline var rgst_item_docundersrc_xlsdir:String = "docundersrc_xlsdir";
    public static inline var rgst_item_free_xlsdir:String = "free_xlsdir";
    public static inline var rgst_item_serialcode:String = "serialcode";
    public static inline var rgst_item_serial_latestdate:String = "seriallatestdate";
    public static inline var rgst_item_running_timestamp:String = "runningtimestamp";
    public static inline var rgst_item_editform_desc_onoff:String = "editform_desc_onoff";
    public static inline var rgst_item_mrb_enable:String = "mrb_enable";
    public static inline var rgst_item_historypanelonstart_enable:String = "historypanelonstart_enable";
    public static inline var rgst_item_forceclose_ifviewchangeonly:String = "forceclose_ifviewchangeonly";
    public static inline var rgst_item_analytics_onoff:String = "analytics_onoff";
    public static inline var rgst_item_option_set_default_comment:String = "option_set_default_comment";
    public static inline var srceditcmd_option_vs2015:String = "vs2015";
    public static inline var sheetchart:String = "state-chart";
    public static inline var sheetconfig:String = "config";
    public static inline var sheettempsrc:String = "template-source";
    public static inline var sheettempfunc:String = "template-statefunc";
    public static inline var sheetsetting:String = "setting.ini";
    public static inline var sheethelp:String = "help";
    public static inline var sheetitems:String = "itemsinfo";
    public static inline var psgg:String = "psgg";
    public static inline var excel:String = "excel";
    public static inline var settingini_group_setting:String = "setting";
    public static inline var settingini_group_setupinfo:String = "setupinfo";
    public static inline var settingini_group_macro:String = "macro";
    public static inline var settingini_group_jpn:String = "jpn";
    public static inline var settingini_group_en:String = "en";
    public static inline var settingini_group_addon:String = "addon";
    public static inline var settingini_setting_psgg:String = "psgg";
    public static inline var settingini_setting_xls:String = "xls";
    public static inline var settingini_setting_sub_src:String = "sub_src";
    public static inline var settingini_setting_gensrc:String = "gen_src";
    public static inline var settingini_setting_macroini:String = "macro_ini";
    public static inline var settingini_setting_manager_src:String = "manager_src";
    public static inline var settingini_setting_manager_dir:String = "manager_dir";
    public static inline var settingini_setting_template_src:String = "template_src";
    public static inline var settingini_setting_template_func:String = "template_func";
    public static inline var settingini_setting_help:String = "help";
    public static inline var settingini_setting_helpweb:String = "helpweb";
    public static inline var settingini_setting_kitpath:String = "kitpath";
    public static inline var settingini_setting_src_enc:String = "src_enc";
    public static inline var settingini_setupinfo_converter:String = "converter";
    public static inline var settingini_setupinfo_lang:String = "lang";
    public static inline var settingini_setupinfo_framework:String = "framework";
    public static inline var settingini_setupinfo_statemachine:String = "statemachine";
    public static inline var settingini_setupinfo_prefix:String = "prefix";
    public static inline var settingini_setupinfo_xlsdir:String = "xlsdir";
    public static inline var settingini_setupinfo_gendir:String = "gendir";
    public static inline var settingini_setupinfo_genrdir:String = "genrdir";
    public static inline var settingini_setupinfo_incrdir:String = "incrdir";
    public static inline var settingini_setupinfo_ref_ancestor_dir:String = "ref_ancestor_dir";
    public static inline var settingini_setupinfo_code_output_start:String = "code_output_start";
    public static inline var settingini_setupinfo_code_output_end:String = "code_output_end";
    public static inline var settingini_setupinfo_clone_exchange:String = "clone_exchange";
    public static inline var settingini_setupinfo_clone_exchange_with_upper_camel_word:String = "with_upper_camel_word";
    public static inline var settingini_lang_title:String = "title";
    public static inline var settingini_lang_detail:String = "detail";
    public static inline var settingini_addon_dir:String = "dir";
    public static inline var settingini_addon_file:String = "file";
    public static inline var settingini_convertword_prefix:String = "__PREFIX__";
    public static inline var settingini_convertword_statemachine:String = "__PREFIX__Control";
    public static inline var settingini_convertword_xlsdir:String = "__XLSDIR__";
    public static inline var settingini_convertword_gendir:String = "__GENDIR__";
    public static inline var settingini_convertword_genrdir:String = "__GENRDIR__";
    public static inline var settingini_convertword_starterkit:String = "__STARTERKIT__";
    public static inline var langdir_langtxt:String = "lang.txt";
    public static inline var default_converter_dll:String = "psggConverterLib.dll";
    public static inline var macro_start_mark:String = ":psgg-macro-start";
    public static inline var macro_end_mark:String = ":psgg-macro-end";
    public static inline var psgg_ver:String = "1.1";
    public static inline var PSGG_MARK_PREFIX:String = "------#======*<Guid(";
    public static inline var PSGG_MARK_POSTFIX:String = ")>*======#------";
    public static inline var PSGG_MARK_STATECHART_SHEET:String = "------#======*<Guid(D13821FE-FA27-4B04-834C-CEC1E5670F48)>*======#------";
    public static inline var PSGG_MARK_VARIOUS_SHEET:String = "------#======*<Guid(70C5A739-223A-457D-8AEE-1A0E2050D5AE)>*======#------";
    public static inline var PSGG_MARK_BITMAP_DATA:String = "------#======*<Guid(4DC98CBA-6257-4E26-A454-A53F85BC234C)>*======#------";
    public static inline var PSGG_MARK_VARIOUS_BEGIN:String = "###VARIOUS-CONTENTS-BEGIN###";
    public static inline var PSGG_MARK_VARIOUS_END:String = "###VARIOUS-CONTENTS-END###";
    public static inline var PSGG_MARK_BITMAP_BEGIN:String = "###BITMAP-DATA-BEGIN###";
    public static inline var PSGG_MARK_BITMAP_END:String = "###BITMAP-DATA-END###";
    public static inline var state_typ_start:String = "start";
    public static inline var state_typ_end:String = "end";
    public static inline var state_typ_gosub:String = "gosub";
    public static inline var state_typ_substart:String = "substart";
    public static inline var state_typ_subreturn:String = "subreturn";
    public static inline var state_typ_loop:String = "loop";
    public static inline var state_typ_stop:String = "stop";
    public static inline var state_typ_pass:String = "pass";
    public static inline var state_typ_base:String = "base";
    public function new()
    {
    }
}
