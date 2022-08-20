import SwiftUI
import CoreXLSX

struct ContentView: View {
  
  @ObservedObject var model: Model = Model()
   
  var body: some View {
    Text("\(model.text)")
      .padding()
    Text("\(model.text)").onAppear {
      
      model.parseSheet()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
