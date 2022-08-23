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
          
          let invoice = Invoice(context: moc)
          invoice.invoiceNo = values[0]
          invoice.date = values[4]
          invoice.customerNo = values[6]
          
          let countryFetch: NSFetchRequest<Country> = Country.fetchRequest()
          countryFetch.predicate = NSPredicate(format: "name == %@", values[7])
          var country = Country(context: moc)
          do {
            let results = try moc.fetch(countryFetch)
            if !results.isEmpty { country = results.first! }
            //create new
          } catch { country.name = values[7] }
          
          let retailFetch: NSFetchRequest<Retail> = Retail.fetchRequest()
          retailFetch.predicate = NSPredicate(format: "retailNo == %@", values[1])
          var retail = Retail(context: moc)
          do {
            let results = try moc.fetch(retailFetch)
            if !results.isEmpty { retail = results.first! }
          } catch  {
            //create new
            retail.retailNo = values[1]
            retail.desc = values[2]
            retail.quantity = Double(values[3]) ?? 0
            retail.price = Double(values[5]) ?? 0
            retail.retailToCountry = country
          }
           
          do {
            try moc.save()
            self.progress.send()
          } catch {
            print(error)
          }
        }
      }
    }
  }
}

//InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
//["537153", "22865", "HAND WARMER OWL DESIGN", "8", "12/5/10 13:03", "2.1", "16718", "United Kingdom"]
