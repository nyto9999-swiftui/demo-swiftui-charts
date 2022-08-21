import Foundation
import Combine

struct Retails: Identifiable {
  var id = UUID()
  var InvoiceNo: String = ""
  var StockCode: String = ""
  var Description: String = ""
  var Quantity: String = ""
  var InvoiceDate: String = ""
  var UnitPrice: String = ""
  var CustomerID: String = ""
  var Country: String = ""
  
  init(raw: [String]) {
    InvoiceNo = raw[0]
    StockCode = raw[1]
    Description = raw[2]
    Quantity = raw[3]
    InvoiceDate = raw[4]
    UnitPrice = raw[5]
    CustomerID = raw[6]
    Country = raw[7]
  }
}

class RetailModel: ObservableObject {
  @Published private(set) var retails: [Retails] = []
  var progress = PassthroughSubject<Void, Never>()
  //541910.0
  let filename: String
  let url: URL
  
  init(filename: String) {
    self.filename = filename
    self.url = Bundle.main.url(forResource: filename, withExtension: "csv")!
  }
  
  //Duration: 0.4s
  func readSync() throws {
    let start = Date.now
    let contents = try String(contentsOf: url)
    var counter = 0
    contents.enumerateLines { _, _ in
      counter += 1
    }
    print("\(counter) lines")
    print("Duration: \(Date.now.timeIntervalSince(start))")
  }
  
  //Duration: 2.6s
  func readAsync() async throws {
    let start = Date.now
    var counter = 0
    for try await _ in url.lines {
      counter += 1
    }
    print("\(counter) lines")
    print("Duration: \(Date.now.timeIntervalSince(start))")
  }
  
  //heavy work here
  func getRetails() async throws {
     
    for try await line in url.lines {
      let row = line.components(separatedBy: "\n")[0]
      
      await MainActor.run {
        let retail = Retails.init(raw: row.components(separatedBy: ","))
        retails.append(retail)
        self.progress.send()
      }
      
    }
  }
}












//func loadCSV(from csvName: String) async throws -> [Retail] {
//
//  var csvToStruct = [Retail]()
//
//  guard
//    let filePath = Bundle.main.path(forResource: csvName, ofType: "csv"),
//    let data = try? String(contentsOfFile: filePath)
//  else { return [] }
//
//
//  var rows = data.components(separatedBy: "\n")
//  let columnCount = rows.first?.components(separatedBy: ",").count
//  rows.removeFirst()
//
//
//  for row in rows {
//    let csvColumns = row.components(separatedBy: ",")
//    if csvColumns.count == columnCount {
//      let retail = Retail.init(raw: csvColumns)
//      csvToStruct.append(retail)
//    }
//  }
//
//  return csvToStruct
//}

//
//struct RetailSequence: AsyncSequence {
//  typealias Element = Retail
//  typealias AsyncIterator = RetailIterator
//
//  let url: URL
//  let filename: String
//
//  init(filename: String) {
//    self.filename = filename
//    self.url = Bundle.main.url(forResource: filename, withExtension: "csv")!
//  }
  
  
//
//  func makeAsyncIterator() -> RetailIterator {
//    let url: URL
//    var iterator: AsyncLineSequence<URL.AsyncBytes>.AsyncIterator
//
//    init(url: URL) {
//      self.url = url
//      iterator = url.lines.makeAsyncIterator()
//    }
//
//    return makeAsyncIterator()
//  }
//}
//
//struct RetailIterator: AsyncIteratorProtocol {
//  func next() async throws -> Retail? {
//    return nil
//  }
//}
