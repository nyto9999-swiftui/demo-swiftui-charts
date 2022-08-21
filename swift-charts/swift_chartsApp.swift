import SwiftUI

@main
struct swift_chartsApp: App {
  let coreData = CoreDataStack.shared
    var body: some Scene {
        WindowGroup {
          let invoice = Invoice(context: coreData.context)
          ContentView()
            .environment(\.managedObjectContext, coreData.context)
        }
    }
}
