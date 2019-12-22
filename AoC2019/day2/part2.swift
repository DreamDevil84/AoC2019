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

input = input.replacingOccurrences(of: "\n", with: "")
let stringArray = input.components(separatedBy: ",")
let target = 19690720

var program = [Int](repeating: 0, count: stringArray.count)
for x in 0..<stringArray.count{
    program[x] = Int(stringArray[x])!
}

func run(programInput: [Int], noun: Int, verb: Int) -> Int{
    var array = programInput
    array[1] = noun
    array[2] = verb
    var index = 0
    while index < array.count{
        switch array[index] {
        case 1:
            let firstIndex = array[index+1]
            let secondIndex = array[index+2]
            let sum = array[firstIndex] + array[secondIndex]
            let position = array[index+3]
            array[position] = sum
        case 2:
            let firstIndex = array[index+1]
            let secondIndex = array[index+2]
            let result = array[firstIndex] * array[secondIndex]
            let position = array[index+3]
            array[position] = result
        case 99:
            break
        default:
            index += 1
        }
        index += 4
    }
    return array[0]
}

var nounNumber = 0
var verbNumber = 0

for noun in 0...99{
    for verb in 0...99{
        if run(programInput: program, noun: noun, verb: verb) == target{
            print("Noun: \(noun), Verb: \(verb)")
            nounNumber = noun
            verbNumber = verb
        }
    }
}

print("Answer: \((100 * nounNumber) + verbNumber)")

//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
