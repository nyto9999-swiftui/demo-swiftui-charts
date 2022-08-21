import Foundation
import Combine
import CoreData
import SwiftUI

class RetailModel: ObservableObject {
  @Environment(\.managedObjectContext) var moc
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
      
      
      //todo : fix cols > 8
      guard values.count == 8 else { return }
      
      let invoice = Invoice(context: moc)
      let customer = Customer(context: moc)
      let retail = Retail(context: moc)
      //InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
      
      invoice.id = UUID()
      invoice.invoiceNo = values[0]
      invoice.date = values[4]
      
      customer.id = UUID()
      customer.customerNo = values[6]
      customer.country = values[7]
      
      retail.id = UUID()
      retail.retailNo = values[1]
      retail.desc = values[2]
      retail.quantity = values[3]
      retail.price = values[5]
      
      do {
        try moc.save()
      }
      catch let error as NSError {
        print("context error")
        print("Unresolved error \(error), \(error.userInfo)")
        return
      }
      
      typealias mSet = NSMutableOrderedSet
      //relationship
      if let invoiceToCustomer = invoice.invoiceToCustomer?.mutableCopy() as? mSet,
         let retails = invoice.retails as? mSet,
         let customerToRetails = customer.customerToRetail?.mutableCopy() as? mSet
      {
        invoiceToCustomer.add(customer)
        invoice.addToRetails(retail)
        
        
        
        
      }
      
      
      
      
      //
      //      let invoice = Invoice(context: moc)
      //      invoice.country = values[7]
      //      invoice.customerID = values[6]
      //      invoice.invoiceDate = values[4]
      //      invoice.invoiceNo = values[0]
      //
      //      let retail = Retail(context: moc)
      //      retail.stockCode = values[1]
      //      retail.desc = values[2]
      //      retail.quantity = values[3]
      //      retail.unitPrice = values[5]
      //
      //      await MainActor.run {
      //        try? moc.save()
      //        if let retails = invoice.retails?.mutableCopy() as? NSMutableOrderedSet {
      //          retails.add(invoice)
      //        }
      //        try? moc.save()
      //      }
      
      
      
      await MainActor.run {
        //        do {
        ////          print(invoice)
        ////          print(retail)
        ////          try moc.save()
        //        }
        //        catch let error as NSError {
        //        print("Unresolved error \(error), \(error.userInfo)")
        //        }
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
//["537153", "22865", "HAND WARMER OWL DESIGN", "8", "12/5/10 13:03", "2.1", "16718", "United Kingdom"]
