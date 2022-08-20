import Foundation
import CoreXLSX

class Model: ObservableObject {
  var file: XLSXFile
  @Published var text = "123"
  
  init() {
    let bundle = Bundle.main.path(forResource: "online-retail", ofType: "xlsx")
    let file = XLSXFile(filepath: bundle!, bufferSize: UInt32.max, errorContextLength: UInt.max)!
    self.file = file
  }
  
  func parseSheet() {
    self.text = "123"
    DispatchQueue.global(qos: .background).async {
      let sharedStrings = try! self.file.parseSharedStrings()
      let columnCString = try! self.file.cellsInWorksheet(at: "xl/worksheets/sheet1.xml", rows: [1])
      print(columnCString)
      
//      let items = try! self.file.parseWorksheet(at: "xl/worksheets/sheet1.xml")
//      print(items)
    }
    
  }
  
}
