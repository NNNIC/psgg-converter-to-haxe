<?php

class FizzBuzzControl {

    // :::: PSGG MANAGER ::::

    private $m_curfunc  = NULL;
    private $m_nextfunc = NULL;
    private $m_noWait   = FALSE;

    private const MAX_CALL_STACK = 10;
    private $m_callstack = array();
    private $m_callstack_level = 0;

    function __construct() {
        $m_callstack = array_fill(0,self::MAX_CALL_STACK,'');
    }

    public function Update() {
        while(TRUE) {
            $bFirst = FALSE;
            if ($this->m_nextfunc!=NULL) {
                $this->m_curfunc = $this->m_nextfunc;
                $this->m_nextfunc = NULL;
                $bFirst = TRUE;
            }
            $this->m_noWait = FALSE;
            if ($this->m_curfunc!=NULL) {
                $this->call_state($this->m_curfunc, $bFirst);
            }
            if ($this->m_noWait == FALSE) {
                break;
            }
        }
    }

    public function GotoState($st) {
        $this->m_nextfunc = $st;
    }

    public function CheckState($st) {
        return $st == $this->m_curfunc;
    }
 
    public function HasNextState() {
        return $this->m_nextfunc != NULL;
    }

    public function NoWait() {
        $this->m_noWait = TRUE;
    }

    public function GoSubState($sub, $next) {
        if ($this->m_callstack_level >= self::MAX_CALL_STACK - 1) {
            echo 'CALL STACK OVER FLOW<br>';
            exit();
        }
        $this->m_callstack[$this->m_callstack_level++] = $next;
        $this->GotoState($sub);
    }

    public function ReturnState()
    {
        if ($this->m_callstack_level <= 0) {
            echo 'CALL STACK UNDER FLOW<br>';
            exit();
        }
        $this->m_callstack_level--;
        $st = $this->m_callstack[$this->m_callstack_level];
        
        $this->GotoState($st);        
    }
    
    function Start() {
        $this->GotoState('S_START');
    }

    function IsEnd() {
        return $this->CheckState('S_END');
    }

    // :::: PSG OUPUT ::::

    function call_state($state, $bFirst) {
        switch($state) {
            //[PSGG OUTPUT START] indent(12) $/^S_/->#case$
            //             psggConverterLib.dll converted from psgg-file:FizzBuzzControl.psgg

            case 'S_Buzz': $this->S_Buzz($bFirst); break;
            case 'S_CHECK': $this->S_CHECK($bFirst); break;
            case 'S_END': $this->S_END($bFirst); break;
            case 'S_Fizz': $this->S_Fizz($bFirst); break;
            case 'S_FizzBuzz': $this->S_FizzBuzz($bFirst); break;
            case 'S_GSB000': $this->S_GSB000($bFirst); break;
            case 'S_GSB001': $this->S_GSB001($bFirst); break;
            case 'S_LOP000': $this->S_LOP000($bFirst); break;
            case 'S_LOP000_LoopCheckAndGosub____': $this->S_LOP000_LoopCheckAndGosub____($bFirst); break;
            case 'S_LOP000_LoopNext____': $this->S_LOP000_LoopNext____($bFirst); break;
            case 'S_LOP001': $this->S_LOP001($bFirst); break;
            case 'S_NUM': $this->S_NUM($bFirst); break;
            case 'S_RET000': $this->S_RET000($bFirst); break;
            case 'S_RET001': $this->S_RET001($bFirst); break;
            case 'S_RET002': $this->S_RET002($bFirst); break;
            case 'S_SBS000': $this->S_SBS000($bFirst); break;
            case 'S_SBS001': $this->S_SBS001($bFirst); break;
            case 'S_SHOW_START': $this->S_SHOW_START($bFirst); break;
            case 'S_START': $this->S_START($bFirst); break;


            //[PSGG OUTPUT END]
        }
    }

    //[PSGG OUTPUT START] indent(4) $/./$
    //             psggConverterLib.dll converted from psgg-file:FizzBuzzControl.psgg

    /*
        S_Buzz
    */
    function S_Buzz($bFirst) {
        if ($bFirst)
        {
            echo 'Buzz<br>';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET000');
        }
    }
    /*
        S_CHECK
    */
    function S_CHECK($bFirst) {
        if ($this->m_num % 15 == 0) { $this->GotoState( 'S_FizzBuzz' ); }
        elseif ($this->m_num % 3 == 0) { $this->GotoState( 'S_Fizz' ); }
        elseif ($this->m_num % 5 == 0) { $this->GotoState( 'S_Buzz' ); }
        else { $this->GotoState( 'S_NUM' ); }
    }
    /*
        S_END
    */
    function S_END($bFirst)
    {
    }
    /*
        S_Fizz
    */
    function S_Fizz($bFirst) {
        if ($bFirst)
        {
            echo 'Fizz<br>';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET000');
        }
    }
    /*
        S_FizzBuzz
    */
    function S_FizzBuzz($bFirst) {
        if ($bFirst)
        {
            echo 'FizzBuzz<br>';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET000');
        }
    }
    /*
        S_GSB000
    */
    function S_GSB000($bFirst)
    {
        $this->GoSubState('S_SBS001','S_LOP000');
        $this->NoWait();
    }
    /*
        S_GSB001
    */
    function S_GSB001($bFirst)
    {
        $this->GoSubState('S_SBS001','S_END');
        $this->NoWait();
    }
    /*
        S_LOP000
    */
    private $m_num = 0;
    function S_LOP000($bFirst)
    {
        $this->m_num = 1;
        $this->GotoState('S_LOP000_LoopCheckAndGosub____');
        $this->NoWait();
    }
    function S_LOP000_LoopCheckAndGosub____($bFirst)
    {
        if ($this->m_num <= 100) $this->GoSubState('S_SBS000','S_LOP000_LoopNext____');
        else               $this->GotoState('S_LOP001');
        $this->NoWait();
    }
    function S_LOP000_LoopNext____($bFirst)
    {
        $this->m_num ++;
        $this->GotoState('S_LOP000_LoopCheckAndGosub____');
        $this->NoWait();
    }
    /*
        S_LOP001
    */
    function S_LOP001($bFirst) {
        if ($bFirst)
        {
            $this->m_s = 'END OF FIZZ BUZZ';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_GSB001');
        }
    }
    /*
        S_NUM
    */
    function S_NUM($bFirst) {
        if ($bFirst)
        {
            echo $this->m_num . '<br>';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET000');
        }
    }
    /*
        S_RET000
    */
    function S_RET000($bFirst)
    {
        $this->ReturnState();
        $this->NoWait();
    }
    /*
        S_RET001
    */
    function S_RET001($bFirst)
    {
        $this->ReturnState();
        $this->NoWait();
    }
    /*
        S_RET002
    */
    private $m_s = '';
    function S_RET002($bFirst) {
        if ($bFirst)
        {
            echo '<table border=4><th>' . $this->m_s . '</th></table>';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET001');
        }
    }
    /*
        S_SBS000
    */
    function S_SBS000($bFirst) {
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_CHECK');
        }
    }
    /*
        S_SBS001
    */
    function S_SBS001($bFirst) {
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_RET002');
        }
    }
    /*
        S_SHOW_START
    */
    function S_SHOW_START($bFirst) {
        if ($bFirst)
        {
            $this->m_s = 'START OF FIZZ BUZZ';
        }
        if ($this->HasNextState()==FALSE)
        {
            $this->GotoState('S_GSB000');
        }
    }
    /*
        S_START
    */
    function S_START($bFirst)
    {
        $this->GotoState('S_SHOW_START');
        $this->NoWait();
    }


    //[PSGG OUTPUT END]

    // :::: WRITE YOUR CODE HERE ::::

    protected $m_bYesNo;

    function br_YES($st) {
        if ($this->HasNextState()==FALSE) {
            if ($this->m_bYesNo==TRUE) {
                $this->GotoState($st);
            }
        }
    }

    function br_NO($st) {
        if ($this->HasNextState()==FALSE) {
            if ($this->m_bYesNo==FALSE) {
                $this->GotoState($st);
            }
        }
    }
}

/* :::: PSGG MACRO ::::
:psgg-macro-start

; This section has macro defines for converting.

; commentline format  {%0} will be replaced to a comment.
commentline=// {%0} 

@branch=@@@
<<<?"{%0}"/^brifc{0,1}$/
if ([[brcond:{%N}]]) { $this->GotoState( '{%1}' ); }
>>>
<<<?"{%0}"/^brelseifc{0,1}$/
elseif ([[brcond:{%N}]]) { $this->GotoState( '{%1}' ); }
>>>
<<<?"{%0}"/^brelse$/
else { $this->GotoState( '{%1}' ); }
>>>
<<<?"{%0}"/^br_/
$this->{%0}('{%1}');
>>>
@@@

#case=@@@
case '[[state]]': $this->[[state]]($bFirst); break;
<<<?state-typ/^loop$/
case '[[state]]_LoopCheckAndGosub____': $this->[[state]]_LoopCheckAndGosub____($bFirst); break;
case '[[state]]_LoopNext____': $this->[[state]]_LoopNext____($bFirst); break;
>>>
@@@

:psgg-macro-end
*/

?>