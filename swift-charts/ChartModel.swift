import Foundation

class ChartModel: ObservableObject {
  var retails = [Retail]()
   
  init(retails: [Retail] = loadCSV(from: "online-retail")) {
    self.retails = retails
  }
}

struct Retail: Identifiable {
  var id = UUID()
  
  var InvoiceNo: String = ""
  var StockCode: String = ""
  var Description: String = ""
  var Quantity: String = ""
  var InvoiceDate: String = ""
  var UnitPrice: String = ""
  var CustomerID: String = ""
  var Country: String = ""
  
  init(raw: [String]) {
    InvoiceNo = raw[0]
    StockCode = raw[1]
    Description = raw[2]
    Quantity = raw[3]
    InvoiceDate = raw[4]
    UnitPrice = raw[5]
    CustomerID = raw[6]
    Country = raw[7]
  }
}


func loadCSV(from csvName: String) -> [Retail] {
  var csvToStruct = [Retail]()
  
  guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else { return [] }

  var data = ""
  do {
    data = try String(contentsOfFile: filePath)
  }
  catch {
    print(error)
    return []
  }
  
  var rows = data.components(separatedBy: "\n")
  
  let columnCount = rows.first?.components(separatedBy: ",").count
  rows.removeFirst()
  
  for row in rows {
    let csvColumns = row.components(separatedBy: ",")
    if csvColumns.count == columnCount {
      let retailStruct = Retail.init(raw: csvColumns)
      csvToStruct.append(retailStruct)
    }
  }
   
  return csvToStruct
}
