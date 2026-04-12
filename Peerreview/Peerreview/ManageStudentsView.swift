import SwiftUI

struct ManageStudentsView: View {
    
    @State private var students: [Student] = [
        Student(name: "Sourav", studentID: "1001", email: "sourav@test.com", phone: "1234567890")
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
                
                Text("Manage Students")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        ForEach(students) { student in
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Name: \(student.name)")
                                    .font(.headline)
                                
                                Text("ID: \(student.studentID)")
                                Text("Email: \(student.email)")
                                Text("Phone: \(student.phone)")
                                
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.white, .blue.opacity(0.2)],
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
                        Text("Add Student")
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
                        Text("Remove Student")
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
            AddStudentSheet { newStudent in
                students.append(newStudent)
                alertMessage = "Student added successfully"
                showAlert = true
            }
        }
        
     
        .sheet(isPresented: $showRemoveSheet) {
            RemoveStudentSheet { id in
                students.removeAll { $0.studentID == id }
                alertMessage = "Student removed successfully"
                showAlert = true
            }
        }
        
      
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK") {}
        }
    }
}



struct AddStudentSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var id = ""
    @State private var email = ""
    @State private var phone = ""
    
    var onSave: (Student) -> Void
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Add Student")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                field("Name", $name)
                field("Student ID", $id)
                field("Email", $email)
                field("Phone", $phone)
                
                Button {
                    let student = Student(name: name, studentID: id, email: email, phone: phone)
                    onSave(student)
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



struct RemoveStudentSheet: View {
    
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
                
                Text("Remove Student")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                TextField("Enter Student ID", text: $id)
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


// 🔥 MODEL
struct Student: Identifiable {
    let id = UUID()
    let name: String
    let studentID: String
    let email: String
    let phone: String
}
