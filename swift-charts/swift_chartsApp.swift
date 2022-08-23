import SwiftUI

@main
struct swift_chartsApp: App {
  let coreData = CoreDataStack.shared
    var body: some Scene {
        WindowGroup {
          ContentView()
            .environment(\.managedObjectContext, coreData.context)
          //test
        }
    }
}
