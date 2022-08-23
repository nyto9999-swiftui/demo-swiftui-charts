import SwiftUI

@main
struct swift_chartsApp: App {
  
    var body: some Scene {
        WindowGroup {
//          let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
          let coreData = CoreDataStack.shared
          ChartView()
            .environment(\.managedObjectContext, coreData.viewContext)
        }
    }
}
