import Foundation
import CoreData

public class CoreDataStack {
  
  static let shared = CoreDataStack(model: "ModelV2")
  
  private let modelName:String
  
  lazy var context: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  init(model: String) {
    self.modelName = model
  }
   
  private lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName)
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
