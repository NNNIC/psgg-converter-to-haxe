package lib;
using StringTools;
import system.*;
import anonymoustypes.*;

class SettingIniWork
{
    static var m_ht:system.collections.Hashtable;
    public static function Init(s:String):Void
    {
        m_ht = util.IniUtil.CreateHashtable(s);
    }
    public static function Get(category:String, key:String):String
    {
        return util.IniUtil.GetValueFromHashtable_String_String_Hashtable(category, key, m_ht);
    }
    public function new()
    {
    }
}
