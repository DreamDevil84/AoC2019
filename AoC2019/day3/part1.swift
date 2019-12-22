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

struct Coord: CustomStringConvertible{
    var x = 0
    var y = 0
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var description: String{
        return "\(x),\(y)"
    }
}

struct Line: CustomStringConvertible{
    var isVertical = false
    var start: Coord
    var end: Coord
    
    init(isVertical: Bool, start: Coord, end: Coord) {
        self.isVertical = isVertical
        self.start = start
        self.end = end
    }
    
    var description: String{
        return "\nVertical: \(isVertical), Start: \(start), End: \(end)"
    }
    
}

var stringArray: [[String]] = []
var wires: [[Line]] = []

func getData(){
    let array = input.components(separatedBy: "\n")
    stringArray.append(array[0].components(separatedBy: ","))
    stringArray.append(array[1].components(separatedBy: ","))
}

func getLines() -> [[Line]]{
    var wires: [[Line]] = []
    for wire in stringArray{
        var coord = Coord(x: 0, y: 0)
        var wireArray: [Line] = []
        for line in wire{
            let index = line.index(after: line.startIndex)
            let distance = Int(line[index...])!
            
            switch line.first!{
            case "R":
                let newCoord = Coord(x: coord.x + distance, y: coord.y)
                wireArray.append(Line(isVertical: false, start: coord, end: newCoord))
                coord = newCoord
                break
            case "L":
                let newCoord = Coord(x: coord.x - distance, y: coord.y)
                wireArray.append(Line(isVertical: false, start: newCoord, end: coord))
                coord = newCoord
                break
            case "U":
                let newCoord = Coord(x: coord.x, y: coord.y + distance)
                wireArray.append(Line(isVertical: true, start: coord, end: newCoord))
                coord = newCoord
                break
            case "D":
                let newCoord = Coord(x: coord.x, y: coord.y - distance)
                wireArray.append(Line(isVertical: true, start: newCoord, end: coord))
                coord = newCoord
                break
            default:
                print("Hello")
            }
        }
        wires.append(wireArray)
    }
    
    return wires
}

func findIntersections(wires: [[Line]]) -> [Int]{
    
    var distances: [Int] = []
    
    func compareLines(vertical: Line, horizontal: Line) -> Bool{
        let vStart = vertical.start.y
        let vEnd = vertical.end.y
        let hStart = horizontal.start.x
        let hEnd = horizontal.end.x
        if (vStart...vEnd).contains(horizontal.start.y) && (hStart...hEnd).contains(vertical.start.x){
            return true
        }
        return false
    }
    
    for a in wires[0]{
        for b in wires[1]{
            if a.isVertical && !b.isVertical{
                if compareLines(vertical: a, horizontal: b){
                    let distance = abs(a.start.x) + abs(b.start.y)
                    distances.append(distance)
                }
                
            } else if !a.isVertical && b.isVertical{
                if compareLines(vertical: b, horizontal: a){
                    let distance = abs(a.start.y) + abs(b.start.x)
                    distances.append(distance)
                }
            }
        }
    }
    return distances
}

func findClosest(distances: [Int]) -> Int{
    var closest = Int.max
    
    for num in distances{
        if num != 0 && num < closest{
            closest = num
        }
    }
    return closest
}
getData()
wires = getLines()

let dist = findIntersections(wires: wires)

let answer = findClosest(distances: dist)
print("Closest: \(answer)")
//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
