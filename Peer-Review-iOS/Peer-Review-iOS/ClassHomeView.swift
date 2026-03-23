//
//  ClassHomeView.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//


import SwiftUI

struct ClassHomeView: View {
    
    let classId: Int
    @State private var assignments: [Assignment] = []
    
    var body: some View {
        List(assignments) { assignment in
            NavigationLink(destination: AssignmentView(assignmentId: assignment.id)) {
                Text(assignment.name)
            }
        }
        .navigationTitle("Assignments")
        .task {
            await load()
        }
    }
    
    func load() async {
        do {
            assignments = try await APIService.shared.listAssignments(classId: classId)
        } catch {
            print(error)
        }
    }
}


