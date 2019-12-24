//
//  part1.swift
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
    func getValue(index: Int, parameters: [Int], parameterIndex: Int) -> Int{
        var value = 0
        if parameters.count <= parameterIndex || parameters[parameterIndex] == 0{
            value = array[array[index]]
        } else if parameters[parameterIndex] == 1{
            value = array[index]
        }
        return value
    }
    var index = 0
    while index < array.count{
        let num = extractParameters(num: array[index])
        switch num.opCode {
        case 1:
            let firstArg = getValue(index: index+1, parameters: num.parameters, parameterIndex: 0)
            let secondArg = getValue(index: index+2, parameters: num.parameters, parameterIndex: 1)
            let sum = firstArg + secondArg
            let writeTo = array[index+3]
            array[writeTo] = sum
            index += 3
        case 2:
            let firstArg = getValue(index: index+1, parameters: num.parameters, parameterIndex: 0)
            let secondArg = getValue(index: index+2, parameters: num.parameters, parameterIndex: 1)
            let result = firstArg * secondArg
            let writeTo = array[index+3]
            array[writeTo] = result
            index += 3
        case 3:
            let inputIndex = array[index+1]
            array[inputIndex] = input
            index += 1
        case 4:
            let outputIndex = array[index+1]
            print(array[outputIndex])
            index += 1
        case 99:
            index = array.count
        default:
            break
        }
        index += 1
    }
    return array
}


let x = intComp(intArray, input: 1)
//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
