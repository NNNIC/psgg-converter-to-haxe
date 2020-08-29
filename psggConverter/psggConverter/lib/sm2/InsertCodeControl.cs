using System;
using System.Text;
using System.IO;
using System.Collections.Generic;

using lib.util;

namespace lib
{
    public partial class InsertCodeControl
    {

        // write your code 

        public lib.Convert G;
        public string m_excel;

        void read_file()
        {

            //System.Diagnostics.Debugger.Break();
            try
            {
                m_enc = null; //Haxeへの変換で UTF8との比較が不正になるため、nullを途中まで UTF8の意味として、最後にインスタンスする
                var bom = false;
                if (!string.IsNullOrEmpty(G.ENC))
                {
                    if (G.ENC != "utf-8")
                    {
                        try
                        {
                            m_enc = Encoding.GetEncoding(G.ENC);
                        }
                        catch (SystemException e)
                        {
                            m_error = "Error Encoding :" + e.Message;
                        }
                    }
                }
                if (m_enc == null)
                {
                    var bytes = File.ReadAllBytes(m_filepath);
                    if (bytes.Length > 3)
                    {
                        if ((bytes[0] == 0xef) && (bytes[1] == 0xbb) && (bytes[2] == 0xbf))
                        {
                            bom = true;
                        }
                    }
                }

                if (m_enc == null)
                {
                    m_enc = new UTF8Encoding(bom);
                }

                m_src = File.ReadAllText(m_filepath, m_enc);
                m_bl = StringUtil.FindNewLineChar(m_src);
                m_lines = StringUtil.SplitTrimKeepSpace(m_src, m_bl[0]);
            }
            catch (SystemException e)
            {
                m_error = "error read_file. " + e.Message;
            }
        }

        int find_start_mark()
        {
            for (var index = m_cur; index < m_lines.Count; index++)
            {
                var l = m_lines[index];
                if (l != null && l.Contains(MARK_START))
                {
                    m_cur = index;
                    return index;
                }
            }
            return -1;
        }

        int find_end_mark()
        {
            for (var index = m_cur; index < m_lines.Count; index++)
            {
                var l = m_lines[index];
                if (l != null && l.Contains(MARK_END))
                {
                    return index;
                }
            }
            return -1;
        }
        void get_param(string s)
        {
            var markindex = s.IndexOf(MARK_START);
            var ns = s.Substring(markindex + MARK_START.Length); //マークより後のバッファ

            var indentstr = RegexUtil.Get1stMatch(@"indent\(\d+\)", ns);
            if (!string.IsNullOrEmpty(indentstr))
            {
                var numstr = RegexUtil.Get1stMatch(@"\d+", indentstr);
                m_indent = int.Parse(numstr);

                ns = ns.Replace(indentstr, ""); //インデント部分除去
            }

            m_command = RegexUtil.Get1stMatch(@"\$.+\$\s*$", ns);

            if (string.IsNullOrEmpty(m_command))
            {
                m_error = "Cannot find command : " + s;
            }
        }

        string convert(int indent, string command)
        {
            var buf = indent > 0 ? new string(' ', indent) : string.Empty;

            buf += command;
            var output = G.generate_for_inserting_src(m_excel, buf, indent);
            return output;
        }

        void insert_output()
        {
            var tmp = new List<string>();

            // m_mark_startラインまでコピー
            for (var i = 0; i <= m_mark_start; i++)
            {
                tmp.Add(m_lines[i]);
            }
            //outputをコピー
            {
                var outlines = StringUtil.SplitTrimKeepSpace(m_output, m_bl[0]);
                tmp.AddRange(outlines);
            }
            //最後まで
            for (var i = m_mark_end; i < m_lines.Count; i++)
            {
                tmp.Add(m_lines[i]);
            }

            //入れ替える
            m_lines = null;
            m_lines = tmp;
        }

        void save()
        {
            string s = "";
            foreach (var l in m_lines)
            {
                if (!string.IsNullOrEmpty(s))
                {
                    s += m_bl;
                }
                s += l;
            }
            File.WriteAllText(G.TGTFILE, s, m_enc);
        }

    }
}