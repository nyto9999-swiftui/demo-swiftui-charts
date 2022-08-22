import SwiftUI
import Charts
import Combine

struct ChartView: View {
  @StateObject private var model = RetailModel(filename: "online-retail")
  @State private var downloadAmount = 0.0
 
  var body: some View {
    VStack(alignment: .center) {
       
      Text("Downloading… \(lround(downloadAmount))/541910")
      
      ProgressView(value: downloadAmount, total: 541910)
        .onReceive(model.progress) { _ in
          DispatchQueue.main.async {
            if downloadAmount < 541910.0 {
              downloadAmount += 1
            }
          }
        }
        .accentColor(Color.orange)
        .scaleEffect(x: 1, y: 4, anchor: .center)
        .padding(15)
    }
    .task {
      do {
          try await model.readCoreData()
      }
      catch {
        print(error.localizedDescription)
      }
    }
  }
}



