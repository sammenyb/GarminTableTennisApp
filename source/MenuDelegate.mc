import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Application.Storage;

class Menu2Delegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();   
    }

    var _currentMatchLengthId = "best_of_5"; // Default match length

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var mainView = new MainView();
        var id = item.getId() as String;
        var title = new $.DividerTitle();

        if (id.equals("reset_match")) {
            title = "Reset Match";
            mainView.resetMatch();

        } else if (id.equals("settings")) {
            // Settings menu
            if (!(WatchUi.Menu2 has :setDividerType)) {
                title = "Settings";
            }
            var settingsMenu = new WatchUi.Menu2({:title=>title});
            settingsMenu.addItem(new WatchUi.MenuItem("Match Length", null, "match_length",  null));
            settingsMenu.addItem(new WatchUi.MenuItem("Watch Arm", null, "watch_arm", null));
            settingsMenu.addItem(new WatchUi.MenuItem("Language", null, "language", null));
            WatchUi.pushView(settingsMenu, new SettingsMenuDelegate(settingsMenu), WatchUi.SLIDE_UP);
            WatchUi.requestUpdate();

        } else if (id.equals("exit")) {
            // Exit
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.requestUpdate();
        }
    }

}

//! This is the menu input delegate shared by all the basic sub-menus in the application
class Menu2SubMenuDelegate extends WatchUi.Menu2InputDelegate {
    private var _menu as WatchUi.Menu2;

    //! Constructor
    //! @param menu The menu to be used
    public function initialize(menu as WatchUi.Menu2) {
        _menu = menu;
        Menu2InputDelegate.initialize();
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        // For IconMenuItems, we will change to the next icon state.
        // This demonstrates a custom toggle operation using icons.
        // Static icons can also be used in this layout.
        if (item.getId().equals("best_of_3") || item.getId().equals("best_of_5") || item.getId().equals("best_of_7")) {

            for (var i = 0; i < 3; i++) {
                var menuItem = _menu.getItem(i);
                if (menuItem instanceof WatchUi.IconMenuItem) {
                    (menuItem.getIcon() as CustomIcon).uncheckBool();
                }
            }

            (item.getIcon() as CustomIcon).checkBool();
            if (item.getId().equals("best_of_3")) {
                Storage.setValue("match_length", 3);
            } else if (item.getId().equals("best_of_5")) {
                Storage.setValue("match_length", 5);
            } else if (item.getId().equals("best_of_7")) {
                Storage.setValue("match_length", 7);
            }

            match_length = Storage.getValue("match_length");

        } else if (item.getId().equals("left_arm") || item.getId().equals("right_arm")) {
            (_menu.getItem(0).getIcon() as CustomIcon).uncheckBool();
            (_menu.getItem(1).getIcon() as CustomIcon).uncheckBool();

            (item.getIcon() as CustomIcon).checkBool();

            Storage.setValue("watch_arm", item.getId());
            watch_arm = Storage.getValue("watch_arm");
        }

    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        WatchUi.requestUpdate();
    }

}



//! This is the drawable for the Menu2 title with instructions to change the divider type
class DividerTitle extends WatchUi.Drawable {

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
    }

    //! Draw the title with instructions to change the divider type
    //! @param dc Device context
    public function draw(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLUE);
        dc.clear();

        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, "Press the back\nbutton to change\ndivider type", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
