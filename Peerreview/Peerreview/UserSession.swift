import Foundation
import SwiftUI
import Combine

class UserSession: ObservableObject {
    @Published var userName: String = "Student"
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var pronouns: String = ""
    @Published var profileImage: UIImage? = nil
}
