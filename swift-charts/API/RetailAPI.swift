import Foundation
import Combine
import CoreData
import SwiftUI
 
class RetailModel: ObservableObject {
  let shared = CoreDataStack.shared
  let moc = CoreDataStack.shared.viewContext
  var progress = PassthroughSubject<Void, Never>()
  
  let filename: String
  let url: URL
  
  init(filename: String) {
    self.filename = filename
    self.url = Bundle.main.url(forResource: filename, withExtension: "csv")!
  }
   
  //3 mins 51 sec
  func ayncStreamPull() async {
    var iterator = url.lines.makeAsyncIterator()
    let stream = AsyncStream<[String]> {
      do {
        if let line = try await iterator.next(), !line.isEmpty {
          let row = line.components(separatedBy: "\n")[0]
          let values = row.components(separatedBy: ",")
          return values
        }
      } catch let error {
        print(error.localizedDescription)
      }
      return nil
    }
   
    for await values in stream {
      await MainActor.run {
        if values.count == 8
        {
          shared.csvToDisk(values: values)
          self.progress.send()
        }
      }
    }
  }
}


func convertDate(from: String) -> Date? {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd/MM/yy HH:mm"
  return dateFormatter.date(from: from)
}
//InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
//["537153", "22865", "HAND WARMER OWL DESIGN", "8", "12/5/10 13:03", "2.1", "16718", "United Kingdom"]
