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
   
  //MARK: General
  func saveContext() {
    guard viewContext.hasChanges else { return }
    do {
      try viewContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
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
  
  
}
