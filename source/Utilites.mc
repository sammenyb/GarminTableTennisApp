import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Timer;

class Stack {

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

    // Array to hold our stack elements
    private var stackArray as Array<StackEntry>;


    // Constructor
    function initialize() {
        stackArray = [];  // Initialize empty array
    }

    // // Push a new entry onto the stack
    // function push(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val) {
    //     // Create new entry
    //     var entry = new StackEntry(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val);
        
    //     // Increase array size and add new entry
    //     size++;
    //     stackArray = stackArray.add(entry);
    // }

    function push(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val) {
        // Create new entry
        var entry = new StackEntry(p1_val, p1Sets, p2_val, p2Sets, points_val, serving_val);
        stackArray = stackArray.add(entry);
    }

    // // Pop an entry from the stack and return it
    // function pop() {
    //     if (size == 0) {
    //         return null;  // Stack is empty
    //     }

    //     // Get the top entry
    //     var topEntry = stackArray[size - 1];
        
    //     // Remove it from the array
    //     stackArray = stackArray.slice(0, size - 1);
    //     size--;

    //     return topEntry;
    // }

    function pop() {
        var currentSize = stackArray.size();
        if (currentSize == 0) {
            return null;
        }
        var topEntry = stackArray[currentSize - 1];
        stackArray = stackArray.slice(0, currentSize - 1);
        return topEntry;
    }


    // Check if stack is empty
    function isEmpty() {
        return stackArray.size() == 0;
    }

    // Get current size of stack
    function getSize() {
        return stackArray.size();
    }
}