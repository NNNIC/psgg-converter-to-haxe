package start;
import tool.IniUtil;
import lib.Convert;

class Program {
    public static function main() {
        VConstructors.init();

        trace("#0. call Convert from " + Sys.args()[0]);
        // var p = new Convert();
        // p.TEST();

        psggconverter.Program.Main(Sys.args());

    }
}