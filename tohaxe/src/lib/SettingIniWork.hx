package lib;
using StringTools;
import system.*;
import anonymoustypes.*;

class SettingIniWork
{
    static var m_ht:system.collections.generic.Dictionary<String, Dynamic>;
    public static function Init(s:String):Void
    {
        m_ht = lib.util.IniUtil.CreateHashtable(s);
    }
    public static function Get(category:String, key:String):String
    {
        return lib.util.IniUtil.GetValueFromHashtable_String_String_DictionaryStringObject(category, key, m_ht);
    }
    public function new()
    {
    }
}
