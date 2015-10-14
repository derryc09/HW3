//
//  main.swift
//  Array fun
//
//  Created by Derry Cheng on 10/13/15.
//  Copyright © 2015 Derry Cheng. All rights reserved.
//

import Foundation

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,
        encoding:NSUTF8StringEncoding) as! String
    return
        result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}
func convert(incoming:String) -> Double {
    return NSNumberFormatter().numberFromString(incoming)!.doubleValue
}


print("Please enter a list of integers, separated by commas.")
print("For example: 10,5,23,12,14")

let userInput = input()
let userInputArr = userInput.componentsSeparatedByString(",")

var gamestatus : Int = 0

print("")
print("What would you like to do with these numbers?")
print("Pick and enter: Add/Multiply/Count/Average")

// Loops until user enters 0 to abort the program
while (gamestatus == 0){
    
    var unknowncommand = 0;
    let task = input().lowercaseString;
    
    // Checks if User entered "0"
    if (task == "0"){
        gamestatus = 1
        print("")
    } else {
        // These functions take an array of Ints and returns the results.
        func add(list : [String]) -> Double{
            var total : Double = 0
            for (var i = 0; i<userInputArr.count; i++){
                total += convert(userInputArr[i])
            }
            return total;
        }

        func mul(list : [String]) -> Double{
            var total : Double = 1
            for (var i = 0; i<userInputArr.count; i++){
                total *= convert(userInputArr[i])
            }
            return total;
        }

        func count(list : [String]) -> Double{
            return Double(list.count);
        }

        func avg(list : [String]) -> Double{
            return add(list)/count(list);
        }
        
        // Generic Math Operator that calls on the function depending on 
        // the User's request
        func Operator(list:[String], task: String) -> Double{
            switch task{
            case "add":
                return add(userInputArr)
            case "multiply":
                return mul(userInputArr)
            case "count":
                return count(userInputArr)
            case "average":
                return avg(userInputArr);
            default:
                unknowncommand = 1
                print("Unknown command")
                print("")
                return 0.0;
            }
        }
        
    
        var result = Operator(userInputArr, task: task )
        
        // Checks if user entered an unknown command
        if(unknowncommand != 1){
            if result%1 != 0 {
                print("")
                print("The result is \(result)")
            } else {
                var resultInt = Int(result)
                print("")
                print("The result is \(resultInt)")
            }
        }
        print("What else would you like to do with these numbers?")
        print("Enter: Add/Multiply/Count/Average. To abort, enter 0")
        
    }
}




