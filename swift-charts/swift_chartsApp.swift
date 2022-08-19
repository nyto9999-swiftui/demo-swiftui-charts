import SwiftUI
import XMLCoder


@main
struct swift_chartsApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView().onAppear {
            if let path = Bundle.main.url(forResource: "online-retail", withExtension: "xlsx") {
              
              
              guard let file = XLSXFile(filePath: path) else {
                print("no path")
                return }
              
              do {
                let path = try file.parseDocumentPaths()
                print(path)
              }
              catch {
                print(error)
              }
              
            }
          }
        }
    }
}
