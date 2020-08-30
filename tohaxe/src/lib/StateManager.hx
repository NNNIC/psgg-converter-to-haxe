package lib;
using StringTools;
import system.*;
import anonymoustypes.*;

class StateManager
{
    public var m_curfunc:(Bool -> Void);
    var m_nextfunc:(Bool -> Void);
    var m_tempfunc:(Bool -> Void);
    var m_noWait:Bool = false;
    var m_bEnd:Bool = false;
    public function update():Void
    {
        while (true)
        {
            var bFirst:Bool = false;
            if (m_nextfunc != null)
            {
                m_curfunc = m_nextfunc;
                m_nextfunc = null;
                bFirst = true;
            }
            m_noWait = false;
            if (m_curfunc != null)
            {
                _debug_point(bFirst);
                m_curfunc(bFirst);
            }
            if (!m_noWait)
            {
                break;
            }
        }
    }
    public function _debug_point(b:Bool):Void
    {
    }
    public function Goto(func:(Bool -> Void)):Void
    {
        m_nextfunc = func;
    }
    public function CheckState(func:(Bool -> Void)):Bool
    {
        return m_curfunc == func;
    }
    public function IsEnd():Bool
    {
        return m_bEnd;
    }
    public function SetEnd(b:Bool):Void
    {
        m_bEnd = b;
    }
    public function SetNextState(func:(Bool -> Void)):Void
    {
        m_tempfunc = func;
    }
    public function GoNextState():Void
    {
        m_nextfunc = m_tempfunc;
        m_tempfunc = null;
    }
    public function HasNextState():Bool
    {
        return m_tempfunc != null;
    }
    public function NoWait():Void
    {
        m_noWait = true;
    }
    public function new()
    {
    }
}
