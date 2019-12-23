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

let stringArray = input.components(separatedBy: ["-", "\n"])

func getIntArray(_ string: String) -> [Int]{
    var intArray: [Int] = []
    for i in 0..<string.count{
        let startIndex = string.index(string.startIndex, offsetBy: i)
        let endIndex = string.index(string.startIndex, offsetBy: i+1)
        let n = Int(string[startIndex..<endIndex])
        intArray.append(n!)
    }
    return intArray
}

var start = getIntArray(stringArray[0])
var end = getIntArray(stringArray[1])

//Find first workable password
func firstPassword(_ intArray: [Int]) -> [Int]{
    var newArray = intArray
    var hasDouble = false
    for i in 0..<intArray.count-1{
        let current = newArray[i]
        var next = newArray[i+1]
        
        if current > next{
            newArray[i+1] = current
            next = current
        }
        if current == next{
            hasDouble = true
        }
    }
    if !hasDouble{
        newArray[4] = newArray[5]
    }
    
    return newArray
}

start = firstPassword(start)

func findAllPasswords(_ start: [Int], _ end: [Int]) -> [[Int]]{
    var allPasswords: [[Int]] = []
    var password = start
    var run = true
    func increment(_ password: [Int], _ index: Int) -> [Int]{
        var newPassword = password
        if newPassword[index] < 9{
            newPassword[index] += 1
        } else {
            newPassword = increment(newPassword, index - 1)
            newPassword[index] = newPassword[index - 1]
        }
        return newPassword
    }
    func checkDoubles(password: [Int]) -> Bool{
        var hasDouble = false
        for i in 0...4{
            if password[i] == password[i + 1]{
                hasDouble = true
            }
        }
        return hasDouble
    }
    func keepGoing(start: [Int], end: [Int]) -> Bool{
        for i in 0...5{
            if start[i] < end[i]{
                return true
            } else if start[i] == end[i]{
                
            } else {
                return false
            }
        }
        return true
    }
    
    while run{
        if checkDoubles(password: password){
            allPasswords.append(password)
        }
        password = increment(password, 5)
        run = keepGoing(start: password, end: end)
    }
        
    return allPasswords
}





let allPasswords = findAllPasswords(start, end)
print("\(allPasswords.count) passwords")

//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
