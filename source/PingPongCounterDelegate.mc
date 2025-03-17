import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Attention;

var vibeProfile = [new Attention.VibeProfile(50, 100)];

class PingPongCounterDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new PingPongCounterMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent as KeyEvent) as Boolean {
        // System.println("PingPongCounterDelegate.onKey: " + keyEvent.getKey());
        if (keyEvent.getKey() == 22) {
            // Exit the application on holding the down key
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            return true;
            
        }

        new PingPongCounterView().dynamicUpdate(keyEvent);
        Attention.vibrate(vibeProfile);
        WatchUi.requestUpdate();

        return true;
    }

}