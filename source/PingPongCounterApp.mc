import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;
import Toybox.WatchUi;

class PingPongCounterApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        var view = new PingPongCounterView();
        WatchUi.pushView(view, new PingPongCounterDelegate(), WatchUi.SLIDE_UP);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new PingPongCounterView(), new PingPongCounterDelegate() ];
    }

}

function getApp() as PingPongCounterApp {
    return Application.getApp() as PingPongCounterApp;
}