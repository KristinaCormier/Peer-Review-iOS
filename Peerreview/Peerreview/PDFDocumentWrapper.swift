import SwiftUI
import UniformTypeIdentifiers

struct PDFDocumentWrapper: FileDocument {
    
    static var readableContentTypes: [UTType] { [.pdf] }
    
    var data: Data
    
    init(url: URL?) {
        self.data = (try? Data(contentsOf: url ?? URL(fileURLWithPath: ""))) ?? Data()
    }
    
    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return .init(regularFileWithContents: data)
    }
}
