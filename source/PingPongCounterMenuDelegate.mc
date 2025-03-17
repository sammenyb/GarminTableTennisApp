import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class PingPongCounterMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            new PingPongCounterView().resetMatch();
        // } else if (item == :item_2) {
        //     // Settings

        } else if (item == :item_3) {
            // About
            WatchUi.pushView(new PingPongAboutView(), null, WatchUi.SLIDE_UP);
        } else if (item == :item_4) {
            // Exit
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }

}