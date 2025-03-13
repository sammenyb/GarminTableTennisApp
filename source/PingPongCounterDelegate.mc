import Toybox.Lang;
import Toybox.WatchUi;

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
        // if (keyEvent.getKey() == 8) {
        //     System.println("PingPongCounterDelegate.onKey: KEY_DOWN");
            
        //     return true;
        // } else if (keyEvent.getKey() == 13) {
        //     System.println("PingPongCounterDelegate.onKey: KEY_UP");
        //     return true;
        // } else if (keyEvent.getKey() == 4) {
        //     System.println("PingPongCounterDelegate.onKey: KEY_START");
        //     return true;
        // } else if (keyEvent.getKey() == 5) {
        //     System.println("PingPongCounterDelegate.onKey: KEY_BACK");
        //     return true;
        // }

        new PingPongCounterView().dynamicUpdate(keyEvent);
        WatchUi.requestUpdate();

        return true;
    }

}