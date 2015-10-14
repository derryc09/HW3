//
//  main.swift
//  Points
//
//  Created by Derr Cheng on 10/13/15.
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
func convert(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}
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
print("Would you like to switch to Dictionary mode? Enter Y/N")
var userInput = input();

print("")
print("Please enter the first point -> Return -> +/- -> Return -> second point.")
print("Enter points in this syntax: \"x,y\" Ex: \"4,5\"")
print("")
var checkDouble = 0;
if (userInput.lowercaseString == "n"){
    userInput = input();
    var userInputArr = userInput.componentsSeparatedByString(",")
    if (userInputArr.count != 2) {
        print("We only support points on the x,y coordinates")
    } else {
        let pointOne : (Int, Int) = (convert(userInputArr[0]),convert(userInputArr[1]))

        var expression = input();

        userInput = input();
        userInputArr = userInput.componentsSeparatedByString(",")
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
} else if (userInput.lowercaseString == "y"){
    print ("Please enter the point")
    var userInputDict = input()
    var userInputDictArr = userInputDict.componentsSeparatedByString(",")

    for(var i = 0; i < userInputDictArr.count; i++){
        if(convertDoub(userInputDictArr[i]) % 1 != 0){
            print("We only accept Whole numbers.")
            i = userInputDictArr.count;
            checkDouble = 1;
        }
    }
    if(userInputDictArr[userInputDictArr.count-1] == ""){
        userInputDictArr.removeLast()
    }
    
    while (userInputDictArr.count != 2){
        print ("You must provide both AND only x and y coordinates!!!!!!!!!!!!!!!!!!")
        print ("Please re-enter the point")
        userInputDict = input()
        userInputDictArr = userInputDict.componentsSeparatedByString(",")
        if(userInputDictArr[userInputDictArr.count-1] == ""){
            userInputDictArr.removeLast()
        }
    }
    
    var pointsDictionary = [
        "pointOneX1" : userInputDictArr[0],
        "pointOneY1" : userInputDictArr[1],
    ]
    var expression = input();

    userInputDict = input()
    userInputDictArr = userInputDict.componentsSeparatedByString(",")
    for(var i = 0; i < userInputDictArr.count; i++){
        if(convertDoub(userInputDictArr[i]) % 1 != 0){
            print("We only accept Whole numbers.")
            i = userInputDictArr.count;
            checkDouble = 1;
        }
    }
    if(userInputDictArr[userInputDictArr.count-1] == ""){
        userInputDictArr.removeLast()
    }
    while(userInputDictArr.count != 2){
        print ("You must provide both AND only x and y coordinates!!")
        print ("Please re-enter the point")
        userInputDict = input()
        userInputDictArr = userInputDict.componentsSeparatedByString(",")
        if(userInputDictArr[userInputDictArr.count-1] == ""){
            userInputDictArr.removeLast()
        }
    }
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
    func subtractDict(paramDict:Dictionary<String,String>){
        if(checkDouble != 1){
            let result = ((convert(paramDict["pointOneX1"]!) - convert(paramDict["pointTwoX1"]!)),(convert(paramDict["pointOneY1"]!) - convert(paramDict["pointTwoY1"]!)))
            print(result)
        } else {
            print("Please try again with whole numbers.")
        }
    }
    pointsDictionary["pointTwoX1"] = userInputDictArr[0]
    pointsDictionary["pointTwoY1"] = userInputDictArr[1]
    if(expression == "+"){
        addDict(pointsDictionary)
    } else if (expression == "-"){
        subtractDict(pointsDictionary)
    } else {
        print("Unknown command")
    }
} else {
    print("Unknown command. Please restart the program.")
}