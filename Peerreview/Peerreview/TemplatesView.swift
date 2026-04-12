import SwiftUI
import QuickLook
import UniformTypeIdentifiers

struct TemplatesView: View {
    
    var role: UserRole   
    
    @State private var templates: [TemplateFile] = [
        TemplateFile(name: "Brainstorm Template", fileName: "Brainstorming"),
        TemplateFile(name: "Assignment Template", fileName: "assignment")
    ]
    
    @State private var showPreview = false
    @State private var selectedURL: URL?
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var showFilePicker = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Templates")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        ForEach(templates) { template in
                            
                            HStack {
                                
                                Button {
                                    openFile(fileName: template.fileName, displayName: template.name)
                                } label: {
                                    HStack {
                                        Image(systemName: "doc.text.fill")
                                        Text(template.name)
                                            .font(.headline)
                                    }
                                    .foregroundColor(.black)
                                }
                                
                                Spacer()
                                
                                
                                if role != .student {
                                    Button {
                                        removeTemplate(template)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }
                
               
                if role != .student {
                    Button {
                        showFilePicker = true
                    } label: {
                        Text("Upload New Template")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [.blue, .purple],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
        }
        
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK") {
                if selectedURL != nil {
                    showPreview = true
                }
            }
        }
        
        .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: [.pdf],
            allowsMultipleSelection: false
        ) { result in
            handleFileImport(result)
        }
        
        .sheet(isPresented: $showPreview) {
            if let url = selectedURL {
                QuickLookPreview(url: url)
            }
        }
    }
    
    func openFile(fileName: String, displayName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
            selectedURL = url
            alertMessage = "\(displayName) downloaded successfully"
        } else {
            alertMessage = "File not found"
        }
        showAlert = true
    }
    
    func removeTemplate(_ template: TemplateFile) {
        templates.removeAll { $0.id == template.id }
        alertMessage = "Template removed successfully"
        showAlert = true
    }
    
    func handleFileImport(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            if let url = urls.first {
                let newTemplate = TemplateFile(
                    name: url.lastPathComponent,
                    fileName: url.deletingPathExtension().lastPathComponent
                )
                templates.append(newTemplate)
                alertMessage = "Template uploaded successfully"
                showAlert = true
            }
        case .failure:
            alertMessage = "Failed to upload template"
            showAlert = true
        }
    }
}

struct TemplateFile: Identifiable {
    let id = UUID()
    let name: String
    let fileName: String
}
