//
//  part2.swift
//
//  Created by Daniel Edström on 2019-12-01.
//  Copyright © 2019 Daniel Edström. All rights reserved.
//
import Foundation
let timeStart = Date().timeIntervalSince1970

let fileUrl = Bundle.main.url(forResource: "data" , withExtension: "txt")
var input = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)

//-------------------------------------

let stringArray = input.components(separatedBy: ["\n"])

func getIntArray(_ string: String) -> [Int]{
    var intArray: [Int] = []
    let s = string.components(separatedBy: ",")
    for i in s{
        intArray.append(Int(i)!)
    }
    return intArray
}

let intArray = getIntArray(stringArray[0])

func intComp(_ intArray: [Int], input: Int) -> [Int]{
    var array = intArray
    func extractParameters(num: Int) -> (opCode: Int, parameters: [Int]){
        let opCode = num % 100
        let parameters = num / 100
        var digits: [Int] { String("\(parameters)").compactMap{ $0.wholeNumberValue } }
        return (opCode: opCode, parameters: digits.reversed())
    }
    func getValue(_ index: Int, _ parameters: [Int], _ parameterIndex: Int) -> Int{
        if parameters.indices.contains(parameterIndex) && parameters[parameterIndex] == 1{
            return array[index]
        } else {
            return array[array[index]]
        }
    }
    var index = 0
    while index < array.count{
        let num = extractParameters(num: array[index])
        var firstVal: Int {
            if array.indices.contains(index+1){
                return getValue(index+1, num.parameters, 0)
            } else {
                return 0
            }
        }
        var secondVal: Int {
            if array.indices.contains(index+2){
                return getValue(index+2, num.parameters, 1)
            } else {
                return 0
            }
        }
        switch num.opCode {
        case 1:
            array[array[index+3]] = firstVal + secondVal
            index += 3
        case 2:
            array[array[index+3]] = firstVal * secondVal
            index += 3
        case 3:
            array[array[index+1]] = input
            index += 1
        case 4:
            print("Output: \(firstVal)")
            index += 1
        case 5:
            if firstVal != 0{
                index = secondVal - 1
            } else {
                index += 2
            }
        case 6:
            if firstVal == 0{
                index = secondVal - 1
            } else {
                index += 2
            }
        case 7:
            if firstVal < secondVal{
                array[array[index+3]] = 1
            } else {
                array[array[index+3]] = 0
            }
            index += 3
        case 8:
            if firstVal == secondVal{
                array[array[index+3]] = 1
            } else {
                array[array[index+3]] = 0
            }
            index += 3
        case 99:
            index = array.count
        default:
            break
        }
        index += 1
    }
    return array
}


let x = intComp(intArray, input: 5)
//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
