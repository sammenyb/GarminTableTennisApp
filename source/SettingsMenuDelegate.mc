import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;


class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize(menu as WatchUi.Menu2) {
        Menu2InputDelegate.initialize();
    }


    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;


        if (id.equals("match_length")) {
            // Match Length menu
            var matchLengthMenu = new WatchUi.Menu2({:title=>"Match Length"});
            var bestOf3Icon = new $.CustomIcon();
            var bestOf5Icon = new $.CustomIcon();
            var bestOf7Icon = new $.CustomIcon();

            if (match_length == 3) {
            bestOf3Icon.checkBool();
            } else if (match_length == 5) {
            bestOf5Icon.checkBool();
            } else if (match_length == 7) {
            bestOf7Icon.checkBool();
            }

            var bestOf3Item = new WatchUi.IconMenuItem("Best of 3", null, "best_of_3", bestOf3Icon, null);
            var bestOf5Item = new WatchUi.IconMenuItem("Best of 5", null, "best_of_5", bestOf5Icon, null);
            var bestOf7Item = new WatchUi.IconMenuItem("Best of 7", null, "best_of_7", bestOf7Icon, null);

            matchLengthMenu.addItem(bestOf3Item);
            matchLengthMenu.addItem(bestOf5Item);
            matchLengthMenu.addItem(bestOf7Item);
            WatchUi.pushView(matchLengthMenu, new $.Menu2SubMenuDelegate(matchLengthMenu), WatchUi.SLIDE_UP);

        } else if (id.equals("watch_arm")) {
            // Watch Arm menu
            var watchArmMenu = new WatchUi.Menu2({:title=>"Watch Arm"});
            var leftArmIcon = new $.CustomIcon();
            var rightArmIcon = new $.CustomIcon();

            if (watch_arm.equals("left_arm")) {
                leftArmIcon.checkBool();
            } else {
                rightArmIcon.checkBool();
            }

            var leftArmItem = new WatchUi.IconMenuItem("Left Arm", null, "left_arm", leftArmIcon, null);
            var rightArmItem = new WatchUi.IconMenuItem("Right Arm", null, "right_arm", rightArmIcon, null);

            watchArmMenu.addItem(leftArmItem);
            watchArmMenu.addItem(rightArmItem);
            WatchUi.pushView(watchArmMenu, new $.Menu2SubMenuDelegate(watchArmMenu), WatchUi.SLIDE_UP);

        // } else if (id.equals("language")) {
        //     // Language menu
        //     var languageMenu = new WatchUi.Menu2({:title=>"Language"});
        //     languageMenu.addItem(new WatchUi.MenuItem("English", "english", false, null));
        //     languageMenu.addItem(new WatchUi.MenuItem("Swedish", "swedish", false, null));
        //     WatchUi.pushView(languageMenu, new $.Menu2SubMenuDelegate(languageMenu), WatchUi.SLIDE_UP);

        } else { // Go back
            WatchUi.requestUpdate();
        }
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        WatchUi.requestUpdate();
    }

}

//! This is the custom Icon drawable. It fills the icon space with a color
//! to demonstrate its extents. It changes color each time the next state is
//! triggered, which is done when the item is selected in this application.
class CustomIcon extends WatchUi.Drawable {
    // This constant data stores the color state list.
    // private const _colorStrings = ["Red", "Orange", "Yellow", "Green", "Blue", "Violet"];
    // private var _index as Number;
    private var _checked = false;

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
        _checked = 0;
    }

    public function checkBool() as Void {
        _checked = true;
    }

    public function uncheckBool() as Void {
        _checked = false;
    }

    //! Set the color for the current state and use dc.clear() to fill
    //! the drawable area with that color
    //! @param dc Device Context
    public function draw(dc as Dc) as Void {
        if (_checked) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawCircle(16, 28, 14);
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
            dc.fillCircle(16, 28, 8);
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawCircle(16, 28, 14);
        }
        dc.clear();
    }
}
