import Foundation
import Combine
import CoreData
import SwiftUI

class RetailModel: ObservableObject {
  let moc = CoreDataStack.shared.context
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
      
      let row = line.components(separatedBy: "\n")[0]
      let values = row.components(separatedBy: ",")
        
      let invoice = Invoice(context: moc)
      invoice.country = values[7]
      invoice.customerID = Int16(values[6]) ?? 0
      invoice.invoiceDate = convertDate(from: values[4] ?? "")
      invoice.invoiceNo = Int32(values[0]) ?? 0
      
      let retail = Retail(context: moc)
      retail.stockCode = values[1]
      retail.desc = values[2]
      retail.quantity = Int16(values[3]) ?? 0
      retail.unitPrice = Float(values[5]) ?? 0
       
      if let retails = invoice.retails?.mutableCopy() as? NSMutableOrderedSet {
        retails.add(invoice)
        
      }
      do {
        try moc.save()
        print("work")
      }
      catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
      }
      await MainActor.run {
        self.progress.send()
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
