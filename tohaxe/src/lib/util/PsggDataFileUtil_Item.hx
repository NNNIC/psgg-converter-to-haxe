package lib.util;
using StringTools;
import system.*;
import anonymoustypes.*;

class PsggDataFileUtil_Item
{
    public var m_header_buf:String;
    public var m_chart_buf:String;
    public var m_config_buf:String;
    public var m_tmpsrc_buf:String;
    public var m_tmpfnc_buf:String;
    public var m_setting_buf:String;
    public var m_help_buf:String;
    public var m_iteminf_buf:String;
    public var m_bitmap_buf:String;
    public var m_tmpsrc:String;
    public var m_tmpfnc:String;
    public function get_header(key:String):String
    {
        return lib.util.IniUtil.GetValue(key, m_header_buf);
    }
    public function get_config(key:String):String
    {
        return lib.util.IniUtil.GetValue(key, m_config_buf);
    }
    public function get_setting(group:String, key:String):String
    {
        return lib.util.IniUtil.GetValue_String_String_String(group, key, m_setting_buf);
    }
    public function get_help(group:String, key:String):String
    {
        return lib.util.IniUtil.GetValue_String_String_String(group, key, m_help_buf);
    }
    public function get_iteminf(group:String, key:String):String
    {
        return lib.util.IniUtil.GetValue_String_String_String(group, key, m_iteminf_buf);
    }
    private var m_chart_ht:system.collections.generic.Dictionary<String, Dynamic>;
    private var m_state_dic:system.collections.generic.Dictionary<String, String>;
    private var m_name_dic:system.collections.generic.Dictionary<String, String>;
    private function chart_init():Void
    {
        if (m_chart_ht != null)
        {
            return;
        }
        m_chart_ht = lib.util.IniUtil.CreateHashtable(m_chart_buf);
        m_state_dic = new system.collections.generic.Dictionary<String, String>();
        var stateids:Array<String> = get_stateid_list();
        for (id in stateids)
        {
            var s:String = get_chart_String_String("id_state_dic", id);
            if (!system.Cs2Hx.IsNullOrEmpty(s))
            {
                m_state_dic.Add(s, id);
            }
        }
        m_name_dic = new system.collections.generic.Dictionary<String, String>();
        var nameids:Array<String> = get_nameid_list();
        for (id in nameids)
        {
            var n:String = get_chart_String_String("id_name_dic", id);
            if (!system.Cs2Hx.IsNullOrEmpty(n))
            {
                m_name_dic.Add(n, id);
            }
        }
    }
    public function get_chart_String_String(group:String, key:String):String
    {
        chart_init();
        return lib.util.IniUtil.GetValueFromHashtable_String_String_DictionaryStringObject(group, key, m_chart_ht);
    }
    public function get_chart(key:String):String
    {
        chart_init();
        return lib.util.IniUtil.GetValueFromHashtable(key, m_chart_ht);
    }
    private function get_stateid_list():Array<String>
    {
        var val:String = get_chart("stateid_list");
        var list:Array<String> = lib.util.CsvUtil.GetALineString(val);
        return list;
    }
    private function get_nameid_list():Array<String>
    {
        var val:String = get_chart("nameid_lsit");
        var list:Array<String> = lib.util.CsvUtil.GetALineString(val);
        return list;
    }
    public function get_all_states():Array<String>
    {
        chart_init();
        var list:Array<String> = new Array<String>();
        for (k in m_state_dic.Keys)
        {
            list.push(k);
        }
        return list;
    }
    public function get_all_names():Array<String>
    {
        chart_init();
        var list:Array<String> = new Array<String>();
        for (k in m_name_dic.Keys)
        {
            list.push(k);
        }
        return list;
    }
    public function get_val(state:String, name:String):String
    {
        var sid:String = lib.util.DictionaryUtil.Get(m_state_dic, state);
        var nid:String = lib.util.DictionaryUtil.Get(m_name_dic, name);
        if (nid == null || sid == null)
        {
            return null;
        }
        return get_chart_String_String(sid, nid);
    }
    public function new()
    {
    }
}
