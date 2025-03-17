import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Timer;

class Stack {
    // Array to hold our stack elements
    private var stackArray;
    private var size;

    // Structure definition using a class
    class StackEntry {
        var p1;      // int
        var p1Sets;  // int
        var p2;      // int
        var p2Sets;  // int
        var points;  // int
        var serving; // int

        function initialize(p1_val, p1Sets_val, p2_val, p2Sets_val, points_val, serving_val) {
            p1 = p1_val;
            p1Sets = p1Sets_val;
            p2 = p2_val;
            p2Sets = p2Sets_val;
            points = points_val;
            serving = serving_val;
        }
    }

    // Constructor
    function initialize() {
        stackArray = new [0];  // Initialize empty array
        size = 0;
    }

    // Push a new entry onto the stack
    function push(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val) {
        // Create new entry
        var entry = new StackEntry(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val);
        
        // Increase array size and add new entry
        size++;
        stackArray = stackArray.add(entry);
    }

    // Pop an entry from the stack and return it
    function pop() {
        if (size == 0) {
            return null;  // Stack is empty
        }

        // Get the top entry
        var topEntry = stackArray[size - 1];
        
        // Remove it from the array
        stackArray = stackArray.slice(0, size - 1);
        size--;

        return topEntry;
    }

    // Check if stack is empty
    function isEmpty() {
        return size == 0;
    }

    // Get current size of stack
    function getSize() {
        return size;
    }
}