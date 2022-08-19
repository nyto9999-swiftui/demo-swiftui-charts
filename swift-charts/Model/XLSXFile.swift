import Foundation
import ZIPFoundation
import XMLCoder

public enum XLSXReaderError: Error {
  case archiveEntryNotFound
}

public struct XLSXFile {
  public let filepath: String
  private let archive: Archive
  private let decoder: XMLDecoder
  
  public init?(filePath: URL) {
    let archiveURL = filePath
    
    guard let archive = Archive(url: archiveURL, accessMode: .read) else {
      return nil }
    
    self.archive = archive
    self.filepath = filePath.absoluteString
    decoder = XMLDecoder()
  }
  
  func parseEntry<T: Decodable>(_ path: String,
                                _ type: T.Type) throws -> T {
    guard let entry = archive[path] else { throw XLSXReaderError.archiveEntryNotFound }
    
    var result: T?
    
    _ = try archive.extract(entry) {
      result = try decoder.decode(type, from: $0)
    }
    return result!
  }
  
  func parseDocumentPaths() throws -> [String] {
    decoder.keyDecodingStrategy = .convertFromCapitalized

    return try parseEntry("_rels/.rels", Relationships.self).items
      .filter { $0.type == .officeDocument }
      .map { $0.target }
  }
}




