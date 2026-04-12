import SwiftUI
import UniformTypeIdentifiers

struct UploadAssignmentView: View {
    
    @State private var selectedFileName = "No file selected"
    @State private var showPicker = false
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Upload Assignment")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Text(selectedFileName)
                    .foregroundColor(.black)
                    .font(.headline)
                
                Button {
                    showPicker = true
                } label: {
                    Text("Select File")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [.orange, .red],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(12)
                }
                
                Button {
                    if selectedFileName != "No file selected" {
                        showAlert = true
                    }
                } label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [.green, .blue],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.pdf]
        ) { result in
            switch result {
            case .success(let url):
                selectedFileName = url.lastPathComponent
            case .failure:
                selectedFileName = "Failed to load file"
            }
        }
        
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("Assignment uploaded successfully")
        }
    }
}
