/*
This file serves two purposes:  
    1)  It imports every type that CS2HX generated.  haXe will ignore 
        any types that aren't used by haXe code, so this ensures haXe 
        compiles all of your code.

    2)  It lists all the static constructors.  haXe doesn't have the 
        concept of static constructors, so CS2HX generated cctor()
        methods.  You must call these manually.  If you call
        Constructors.init(), all static constructors will be called 
        at once.
*/
package ;
import lib.CfPrepareControl;
import lib.Convert;
import lib.FunctionControl;
import lib.Githash;
import lib.IncludeFile;
import lib.InsertCodeControl;
import lib.MacroControl;
import lib.MacroWork;
import lib.RefListString;
import lib.SettingIniWork;
import lib.SourceControl;
import lib.SourceControl_MODE;
import lib.StateManager;
import lib.util.IniUtil;
//import lib.util.RegexUtil;
//import lib.util.SortUtil;
import lib.util.StringUtil;
import lib.Ver;
import lib.wordstrage.Store;
import psggconverter.Program;
import system.TimeSpan;
class VConstructors
{
    public static function init()
    {
        TimeSpan.cctor();
    }
}
