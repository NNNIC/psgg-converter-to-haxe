using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.IO.Pipes;

namespace lib.util
{
    public class PsggDataFileUtil
    {
        public class Item
        {
            // バッファをプレーン分解（結合すれば元ファイル）
            public string m_header_buf;
            public string m_chart_buf;
            public string m_config_buf;
            public string m_tmpsrc_buf;
            public string m_tmpfnc_buf;
            public string m_setting_buf;
            public string m_help_buf;
            public string m_iteminf_buf;
            public string m_bitmap_buf;

            //ソース取得
            public string m_tmpsrc; //ソーステンプレート
            public string m_tmpfnc; //関数テンプレート

            //headerから要素取得関数
            public string get_header(string key) { return IniUtil.GetValue(key,m_header_buf); }
            
            public string get_config(string key) { return IniUtil.GetValue(key,m_config_buf); }
            public string get_setting(string group, string key) { return IniUtil.GetValue(group,key,m_setting_buf); }
            public string get_help(string group, string key) { return IniUtil.GetValue(group, key, m_help_buf); }
            public string get_iteminf(string group, string key) { return IniUtil.GetValue(group,key, m_iteminf_buf); }

            //chart　便利関数
            private Dictionary<string, object> m_chart_ht;
            private Dictionary<string, string> m_state_dic;  //state=>state_id
            private Dictionary<string, string> m_name_dic;  //name =>name_id
            private void chart_init()
            {
                if (m_chart_ht != null) return;
                m_chart_ht = IniUtil.CreateHashtable(m_chart_buf);

                m_state_dic = new Dictionary<string, string>();
                var stateids = get_stateid_list();
                foreach (var id in stateids)
                {
                    var s = get_chart("id_state_dic", id);
                    if (!string.IsNullOrEmpty(s))
                    {
                        m_state_dic.Add(s, id);
                    }
                }

                m_name_dic = new Dictionary<string, string>();
                var nameids = get_nameid_list();
                foreach (var id in nameids)
                {
                    var n = get_chart("id_name_dic", id);
                    if (!string.IsNullOrEmpty(n))
                    {
                        m_name_dic.Add(n, id);
                    }
                }
            }
            public string get_chart(string group, string key) {
                chart_init();
                return IniUtil.GetValueFromHashtable(group,key,m_chart_ht); 
            }
            public string get_chart(string key) { 
                chart_init();
                return IniUtil.GetValueFromHashtable(key,m_chart_ht); 
            }
            private List<string> get_stateid_list()
            {
                var val = get_chart("stateid_list");
                var list = CsvUtil.GetALineString(val);
                return list;
            }
            private List<string> get_nameid_list()
            {
                var val = get_chart("nameid_lsit");
                var list = CsvUtil.GetALineString(val);
                return list;
            }
            public List<string> get_all_states()
            {
                chart_init();
                var list = new List<string>();
                foreach (var k in m_state_dic.Keys)
                {
                    list.Add(k);
                }
                return list;
            }
            public List<string> get_all_names()
            {
                chart_init();
                var list = new List<string>();
                foreach (var k in m_name_dic.Keys)
                {
                    list.Add(k);
                }
                return list;
            }
            public string get_val(string state, string name)
            {
                var sid = DictionaryUtil.Get(m_state_dic, state);
                var nid = DictionaryUtil.Get(m_name_dic, name);
                if (nid == null || sid == null)
                {
                    return null;
                }
                return get_chart(sid, nid);
            }
        }

        public static Item ReadPsgg(string path)
        {
            var item = new Item();

            var buf = File.ReadAllText(path, Encoding.UTF8);
            var list = new List<string>();
            while (buf != null && buf.Length > 1)
            {
                var index = buf.IndexOf(wordstrage.Store.PSGG_MARK_PREFIX, 1);
                if (index < 0)
                {
                    break;
                }
                var pick = buf.Substring(0, index);
                list.Add(pick);
                buf = buf.Substring(index);
            }
            if (buf != null && buf.Length > 0)
            {
                list.Add(buf);
            }

            var i = 0;
            foreach (var listitem in list)
            {
                if (i == 0)
                {
                    item.m_header_buf = listitem;
                }
                else if (listitem.IndexOf(wordstrage.Store.PSGG_MARK_STATECHART_SHEET) >= 0)
                {
                    item.m_chart_buf = listitem;
                }
                else if (listitem.IndexOf(wordstrage.Store.PSGG_MARK_VARIOUS_SHEET) >= 0) 
                {
                    if (listitem.IndexOf("sheet=config") >= 0 ) 
                    {
                        item.m_config_buf = listitem;
                    }
                    else if (listitem.IndexOf("sheet=template-source") >= 0 ) 
                    {
                        item.m_tmpsrc_buf = listitem;
                    }
                    else if (listitem.IndexOf("sheet=template-statefunc") >= 0) 
                    {
                        item.m_tmpfnc_buf = listitem;
                    }
                    else if (listitem.IndexOf("sheet=setting.ini") >= 0) 
                    {
                        item.m_setting_buf = listitem;
                    }
                    else if (listitem.IndexOf("sheet=help") >= 0) 
                    {
                        item.m_help_buf = listitem;
                    }
                    else if (listitem.IndexOf("sheet=itemsinfo") >= 0) 
                    {
                        item.m_iteminf_buf = listitem;
                    }
                } 
                else if (listitem.IndexOf(wordstrage.Store.PSGG_MARK_BITMAP_DATA) >= 0) 
                {
                    item.m_bitmap_buf = listitem;
                }
                i++;
            }
            Func<string, string> get_tmp = (s) => {
                var si = s.IndexOf(wordstrage.Store.PSGG_MARK_VARIOUS_BEGIN);
                if (si < 0) return null;
                var s1 = s.Substring(si);
                var ei = s1.IndexOf(wordstrage.Store.PSGG_MARK_VARIOUS_END);
                if (ei < 0) return null;
                return s1.Substring(0,ei);
            };
            item.m_tmpsrc = get_tmp(item.m_tmpsrc_buf);
            item.m_tmpfnc = get_tmp(item.m_tmpfnc_buf);

            return item;
        }
    }
}
