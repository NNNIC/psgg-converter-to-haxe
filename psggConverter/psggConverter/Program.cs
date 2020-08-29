using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.IO;
using lib.util;

namespace psggConverter
{
    class Program
    {
        static void Main(string[] args)
        {
            var p = new lib.Convert();
            p.TEST();

            var psggfile = @"G:\statego\psgg-converter-to-haxe\tohaxe\testdata\c\TestControl.psgg";
            var psggdir = Path.GetDirectoryName(psggfile);
            var item = lib.util.PsggDataFileUtil.ReadPsgg(psggfile);
            p.COMMENTLINE_FORMAT = item.get_setting("macro", "commentline");
            p.template_src = item.m_tmpsrc;
            p.template_func = item.m_tmpfnc;
            p.getChartFunc = item.get_chart_val;

            var macro_set = new MacroUtil();
            macro_set.ReadAllMacroSettings(item, psggdir);
            p.getMacroValueFunc = macro_set.GetValue;

            p.setting_ini = item.m_setting_buf;

            p.name_list      = item.GetNameList();
            p.name_row_list  = item.GetNameRowList();
            p.state_list     = item.GetStateList();
            p.state_col_list = item.GetStateColList();

            p.XLSDIR         = Path.GetDirectoryName(psggfile);
            p.GENDIR         = item.GetGenDir(psggdir);

            p.INCDIR         = item.GetIncDir(psggdir);

            p.MARK_START     = item.GetCodeOutputStart();
            p.MARK_END       = item.GetCodeOutputEnd();
            p.TGTFILE        = item.GetGeneratedSource(psggdir); //セッティングより

            var enc = item.GetSrcEnc();
            p.ENC            = string.IsNullOrEmpty(enc) ? "utf-8" : enc;

            p.STATEMACHINE   = item.GetStatemachine(); //

            //psggファイルの相対
            var genfile = item.GetGeneratedSource(psggdir);
            var psggrelfile = PathUtil.GetRelativePath(Path.GetDirectoryName(genfile), psggfile);
            p.PSGGFILE = psggrelfile;

            //コンバート
            p.InsertOutputToFile(psggfile, item.GetGeneratedSource(psggdir), item.GetIncDir(psggdir));

        }
    }
}
