

public enum SchemaType: String, Codable {
//  case worksheet =
//  """
//  http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
//  worksheet
//  """
//  case officeDocument =
//  """
//  http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties
//  """
  case calcChain =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    calcChain
    """
  case officeDocument =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    officeDocument
    """
  case extendedProperties =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    extended-properties
    """
  case packageCoreProperties =
    """
    http://schemas.openxmlformats.org/package/2006/relationships/metadata/\
    core-properties
    """
  case coreProperties =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    metadata/core-properties
    """
  case connections =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    connections
    """
  case worksheet =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    worksheet
    """
  case chartsheet =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    chartsheet
    """
  case sharedStrings =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    sharedStrings
    """
  case styles =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    styles
    """
  case theme =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    theme
    """
  case pivotCache =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    pivotCacheDefinition
    """
  case metadataThumbnail =
    """
    http://schemas.openxmlformats.org/package/2006/relationships/metadata/\
    thumbnail
    """
  case customProperties =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    custom-properties
    """
  case externalLink =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    externalLink
    """
  case customXml =
    """
    http://schemas.openxmlformats.org/officeDocument/2006/relationships/\
    customXml
    """
  case person =
    """
    http://schemas.microsoft.com/office/2017/10/relationships/\
    person
    """
  case webExtensionTaskPanes =
    """
    http://schemas.microsoft.com/office/2011/relationships/\
    webextensiontaskpanes
    """
  case googleWorkbookMetadata =
    """
    http://customschemas.google.com/relationships/workbookmetadata
    """
  case purlOCLC =
    """
    http://purl.oclc.org/ooxml/officeDocument/relationships/extendedProperties
    """
}

struct Relationships: Codable {
  let items: [Relationship]
  
  enum CodingKeys: String, CodingKey {
    case items = "relationship"
  }
}

struct Relationship: Codable {
  let id: String
  let type: SchemaType
  let target: String
}

//public struct Worksheet: Codable {
//  public let sheetPr: SheetPr?
//  public let dimension: WorksheetDimension
//  public let sheetViews: SheetViews
//  public let sheetFormatPr: SheetFormatPr
//  public let cols: Cols
//  public let sheetData: SheetData
//  public let mergeCells: MergeCells?
//}
//
//public struct Cell: Codable, Equatable {
//  public let reference: String
//  public let type: String?
//  public let s: String?
//  public let inlineString: InlineString?
//  public let formula: String?
//  public let value: String?
//
//  enum CodingKeys: String, CodingKey {
//    case formula = "f"
//    case value = "v"
//    case inlineString = "is"
//    case reference = "r"
//    case type = "t"
//    case s
//  }
//}
