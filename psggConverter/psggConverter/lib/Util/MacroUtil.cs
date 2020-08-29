using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HT = System.Collections.Generic.Dictionary<string, object>;

namespace lib.util
{
    public class MacroUtil
    {
        HT m_default_macro_ht; // settingsの[macro]部分
        HT m_macro_ini_ht;     // __PREFIX__ControlMacro.iniファイル部分
        HT m_gensrc_macro_ht;  // 生成先ソースに定義されたマクロ部分  :psgg-macro-start  :psgg-macro-end

        public void ReadAllMacroSettings(PsggDataFileUtil.Item psggItem, string doc_path)
        {
            var filename = psggItem.get_setting(wordstrage.Store.settingini_group_setting, wordstrage.Store.settingini_setting_macroini);  //SettingIniUtil.GetMacroIni();
            if (!string.IsNullOrEmpty(filename))
            { 
                try
                {
                    var text = File.ReadAllText(filename, Encoding.UTF8);
                    m_macro_ini_ht      = IniUtil.CreateHashtable(text);
                }
                catch (SystemException e)
                {
                    Console.WriteLine("File Cannot read :" + filename +":" + e.Message);
                }
            }
            m_default_macro_ht = (HT)psggItem.get_setting(wordstrage.Store.settingini_group_macro);//   SettingIniUtil.GetMacroHash();

            try
            {   //生成ソース内の マクロを収集する。 
                var macroinitext = string.Empty;
                var text = psggItem.GetGeneratedSource(doc_path);
                var lines = text.Split('\xa');

                bool bInMacro = false;
                foreach (var l in lines)
                {
                    if (!bInMacro)
                    {
                        if (l.Contains(wordstrage.Store.macro_start_mark))
                        {
                            bInMacro = true;
                            continue;
                        }
                    }
                    else
                    {
                        if (l.Contains(wordstrage.Store.macro_end_mark))
                        {
                            bInMacro = false;
                            continue;
                        }
                    }
                    
                    if (bInMacro)
                    {
                        macroinitext += l + Environment.NewLine;
                    }
                }

                if (bInMacro)
                {
                    Console.WriteLine("Cannot find " + wordstrage.Store.macro_end_mark +" in "  + psggItem.GetGeneratedSourceFileName());
                }
                else
                {
                    m_gensrc_macro_ht = IniUtil.CreateHashtable(macroinitext);
                }

            }
            catch (System.Exception e){
                Console.WriteLine("File Cannot read :" + psggItem.GetGeneratedSourceFileName() + ":" + e.Message);
            }

            
        }

        public string GetValue(string key)
        {
            //生成ソース内のマクロ確認
            if (m_gensrc_macro_ht != null && m_gensrc_macro_ht.ContainsKey(key))  
            {
                return (string)m_gensrc_macro_ht[key];
            }
            //Iniファイル内のマクロ確認
            if (m_macro_ini_ht!=null && m_macro_ini_ht.ContainsKey(key))
            {
                return (string)m_macro_ini_ht[key];
            }
            //Settingの[macro]確認
            if (m_default_macro_ht!=null && m_default_macro_ht.ContainsKey(key))
            {
                return  (string)m_default_macro_ht[key];
            }
            return null;
        }
   
    }
}
