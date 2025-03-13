import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;
import Toybox.Timer;

var _p1Score_ctr = 0;
var _p2Score_ctr = 0;
var _p1Score = null;
var _p2Score = null;
var _p1Set_ctr = 0;
var _p2Set_ctr = 0;
var _p1Set = null;
var _p2Set = null;
var _total_points = 0;

var _whoServes = 2;
var _setServer = _whoServes;

var updateTimer = null;

class PingPongCounterView extends WatchUi.View {

    function initialize() {
        View.initialize();
        if (updateTimer != null) {
            updateTimer.stop();
        }
        updateTimer = new Timer.Timer();
        updateTimer.start(method(:timerCallback), 1000, true);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        _p1Score = findDrawableById("p1_score") as WatchUi.Text;
        _p2Score = findDrawableById("p2_score") as WatchUi.Text;
        _p1Set = findDrawableById("p1_set") as WatchUi.Text;
        _p2Set = findDrawableById("p2_set") as WatchUi.Text;

    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var timeView = findDrawableById("time_label") as WatchUi.Text;
        timeView.setText(timeString);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY); // Set border color
        dc.setPenWidth(2); // Set border width
        dc.drawRoundedRectangle(90, 220, 80, 50, 10);

        dc.drawLine(41, 129, 79, 129);
        dc.drawLine(179, 129, 217, 129);

        if (_whoServes == 1) {
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE); // Set border color
            dc.setPenWidth(3);
            dc.drawRoundedRectangle(28, 90, 64, 92, 7);

        } else if (_whoServes == 2) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED); // Set border color
            dc.setPenWidth(3);
            dc.drawRoundedRectangle(167, 90, 64, 92, 7);
        } else {
            System.println("No one is serving");
        }

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function timerCallback() as Void {
        WatchUi.requestUpdate();
    }
    

    function dynamicUpdate(keyEvent) as Void {
        if (keyEvent.getKey() == 8) {
            // System.println("dynamicUpdate: KEY_DOWN");
            // var p1Score = self.findDrawableById("p1_score") as WatchUi.Text;
            if (_p1Score != null) {
                _p1Score_ctr++;
                _p1Score.setText(_p1Score_ctr.toString());
                // System.println("dynamicUpdate: view found: " + _p1Score);
                matchLogic();
            } else {
                System.println("dynamicUpdate: view not found");
            }
        } else if (keyEvent.getKey() == 5) {
            // System.println("dynamicUpdate: KEY_BACK");
            // var p2Score = self.findDrawableById("p2_score") as WatchUi.Text;
            if (_p2Score != null) {
                _p2Score_ctr++;
                _p2Score.setText(_p2Score_ctr.toString());
                // System.println("dynamicUpdate: view found: " + _p2Score);
                matchLogic();
            } else {
                System.println("dynamicUpdate: view not found");
            }
        } else if (keyEvent.getKey() == 13) {
            // System.println("dynamicUpdate: KEY_UP");
            if(_total_points == 0 && _p1Set_ctr == 0 && _p2Set_ctr == 0) {
                switchServer();
                _setServer = _whoServes;
            }
        } else if (keyEvent.getKey() == 4) {
            // System.println("dynamicUpdate: KEY_START");
            // if (_total_points > 0) {
            //     _total_points--;
            //     matchLogic();
            // }
        }

    }

    function matchLogic() as Void {
        toggleServer();
        _total_points++;

        if (_p1Set_ctr >= 2) {
            System.println("Player 1 wins the match");
            // winMatch();
            resetMatch();
        } else if (_p2Set_ctr >= 2) {
            System.println("Player 2 wins the match");
            // winMatch();
            resetMatch();
        }

        if (isDeuce()) {
            if (_p1Score_ctr - _p2Score_ctr == 2) {
                System.println("Player 1 wins");
                _p1Set_ctr++;
                _p1Set.setText(_p1Set_ctr.toString());
                resetGame();
            } else if (_p2Score_ctr - _p1Score_ctr == 2) {
                System.println("Player 2 wins");
                _p2Set_ctr++;
                _p2Set.setText(_p2Set_ctr.toString());
                resetGame();
            }
        } else {
            if (_p1Score_ctr == 11) {
                System.println("Player 1 wins");
                _p1Set_ctr++;
                _p1Set.setText(_p1Set_ctr.toString());
                resetGame();
            } else if (_p2Score_ctr == 11) {
                System.println("Player 2 wins");
                _p2Set_ctr++;
                _p2Set.setText(_p2Set_ctr.toString());
                resetGame();
            }
        }
    }

    function isDeuce() as Boolean {
        if (_p1Score_ctr >= 10 && _p2Score_ctr >= 10) {
            return true;
        } else {
            return false;
        }
    }

    // logic to change who serves
    function switchServer() as Void {
        if (_whoServes == 1) {
            _whoServes = 2;
        } else {
            _whoServes = 1;
        }
    }

    function setServer() as Void {
        if (_setServer == 1) {
            _setServer = 2;
        } else {
            _setServer = 1;
        }
        _whoServes = _setServer;
    }

    // logic to switch between togglemodes
    function toggleServer() as Void {
        if  (isDeuce()) {
            switchServer();
        } else {
            if (_total_points % 2 == 1) {
                switchServer();
            }
        }
    }

    function resetGame() as Void {
        _p1Score_ctr = 0;
        _p2Score_ctr = 0;
        _total_points = 0;
        _p1Score.setText(_p1Score_ctr.toString());
        _p2Score.setText(_p2Score_ctr.toString());
        setServer();
    }

    function resetMatch() as Void {
        resetGame();
        _p1Set_ctr = 0;
        _p2Set_ctr = 0;
        _p1Set.setText(_p1Set_ctr.toString());
        _p2Set.setText(_p2Set_ctr.toString());
    }

    // function winMatch() as Void {
    //     if (_p1Set_ctr > _p2Set_ctr) {
    //         System.println("Player 1111 wins the match");
    //         var winnerLayer = new WatchUi.Layer({:x => 0, :y => 0, :width => 240, :height => 240});
    //         winnerLayer.getDc().setColor(Graphics.COLOR_PINK, Graphics.COLOR_PINK);
    //         winnerLayer.getDc().drawText(100, 100, Graphics.FONT_LARGE, "Player 1 wins the match", Graphics.TEXT_JUSTIFY_CENTER);
    //         addLayer(winnerLayer);
    //         WatchUi.requestUpdate();
    //     } else {
    //         System.println("Player 2 wins the match");
    //     }
    // }
    
}