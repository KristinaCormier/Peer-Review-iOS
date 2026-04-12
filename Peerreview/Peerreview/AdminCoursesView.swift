import SwiftUI

struct AdminCoursesView: View {
    
    @State private var courses: [CourseItem] = []
    
    @State private var courseName = ""
    @State private var participants = ""
    @State private var professor = ""
    @State private var studentID = ""
    
    @State private var removeCourseName = ""
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Manage Courses")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    
                    VStack(spacing: 15) {
                        
                        field("Course Name", $courseName)
                        field("Total Participants", $participants)
                        field("Assign Professor", $professor)
                        field("Add Student ID", $studentID)
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                            DatePicker("Start", selection: $startDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.purple)
                            DatePicker("End", selection: $endDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        Button {
                            addCourse()
                        } label: {
                            Text("Add Course")
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
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.white, .purple.opacity(0.2)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                  
                    VStack(spacing: 15) {
                        
                        TextField("Enter Course Name to Remove", text: $removeCourseName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .foregroundColor(.black)
                        
                        Button {
                            removeCourse()
                        } label: {
                            Text("Remove Course")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.white, .red.opacity(0.2)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    
                    ForEach(courses) { course in
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Course: \(course.name)")
                                .font(.headline)
                            
                            Text("Participants: \(course.participants)")
                            Text("Professor: \(course.professor)")
                            Text("Student ID: \(course.studentID)")
                            
                            Text("Start: \(formatDate(course.startDate))")
                            Text("End: \(formatDate(course.endDate))")
                            
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
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
        
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }
    
   
    func field(_ title: String, _ binding: Binding<String>) -> some View {
        TextField(title, text: binding)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .foregroundColor(.black)
    }
    
   
    func addCourse() {
        
        guard !courseName.isEmpty else {
            alertMessage = "Enter course name"
            showAlert = true
            return
        }
        
        let newCourse = CourseItem(
            name: courseName,
            participants: participants,
            professor: professor,
            studentID: studentID,
            startDate: startDate,
            endDate: endDate
        )
        
        courses.append(newCourse)
        
        alertMessage = "Course added successfully"
        showAlert = true
        
        courseName = ""
        participants = ""
        professor = ""
        studentID = ""
    }
    
   
    func removeCourse() {
        
        courses.removeAll { $0.name.lowercased() == removeCourseName.lowercased() }
        
        alertMessage = "Course removed successfully"
        showAlert = true
        
        removeCourseName = ""
    }
    
   
    func formatDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}



struct CourseItem: Identifiable {
    let id = UUID()
    let name: String
    let participants: String
    let professor: String
    let studentID: String
    let startDate: Date
    let endDate: Date
}
