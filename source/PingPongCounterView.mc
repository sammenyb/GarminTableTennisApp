import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.Attention;


var p2Score_ctr = 0;
var p1Score_ctr = 0;
var p1Score = null;
var p2Score = null;
var p1Set_ctr = 0;
var p2Set_ctr = 0;
var p1Set = null;
var p2Set = null;
var total_points = 0;
var whoServes = 1;
var setServer = whoServes;
var updateTimer = null;



var matchStack = new Stack();

class PingPongCounterView extends WatchUi.View {

    function initialize() {
        View.initialize();
        if (updateTimer != null) {
            updateTimer.stop();
        }
        updateTimer = new Timer.Timer();
        updateTimer.start(method(:timerCallback), 1000, true);
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        p1Score = findDrawableById("p1_score") as WatchUi.Text;
        p2Score = findDrawableById("p2_score") as WatchUi.Text;
        p1Set = findDrawableById("p1_set") as WatchUi.Text;
        p2Set = findDrawableById("p2_set") as WatchUi.Text;
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var timeView = findDrawableById("time_label") as WatchUi.Text;
        timeView.setText(timeString);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY); // Set border color
        dc.setPenWidth(1); // Set border width
        dc.drawRoundedRectangle((dc.getWidth() / 2) - 40 , dc.getHeight() - (dc.getHeight()/7), 80, 60, 10);
        dc.setPenWidth(2); 

        if (whoServes == 1) {
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
            dc.setPenWidth(3);
            dc.drawRoundedRectangle(28, 90, 64, 92, 7);
        } else if (whoServes == 2) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);
            dc.setPenWidth(3);
            dc.drawRoundedRectangle(167, 90, 64, 92, 7);
        }
    }

    function timerCallback() as Void {
        WatchUi.requestUpdate();
    }

    function dynamicUpdate(keyEvent) as Void {
        if (keyEvent.getKey() == 8) { // Player 1 scores
            // DOWN_KEY
            if (p1Score != null) {
                matchStack.push(p1Score_ctr, p1Set_ctr, p2Score_ctr, p2Set_ctr, total_points, whoServes);
                p1Score_ctr++;
                p1Score.setText(p1Score_ctr.toString());
                matchLogic();
            }
        } else if (keyEvent.getKey() == 5) { // Player 2 scores
            // BACK_KEY
            if (p2Score != null) {
                matchStack.push(p1Score_ctr, p1Set_ctr, p2Score_ctr, p2Set_ctr, total_points, whoServes);
                p2Score_ctr++;
                p2Score.setText(p2Score_ctr.toString());
                matchLogic();
            }
        } else if (keyEvent.getKey() == 13) { // Switch server manually at start
            // UP_KEY
            if (total_points == 0 && p1Set_ctr == 0 && p2Set_ctr == 0) {
                switchServer();
                setServer = whoServes;
            }
        } else if (keyEvent.getKey() == 4) { // Undo last action
            // START_KEY
            var lastEntry = matchStack.pop();
            if (lastEntry != null) {
                p1Score_ctr = lastEntry.p1;
                p1Set_ctr = lastEntry.p1Sets;
                p2Score_ctr = lastEntry.p2;
                p2Set_ctr = lastEntry.p2Sets;
                total_points = lastEntry.points;
                whoServes = lastEntry.serving;
                p1Score.setText(p1Score_ctr.toString());
                p1Set.setText(p1Set_ctr.toString());
                p2Score.setText(p2Score_ctr.toString());
                p2Set.setText(p2Set_ctr.toString());
            }
        }
    }

    function matchLogic() as Void {
        toggleServer();
        total_points++;

        if (p1Set_ctr >= 2) {
            System.println("Player 1 wins the match");
            resetMatch();
        } else if (p2Set_ctr >= 2) {
            System.println("Player 2 wins the match");
            resetMatch();
        }

        if (isDeuce()) {
            if (p1Score_ctr - p2Score_ctr == 2) {
                p1Set_ctr++;
                p1Set.setText(p1Set_ctr.toString());
                resetGame();
            } else if (p2Score_ctr - p1Score_ctr == 2) {
                p2Set_ctr++;
                p2Set.setText(p2Set_ctr.toString());
                resetGame();
            }
        } else {
            if (p1Score_ctr == 11) {
                p1Set_ctr++;
                p1Set.setText(p1Set_ctr.toString());
                resetGame();
            } else if (p2Score_ctr == 11) {
                p2Set_ctr++;
                p2Set.setText(p2Set_ctr.toString());
                resetGame();
            }
        }
    }

    function isDeuce() as Boolean {
        return (p1Score_ctr >= 10 && p2Score_ctr >= 10);
    }

    function switchServer() as Void {
        whoServes = (whoServes == 1) ? 2 : 1;
    }

    function settingServer() as Void {
        setServer = (setServer == 1) ? 2 : 1;
        whoServes = setServer;
    }

    function toggleServer() as Void {
        if (isDeuce()) {
            switchServer();
        } else {
            if (total_points % 2 == 1) {
                switchServer();
            }
        }
    }

    function resetGame() as Void {
        p1Score_ctr = 0;
        p2Score_ctr = 0;
        total_points = 0;
        p1Score.setText(p1Score_ctr.toString());
        p2Score.setText(p2Score_ctr.toString());
        settingServer();
    }

    function resetMatch() as Void {
        resetGame();
        matchStack = new Stack();
        p1Set_ctr = 0;
        p2Set_ctr = 0;
        p1Set.setText(p1Set_ctr.toString());
        p2Set.setText(p2Set_ctr.toString());
    }
    
}
