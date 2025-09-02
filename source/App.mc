import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;
import Toybox.WatchUi;

public var settingsVibration = true;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        var view = new MainView();
        WatchUi.pushView(view, new MainDelegate(), WatchUi.SLIDE_UP);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new MainView(), new MainDelegate() ];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}