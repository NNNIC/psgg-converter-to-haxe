using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.IO;

namespace psggConverter
{
    class Program
    {
        static void Main(string[] args)
        {
            var p = new lib.Convert();
            p.TEST();

            var item = lib.util.PsggDataFileUtil.ReadPsgg(@"G:\statego\psgg-converter-to-haxe\tohaxe\testdata\c\TestControl.psgg");
            p.COMMENTLINE_FORMAT = item.get_setting("macro", "commentline");
            p.template_src = item.m_tmpsrc;
            p.template_func = item.m_tmpfnc;

        }
    }
}
