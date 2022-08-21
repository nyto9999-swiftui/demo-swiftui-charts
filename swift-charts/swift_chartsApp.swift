import SwiftUI
import CoreData

@main
struct swift_chartsApp: App {
  let context = CoreDataStack(modelName: "model").managedContext
  
    var body: some Scene {
        WindowGroup {
          ContentView()
            .environment(\.managedObjectContext, context)
        }
    }
}
