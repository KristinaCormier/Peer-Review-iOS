import SwiftUI

struct ManageProfessorsView: View {
    
    @State private var professors: [Professor] = [
        Professor(name: "Dr. Smith", profID: "P100", email: "smith@test.com", phone: "1112223333")
    ]
    
    @State private var showAddSheet = false
    @State private var showRemoveSheet = false
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Manage Professors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        ForEach(professors) { prof in
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Name: \(prof.name)")
                                    .font(.headline)
                                
                                Text("ID: \(prof.profID)")
                                Text("Email: \(prof.email)")
                                Text("Phone: \(prof.phone)")
                                
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.white, .purple.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(15)
                            .shadow(radius: 6)
                        }
                    }
                    .padding()
                }
                
                VStack(spacing: 12) {
                    
                    Button {
                        showAddSheet = true
                    } label: {
                        Text("Add Professor")
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
                    
                    Button {
                        showRemoveSheet = true
                    } label: {
                        Text("Remove Professor")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        
        .sheet(isPresented: $showAddSheet) {
            AddProfessorSheet { newProf in
                professors.append(newProf)
                alertMessage = "Professor added successfully"
                showAlert = true
            }
        }
        
        .sheet(isPresented: $showRemoveSheet) {
            RemoveProfessorSheet { id in
                professors.removeAll { $0.profID == id }
                alertMessage = "Professor removed successfully"
                showAlert = true
            }
        }
        
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK") {}
        }
    }
}



struct AddProfessorSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var id = ""
    @State private var email = ""
    @State private var phone = ""
    
    var onSave: (Professor) -> Void
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Add Professor")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                field("Name", $name)
                field("Professor ID", $id)
                field("Email", $email)
                field("Phone", $phone)
                
                Button {
                    let prof = Professor(name: name, profID: id, email: email, phone: phone)
                    onSave(prof)
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func field(_ placeholder: String, _ text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .foregroundColor(.black)
    }
}



struct RemoveProfessorSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var id = ""
    
    var onRemove: (String) -> Void
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Remove Professor")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                TextField("Enter Professor ID", text: $id)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                
                Button {
                    onRemove(id)
                    dismiss()
                } label: {
                    Text("Remove")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}



struct Professor: Identifiable {
    let id = UUID()
    let name: String
    let profID: String
    let email: String
    let phone: String
}
