import SwiftUI

struct ReviewView: View {

    @State private var showSuccess = false

    var body: some View {

        VStack(spacing: 20) {

            Button("Create Review") {}

            Button("Submit Review") {
                showSuccess = true
            }
        }
        .alert("Review Submitted", isPresented: $showSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
}

