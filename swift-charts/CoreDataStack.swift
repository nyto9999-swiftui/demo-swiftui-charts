import Foundation
import CoreData

public class CoreDataStack {
  
  static let shared = CoreDataStack(model: "Model")
  
  private let modelName:String
  var fetchRequest: NSFetchRequest<Invoice>?
  var invoiceList: [Invoice] = []
  
  lazy var context: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  init(model: String) {
    self.modelName = model
  }
   
  private var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    print(container.persistentStoreDescriptions.first?.url! ?? "")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext() {
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
  
}
