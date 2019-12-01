//
//  part2.swift
//
//  Created by Daniel Edström on 2019-12-01.
//  Copyright © 2019 Daniel Edström. All rights reserved.
//
import Foundation
let timeStart = Date().timeIntervalSince1970

let fileUrl = Bundle.main.url(forResource: "data" , withExtension: "txt")
let input = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)

//-------------------------------------
func makeArray(data: String) -> [Int]{
    let array = data.components(separatedBy: "\n")
    var count = 0
    for entry in array {
        if entry != ""{
            count += 1
        }
    }
    
    //The purpose of count is to make a fixed array, this scales better than using append
    var intArray = [Int](repeating: 0, count: count)

    for i in 0..<count{
        intArray[i] = Int(array[i])!
    }
    
    return intArray
}

var iArray = makeArray(data: input)

var result = 0

func fuelCalc(fuel: Int) -> Int{
    var extraFuel = (fuel / 3) - 2
    if extraFuel > 0 {
        extraFuel += fuelCalc(fuel: extraFuel)
    } else {
        extraFuel = 0
    }
    return extraFuel
}

for i in 0..<iArray.count{
    let fuel = (iArray[i] / 3) - 2
    let extraFuel = fuelCalc(fuel: fuel)
    result += fuel + extraFuel
}

print(result)


//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
