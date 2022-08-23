import Foundation
import CoreData

class CoreDataStack {
  
  static let shared = CoreDataStack()
  private var persistenContainer: NSPersistentContainer
  
  init() {
    persistenContainer = NSPersistentContainer(name: "Model")
    persistenContainer.loadPersistentStores { desc, error in
      if let error = error { fatalError("Core Data failed to init \(error)")}
      
    }
    print(persistenContainer.persistentStoreDescriptions.first?.url! ?? "")
  }
  
  var viewContext: NSManagedObjectContext {
    persistenContainer.viewContext
  }
  
  func invoicesCount() -> Int {
    let fetchInvoices: NSFetchRequest<Invoice> = Invoice.fetchRequest()
    do {
      return try viewContext.count(for: fetchInvoices)
    }
    catch {
      return 0
    }
  }
  func csvToDisk(values: [String] ) {
    let country = self.addCountry(name: values[7])
    let retail  = self.addRetail(retailNo: values[1], quantity: values[3], desc: values[2], price: values[5])
    saveContext()
      
    let _ = addInvoice(invoiceNo: values[1], date: values[4], customerNo: values[6], country: country, retail: retail)
     
    saveContext()
  }
  
  func addRetail(retailNo: String, quantity: String, desc: String, price: String) -> Retail? {
    
    let retailFetch: NSFetchRequest<Retail> = Retail.fetchRequest()
    retailFetch.predicate = NSPredicate(format: "retailNo == %@", retailNo)
    
    do {
      let results = try viewContext.fetch(retailFetch)
      if results.isEmpty {
        //create new
        let retail = Retail(context: viewContext)
        retail.retailNo = retailNo
        retail.quantity = quantity
        retail.desc = desc
        retail.price = price
        return retail
      }
      else {
        return results.first!
      }
    } catch  {
      return nil
    }
  }
  
  func addCountry(name: String) -> Country? {
    let countryFetch: NSFetchRequest<Country> = Country.fetchRequest()
    countryFetch.predicate = NSPredicate(format: "name == %@", name)

    do {
      let results = try viewContext.fetch(countryFetch)
      if results.isEmpty {
        //create new
        let country = Country(context: viewContext)
        country.name = name
        return country
      }
      else {
        return results.first!
      }
    } catch  {
      return nil
    }
  }
  
  func addInvoice(invoiceNo: String, date: String, customerNo: String, country: Country?, retail: Retail?) -> Invoice {
    let invoice = Invoice(context: viewContext)
    invoice.invoiceNo = invoiceNo
    invoice.date = date
    invoice.customerNo = customerNo
    invoice.invoiceToCountry = country
    invoice.invoicToRetail = retail
    return invoice
  }
  
    func saveContext() {
      guard viewContext.hasChanges else { return }
      do {
        try viewContext.save()
      } catch let error as NSError {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
