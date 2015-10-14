//
//  main.swift
//  BuildACalculator
//
//  Created by Derry Cheng on 10/12/15.
//  Copyright © 2015 Derry Cheng. All rights reserved.
//  This is a calculator that calculates stuff.

import Foundation


print("Hello, welcome to the calculator!")



func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,
        encoding:NSUTF8StringEncoding) as! String
    return
        result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

// Converts strings to doubles
func convert(incoming:String) -> Double {
    return NSNumberFormatter().numberFromString(incoming)!.doubleValue
}

// Generic Math Operation function that takes strings and calls for functions
// to calculate what the user requests.
func mathOperator(problem : String) -> Double{
    if problem.rangeOfString("+") != nil {
        let calculate : [String] = problem.componentsSeparatedByString("+")
        return add(convert(calculate[0]), secondNumber: convert(calculate[1]))
    } else if problem.rangeOfString("-") != nil {
        let calculate : [String] = problem.componentsSeparatedByString("-")
        return subtract(convert(calculate[0]), secondNumber: convert(calculate[1]))
    } else if problem.rangeOfString("*") != nil {
        let calculate : [String] = problem.componentsSeparatedByString("*")
        return multiply(convert(calculate[0]), secondNumber: convert(calculate[1]))
    } else {
        let calculate : [String] = problem.componentsSeparatedByString("/")
        return divide(convert(calculate[0]), secondNumber: convert(calculate[1]))
    }
    
}

func add(firstNumber : Double, secondNumber : Double) -> Double {
    return firstNumber + secondNumber
}

func subtract(firstNumber : Double, secondNumber : Double) -> Double {
    return firstNumber - secondNumber
}

func multiply(firstNumber : Double, secondNumber : Double) -> Double {
    return firstNumber * secondNumber
}

func divide(firstNumber : Double, secondNumber : Double) -> Double {
    return firstNumber / secondNumber + firstNumber % secondNumber
}

// If status == 1, aborts program.
var status : Int = 0

// Keeps asking users to calculate until user enters 0 to end the
// program
while (status == 0){
    print("What would you like to calculate? Ex: 1+4")
    print("To abort the program, enter 0")
    let userInput : String = input()
    if (userInput == "0"){
        status = 1
    } else {
        let result : Double = mathOperator (userInput)
        
        // Converts a whole number to an Int, otherwise
        // prints double.
        if (result % 1 == 0){
            var myIntValue : Int = Int(result)
            print("The answer is \(myIntValue)");
            print("")
        } else {
            print ("The answer is \(result)");
            print("")
        }
    }
}




