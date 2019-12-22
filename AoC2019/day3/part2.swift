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

func findIntersections(wires: [[Line]]) -> [[(x: Int, y: Int, fullDistance: Int, index: Int)]]{
    
    var distances: [[(x: Int, y: Int, fullDistance: Int, index: Int)]] = []
    
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
    
    func getWireIntersections(_ mainWire: [Line], _ secondaryWire: [Line], _ wireNumber: Int) -> [(x: Int, y: Int, fullDistance: Int, index: Int)]{
        
        var wireIntersections: [(x: Int, y: Int, fullDistance: Int, index: Int)] = []
        var wireIndex = 0
        func getFullWireDistance(_ wire: [[String]], _ wireIndex: Int, _ intersectDistance: Int) -> Int{
            
            var fullDistance = 0
            for i in 0..<wireIndex{
                let line = wire[wireNumber][i]
                let index = line.index(after: line.startIndex)
                fullDistance += Int(line[index...])!
            }
            
            let line = wire[wireNumber][wireIndex]
            let index = line.index(after: line.startIndex)
            let distance = Int(line[index...])!
            
            switch line.first {
            case "R":
                fullDistance += intersectDistance
                break
            case "L":
                fullDistance += distance - intersectDistance
                break
            case "U":
                fullDistance += intersectDistance
                break
            case "D":
                fullDistance += distance - intersectDistance
                break
            default:
                print("OOPS")
            }
            
            return fullDistance
        }
        func newEntry(_ vertical: Line, _ horizontal: Line, intersectDistance: Int){
            let fullDistance = getFullWireDistance(stringArray, wireIndex, intersectDistance)
            var update = true
            for i in wireIntersections{
                if i.x == vertical.start.x && i.y == horizontal.start.y{
                    update = false
                }
            }
            if update{
                wireIntersections.append((x: vertical.start.x, y: horizontal.start.y, fullDistance: fullDistance, index: wireIndex))
            }
        }
        
        for main in mainWire{
            for secondary in secondaryWire{
                if main.isVertical && !secondary.isVertical{
                    if compareLines(vertical: main, horizontal: secondary){
                        newEntry(main, secondary, intersectDistance: secondary.start.y - main.start.y)
                    }
                } else if !main.isVertical && secondary.isVertical{
                    if compareLines(vertical: secondary, horizontal: main){
                        newEntry(secondary, main, intersectDistance: secondary.start.x - main.start.x)
                    }
                }
            }
            wireIndex += 1
        }
        return wireIntersections
    }
    
    distances.append(getWireIntersections(wires[1], wires[0], 1))
    distances.append(getWireIntersections(wires[0], wires[1], 0))
    
    return distances
}

func findShortest(distances: [[(x: Int, y: Int, fullDistance: Int, index: Int)]]) -> Int{
    var shortest = Int.max
    
    for a in distances[0]{
        for b in distances[1]{
            if a.fullDistance != 0 || b.fullDistance != 0{
                if a.x == b.x && a.y == b.y{
                    let distance = a.fullDistance + b.fullDistance
                    if distance < shortest{
                        shortest = distance
                    }
                }
            }
        }
    }
    
    return shortest
    
}

getData()

let answer = findShortest(distances: findIntersections(wires: getLines()))

print("Shortest: \(answer)")
//-------------------------------------

let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
