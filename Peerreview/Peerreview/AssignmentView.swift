import SwiftUI
import UniformTypeIdentifiers

struct AssignmentView: View {

    @State private var showPicker = false
    @State private var showSuccess = false

    var body: some View {

        VStack(spacing: 20) {

            Button("Upload Assignment") {
                showPicker = true
            }

            Button("Submit") {
                showSuccess = true
            }
        }
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.data]
        ) { _ in }

        .alert("Assignment Submitted", isPresented: $showSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
}
