import Foundation
let timeStart = Date().timeIntervalSince1970

let fileUrl = Bundle.main.url(forResource: "data" , withExtension: "txt")
let input = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)

//-------------------------------------


print(input)


//-------------------------------------



let timeEnd = Int((Date().timeIntervalSince1970 - timeStart) * 1000)
print("Time: \(timeEnd) ms")
