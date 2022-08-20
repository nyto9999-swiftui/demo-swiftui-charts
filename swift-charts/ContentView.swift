import SwiftUI

struct ContentView: View {
  @ObservedObject var model = ChartModel(csvName: "online-retail")
  
  var body: some View {
    Text(model.retails[2].Description)
      
    }
  }

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
