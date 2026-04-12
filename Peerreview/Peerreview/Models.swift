import Foundation


enum UserRole: String, CaseIterable, Identifiable {
    case student = "Student"
    case professor = "Professor"
    case admin = "Admin"
    
    var id: String { self.rawValue }
}

struct Course: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let code: String
}
