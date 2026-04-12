import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var session: UserSession
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var pronouns = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple, .blue],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else if let image = session.profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Change Profile Picture")
                            .foregroundColor(.white)
                    }
                    
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    TextField("Phone", text: $phone)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    TextField("Pronouns", text: $pronouns)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    Button {
                        session.userName = name
                        session.email = email
                        session.phone = phone
                        session.pronouns = pronouns
                        
                        if let image = profileImage {
                            session.profileImage = image
                        }
                        
                        showAlert = true
                    } label: {
                        Text("Save Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [.blue, .purple],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profileImage = uiImage
                    }
                }
            }
        }
        .alert("Profile updated successfully", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}
