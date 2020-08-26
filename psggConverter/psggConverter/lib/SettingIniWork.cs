using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HT = System.Collections.Generic.Dictionary<string, object>;
namespace lib
{
    public class SettingIniWork
    {
        static HT m_ht;
        public static void Init(string s)
        {
            m_ht = util.IniUtil.CreateHashtable(s);
        }
        public static string Get(string category, string key)
        {
            return util.IniUtil.GetValueFromHashtable(category,key,m_ht);
        }
    }
}
