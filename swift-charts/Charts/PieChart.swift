import SwiftUI

struct PieChart: View {
  @Environment(\.managedObjectContext) var moc
  @StateObject private var model = PieChartModel()
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
//  @SectionedFetchRequest<String, Invoice>(
//    sectionIdentifier: \.country!,
//    sortDescriptors: []
//  )
//  private var countryList: SectionedFetchResults<String, Invoice>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(countries) { country in
          Section {
            Text("\(countries.count)")
          } header: {
            Text(country.name ?? "")
          }

        }
      }
    }.task {
      
    }
    
  }
}



