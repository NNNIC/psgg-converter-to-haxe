package psggconverter;
using StringTools;
import system.*;
import anonymoustypes.*;

class Program
{
    static function Main(args:Array<String>):Void
    {
        var p:lib.Convert = new lib.Convert();
        p.TEST();
        var item:lib.util.PsggDataFileUtil_Item = lib.util.PsggDataFileUtil.ReadPsgg("G:\\statego\\psgg-converter-to-haxe\\tohaxe\\testdata\\c\\TestControl.psgg");
        p.COMMENTLINE_FORMAT = item.get_setting("macro", "commentline");
        p.template_src = item.m_tmpsrc;
        p.template_func = item.m_tmpfnc;
    }
    public function new()
    {
    }
}
