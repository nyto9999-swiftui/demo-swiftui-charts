import SwiftUI
import SwiftPieChart

struct PieChart: View {
  @FetchRequest(entity: Country.entity(), sortDescriptors: []) var fetchCountries: FetchedResults<Country>
  @FetchRequest(entity: Retail.entity(), sortDescriptors: []) var fetchRetails: FetchedResults<Retail>
  @State var data:([String], [Double]) = ([], [])
  @State var displayPieChart = false
  
  var body: some View {
    VStack(alignment: .leading) {
      if displayPieChart {
        PieChartView(values: data.1, names: data.0, formatter: {value in String(format: "$%.2f", value)})
          .padding(7.0)
      }
      
    }.onAppear {
      data.0 = fetchCountries.map { $0.name ?? "未知" }
      data.1 = fetchCountries.map { $0.retails.reduce(0) { sum, retail -> Double in
        return sum + retail.price * retail.quantity
      }}
      let rs = fetchRetails.map { $0.desc ?? "" }
      print(rs)
      displayPieChart = true
    }
  }
  
  
  //      }.onAppear {
  //
  //        var prices:[Double] = []
  //
  ////        let price = retails.map { $0.price * $0.quantity }
  ////        print(price)
  //
  //
  //      }
  
}

//ForEach(countries) { country in
//  Section {
//    Text("\(country.invoice.count)")
//  } header: {
//    Text(country.name ?? "")
//  }
//}

