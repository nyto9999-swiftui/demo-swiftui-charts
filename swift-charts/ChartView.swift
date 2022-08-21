import SwiftUI
import Charts
import Combine

struct ChartView: View {
  @StateObject private var model = RetailModel(filename: "online-retail")
  @State private var downloadAmount = 0.0
  
  var body: some View {
    
    VStack(alignment: .center) {
      
      Text("Downloading…")
      
      ProgressView(value: downloadAmount, total: 541910)
        .onReceive(model.progress) { _ in
          if downloadAmount < 541910.0 {
            downloadAmount += 1
          }
        }
        .accentColor(Color.orange)
        .scaleEffect(x: 1, y: 4, anchor: .center)
        .padding(15)
      
    }
    
    //    .onAppear {
    //      do {
    //        try model.readSync()
    //      } catch let error {
    //        print(error.localizedDescription)
    //      }
    
      .task {
        do {
          try await model.getRetails()
        } catch let error {
          print(error.localizedDescription)
        }
      }
    
  }
}



