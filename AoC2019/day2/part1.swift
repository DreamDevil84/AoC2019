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

input = input.replacingOccurrences(of: "\n", with: "")
let stringArray = input.components(separatedBy: ",")

var array = [Int](repeating: 0, count: stringArray.count)

for x in 0..<stringArray.count{
    array[x] = Int(stringArray[x])!
}

array[1] = 12
array[2] = 2

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


print(array[0])

//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")

