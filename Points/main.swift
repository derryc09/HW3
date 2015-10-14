//
//  main.swift
//  Points
//
//  Created by Derr Cheng on 10/13/15.
//  Copyright © 2015 Derry Cheng. All rights reserved.
//
//
//  This program allows user to calculate the sum or difference between
//  two points.
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

// Converts a string to an Integer
func convert(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

// Converts a string to a Double
func convertDoub(incoming:String) -> Double {
    return NSNumberFormatter().numberFromString(incoming)!.doubleValue
}

func add(pointOne:(x1:Int, y1:Int), pointTwo:(x2:Int, y2:Int)) -> (Int,Int){
    return (pointOne.x1+pointTwo.x2 ,pointOne.y1 + pointTwo.y2)
}

func subtract(pointOne:(x1:Int, y1:Int), pointTwo:(x2:Int, y2:Int)) -> (Int,Int){
    return (pointOne.x1 - pointTwo.x2 ,pointOne.y1 - pointTwo.y2)
}

print("Welcome to Coordinates calculator")

// Prompts if user would like to switch to calculate in Dictionary
// mode or tuples mode.
print("You are now in Tuples mode. Would you like to switch to Dictionary mode? Enter Y/N")
var userInput = input();

print("")
print("Please enter the first point -> Return -> +/- -> Return -> second point.")
print("Enter points in this syntax: \"x,y\" Ex: \"4,5\"")
print("")

var checkDouble = 0;

// Runs if user requests to run the program in Tuples Mode
if (userInput.lowercaseString == "n"){
    userInput = input();
    var userInputArr = userInput.componentsSeparatedByString(",")
    for(var i = 0; i < userInputArr.count; i++){
        if(userInputArr[i] == ""){
            userInputArr.removeAtIndex(i)
        }
    }
    if (userInputArr.count != 2) {
        print("We only support points on the x,y coordinates")
    } else {
        let pointOne : (Int, Int) = (convert(userInputArr[0]),convert(userInputArr[1]))

        var expression = input();

        userInput = input();
        userInputArr = userInput.componentsSeparatedByString(",")
        for(var i = 0; i < userInputArr.count; i++){
            if(userInputArr[i] == ""){
                userInputArr.removeAtIndex(i)
            }
        }
        if (userInputArr.count != 2) {
            print("We only support points on the x,y coordinates")
        } else {
            let pointTwo : (Int, Int) = (convert(userInputArr[0]),convert(userInputArr[1]))
            if(expression == "+"){
                var result = add(pointOne, pointTwo: pointTwo)
                print(result)
            } else if(expression == "-"){
                var result = subtract(pointOne, pointTwo: pointTwo)
                print(result)
            } else{
                print ("Unknown expression")
            }
        }
    }
    
// Runs if user requests to run in Dictionary mode.
} else if (userInput.lowercaseString == "y"){
    print ("Please enter the point")
    var userInputDict = input()
    var userInputDictArr = userInputDict.componentsSeparatedByString(",")
    
    // Removes empty arrays
    for(var i = 0; i < userInputDictArr.count; i++){
        if(userInputDictArr[i] == ""){
            userInputDictArr.removeAtIndex(i)
        }
    }
    // Loops through the array to check if contains any Doubles
    for(var i = 0; i < userInputDictArr.count; i++){
        if(convertDoub(userInputDictArr[i]) % 1 != 0){
            print("We only accept Whole numbers.")
            i = userInputDictArr.count;
            checkDouble = 1;
        }
    }
    
    // Throws an error and yells at user if user did not enter 
    // both X and Y coordinates. 
    if (userInputDictArr.count != 2){
        print ("You must provide both AND only x and y coordinates!!!!!!!!!!!!!!!!!!")
    } else if (checkDouble != 1) {
        
        // Builds out the Dictionary
        var pointsDictionary = [
            "pointOneX1" : userInputDictArr[0],
            "pointOneY1" : userInputDictArr[1],
        ]
        
        // Asks user whether to add/subtract the points
        var expression = input();

        // Tracks second point.
        userInputDict = input()
        userInputDictArr = userInputDict.componentsSeparatedByString(",")
        
        // Removes empty arrays.
        for(var i = 0; i < userInputDictArr.count; i++){
            if(userInputDictArr[i] == ""){
                userInputDictArr.removeAtIndex(i)
            }
        }
        
        // Loops through the array to check for Doubles.
        for(var i = 0; i < userInputDictArr.count; i++){
            if(convertDoub(userInputDictArr[i]) % 1 != 0){
                print("We only accept Whole numbers.")
                i = userInputDictArr.count;
                checkDouble = 1;
            }
        }
        

        
        // Checks to see both x and y coordinates were entered.
        if (userInputDictArr.count != 2 && checkDouble != 1){
            print ("You must provide both AND only x and y coordinates!!")
        } else {
        
            // If the points contain doubles, throws error and ends program.
            // If the points contain only whole numbers, calculates and prints
            // the results.
            func addDict(paramDict:Dictionary<String,String>){
                if(checkDouble != 1){
                    let x = convert(paramDict["pointOneX1"]!) + convert(paramDict["pointTwoX1"]!)
                    let y = convert(paramDict["pointOneY1"]!) + convert(paramDict["pointTwoY1"]!)
                    let result = (x,y)
                    print(result)
                } else {
                    print("Please try again with whole numbers")
                }
        }
        
        // If the points contain doubles, throws error and ends program.
        // If the points contain only whole numbers, calculates and prints
        // the results.
        func subtractDict(paramDict:Dictionary<String,String>){
            if(checkDouble != 1){
                let result = ((convert(paramDict["pointOneX1"]!) - convert(paramDict["pointTwoX1"]!)),(convert(paramDict["pointOneY1"]!) - convert(paramDict["pointTwoY1"]!)))
                print(result)
            } else {
                print("Please try again with whole numbers.")
            }
        }
        
        // Builds out the dictionary.
        pointsDictionary["pointTwoX1"] = userInputDictArr[0]
        pointsDictionary["pointTwoY1"] = userInputDictArr[1]
        
        // Calls for either Add/Subtract fuction depending on user's request. 
        // Throws an error if user entered something other than + or -
        if(expression == "+"){
            addDict(pointsDictionary)
        } else if (expression == "-"){
            subtractDict(pointsDictionary)
        } else {
            print("Unknown command")
        }
        }
    // Throws an error if user entered something other than y/n
    }
} else {
    print("Unknown command. Please restart the program.")
}