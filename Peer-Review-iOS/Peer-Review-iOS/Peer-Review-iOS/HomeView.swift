//
//  HomeView.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//


import SwiftUI

struct HomeView: View {
    
    @State private var courses: [Course] = []
    
    var body: some View {
        List(courses) { course in
            NavigationLink(destination: ClassHomeView(classId: course.id)) {
                Text(course.name)
            }
        }
        .navigationTitle("Classes")
        .task {
            await load()
        }
    }
    
    func load() async {
        do {
            courses = try await APIService.shared.listClasses()
        } catch {
            print("Error:", error)
        }
    }
}


#Preview {
    HomeView()
}
