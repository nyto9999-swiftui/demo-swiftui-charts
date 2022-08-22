import Foundation
import Combine
import CoreData
import SwiftUI


class RetailModel: ObservableObject {
  var progress = PassthroughSubject<Void, Never>()
  
  let filename: String
  let url: URL
  
  init(filename: String) {
    self.filename = filename
    self.url = Bundle.main.url(forResource: filename, withExtension: "csv")!
  }
  
  //heavy work here
  func readCoreData() async throws {
    
    for try await line in url.lines {
      
      let moc = CoreDataStack.shared.context
      
      let row = line.components(separatedBy: "\n")[0]
      let values = row.components(separatedBy: ",")
      
      //todo : fix cols > 8
      if values.count == 8
      {
        let invoice = Invoice(context: moc)
        invoice.invoiceNo = values[0]
        invoice.retailNo = values[1]
        invoice.desc = values[2]
        invoice.quantity = values[3]
        invoice.date = values[4]
        invoice.price = values[5]
        invoice.customerNo = values[6]
        invoice.country = values[7]
        
        await MainActor.run {
          do {
            try moc.save()
            self.progress.send()
          }
          catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
          }
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
