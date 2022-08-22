import SwiftUI
import CoreData
import Combine

struct ChartView: View {
  @StateObject private var model = RetailModel(filename: "online-retail")
  @State private var downloadAmount = 0.0
  @Environment(\.managedObjectContext) var moc
//  @FetchRequest(entity: Invoice.entity(), sortDescriptors: []) var invoices: FetchedResults<Invoice>
  private var invoiceCount = CoreDataStack.shared.invoicesCount()
  @State private var displayChart = true
   
  var body: some View {
    VStack(alignment: .center) {
      if displayChart {
        Text("I am chart")
      }
      else {
        Text("Downloading… \(lround(downloadAmount))/541910")
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
      
    }.task {
      if invoiceCount == 0 {
        displayChart = false
        await model.ayncStreamPull()
        displayChart = true
      }
    }
  }
  
}


 
