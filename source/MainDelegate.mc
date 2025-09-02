import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Attention;

var vibeProfile = [new Attention.VibeProfile(50, 100)];

class MainDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        // WatchUi.pushView(new Rez.Menus.MainMenu(), new Menu2Delegate(), WatchUi.SLIDE_UP);
        var menu = new WatchUi.Menu2({:title=>"Menu"});
        menu.addItem(new WatchUi.MenuItem("Reset Match", null, "reset_match", null));
        menu.addItem(new WatchUi.MenuItem("Settings", null, "settings", null));
        menu.addItem(new WatchUi.MenuItem("Exit", null, "exit", null));
        WatchUi.pushView(menu, new $.Menu2Delegate(), WatchUi.SLIDE_UP);
        // WatchUi.requestUpdate();
        return true;
    }

    function onKey(keyEvent as KeyEvent) as Boolean {
        // System.println("PingPongCounterDelegate.onKey: " + keyEvent.getKey());
        if (keyEvent.getKey() == 22) {
            // Exit the application on holding the down key
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            return true;
            
        }

        new MainView().dynamicUpdate(keyEvent);
        Attention.vibrate(vibeProfile);
        WatchUi.requestUpdate();

        return true;
    }

}