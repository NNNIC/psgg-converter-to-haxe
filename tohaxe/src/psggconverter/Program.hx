package psggconverter;
using StringTools;
import system.*;
import anonymoustypes.*;

class Program
{
    public static function Main(args:Array<String>):Void
    {
        var rtest:(String -> String -> Void) = function (a:String, b:String):Void
        {
            var r:String = lib.util.PathUtil.GetRelativePath(a, b);
            var abs:String = psgg.HxFile.Combine_String_String(a, r);
            var fabs:String = psgg.HxFile.GetFullPath(abs);
            system.Console.WriteLine("---------");
            system.Console.WriteLine("a = " + system.Cs2Hx.NullCheck(a));
            system.Console.WriteLine("b = " + system.Cs2Hx.NullCheck(b));
            system.Console.WriteLine("r = " + system.Cs2Hx.NullCheck(r));
            system.Console.WriteLine("check = " + system.Cs2Hx.NullCheck(fabs));
        }
        ;
        var p:lib.Convert = new lib.Convert();
        var psggfile:String = "";
        if (args != null && args.length > 0)
        {
            psggfile = args[0];
        }
        else
        {
            psggfile = "G:\\statego\\psgg-converter-to-haxe\\tohaxe\\testdata-tmp\\php\\FizzBuzzControl.psgg";
        }
        var psggdir:String = psgg.HxFile.GetDirectoryName(psggfile);
        var item:lib.util.PsggDataFileUtil_Item = lib.util.PsggDataFileUtil.ReadPsgg(psggfile);
        p.COMMENTLINE_FORMAT = item.get_setting_String_String("macro", "commentline");
        p.template_src = item.m_tmpsrc;
        p.template_func = item.m_tmpfnc;
        p.getChartFunc = item.get_chart_val;
        var macro_set:lib.util.MacroUtil = new lib.util.MacroUtil();
        macro_set.ReadAllMacroSettings(item, psggdir);
        p.getMacroValueFunc = macro_set.GetValue;
        p.setting_ini = item.m_setting_buf;
        p.name_list = item.GetNameList();
        p.name_row_list = item.GetNameRowList();
        p.state_list = item.GetStateList();
        p.state_col_list = item.GetStateColList();
        p.XLSDIR = psgg.HxFile.GetDirectoryName(psggfile);
        p.GENDIR = item.GetGenDir(psggdir);
        p.INCDIR = item.GetIncDir(psggdir);
        p.MARK_START = item.GetCodeOutputStart();
        p.MARK_END = item.GetCodeOutputEnd();
        p.TGTFILE = item.GetGeneratedSource(psggdir);
        var enc:String = item.GetSrcEnc();
        p.ENC = system.Cs2Hx.IsNullOrEmpty(enc) ? "utf-8" : enc;
        p.STATEMACHINE = item.GetStatemachine();
        var genfile:String = item.GetGeneratedSource(psggdir);
        var psggrelfile:String = lib.util.PathUtil.GetRelativePath(psgg.HxFile.GetDirectoryName(genfile), psggfile);
        p.PSGGFILE = psggrelfile;
        if (Cs2Hx.IsNullOrWhiteSpace(system.Cs2Hx.Trim(item.m_tmpsrc)))
        {
            system.Console.WriteLine("input : " + system.Cs2Hx.NullCheck(psggfile));
            var macrofile:String = item.get_setting_String_String(lib.wordstrage.Store.settingini_group_setting, lib.wordstrage.Store.settingini_setting_macroini);
            if (!system.Cs2Hx.IsNullOrEmpty(macrofile))
            {
                system.Console.WriteLine("macro : " + system.Cs2Hx.NullCheck(psgg.HxFile.Combine_String_String(p.INCDIR, macrofile)));
            }
            system.Console.WriteLine("output: " + system.Cs2Hx.NullCheck(item.GetGeneratedSource(psggdir)));
            p.InsertOutputToFile(psggfile, item.GetGeneratedSource(psggdir), item.GetIncDir(psggdir));
        }
        else
        {
            system.Console.WriteLine("!!!!!!!!!!!!!! Not supported separated sources. !!!!!!!!!!!!!!!!!");
        }
    }
    public function new()
    {
    }
}
