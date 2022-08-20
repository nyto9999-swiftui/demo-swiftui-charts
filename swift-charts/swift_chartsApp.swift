import SwiftUI

@main
struct swift_chartsApp: App {
  @StateObject var model = ChartModel()
  
    var body: some Scene {
        WindowGroup {
          ContentView()
            .environmentObject(model)
        }
    }
}
