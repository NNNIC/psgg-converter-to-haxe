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
        rtest("c:\\vv\\g\\q\\n", "C:\\vv\\d");
        rtest("c:\\vv\\g\\q\\n", "C:\\vv\\g\\x.c");
        rtest("c:\\vv\\g\\q", "C:\\vv\\d");
        rtest("c:\\vv\\", "C:\\vv\\x");
        rtest("c:\\", "C:\\vv");
        var p:lib.Convert = new lib.Convert();
        p.TEST();
        var psggfile:String = "G:\\statego\\psgg-converter-to-haxe\\tohaxe\\testdata\\c\\TestControl.psgg";
        var psggdir:String = "G:\\statego\\psgg-converter-to-haxe\\tohaxe\\testdata\\c";
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
        p.InsertOutputToFile(psggfile, item.GetGeneratedSource(psggdir), item.GetIncDir(psggdir));
    }
    public function new()
    {
    }
}
