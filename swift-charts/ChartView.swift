import SwiftUI
import Charts

struct ChartView: View {
  @EnvironmentObject var model: ChartModel
  
  var body: some View {
    Chart(model.retails) { retail in
      BarMark(
        x: .value("Country", retail.Country),
        y: .value("Price", Int(retail.UnitPrice) ?? 0)
      ).foregroundStyle(Color.blue.gradient)
    }
    .frame(height: 200)
    .padding()
  }
}


