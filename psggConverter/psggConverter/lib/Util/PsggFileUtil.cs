using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lib.util
{
    public class PsggFileUtil
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
            public string get_header(string key) { return null; }
            public string get_chart(string group, string key) { return null; }
            public string get_chart(string key) { return null; }
            public string get_config(string key) { return null; }
            public string get_setting(string group, string key) { return null; }
            public string get_help(string group, string key) { return null; }
            public string get_iteminf(string group, string key) { return null; }
        }

        public static Item ReadPsgg(string path)
        {
            return null;
        }
    }
}
