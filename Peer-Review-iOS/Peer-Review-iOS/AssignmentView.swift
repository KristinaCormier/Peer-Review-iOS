//
//  SelectedCriterion.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//


import SwiftUI

struct SelectedCriterion: Identifiable {
    let id = UUID()
    let row: Int
    let column: Int
}

struct AssignmentView: View {
    
    let assignmentId: Int
    
    @State private var revieweeID: Int = 0
    @State private var selectedCriteria: [SelectedCriterion] = []
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Assignment \(assignmentId)")
                .font(.title)
            
            Button("Select Criterion (Demo)") {
                handleCriterionSelect(row: 1, column: 2)
            }
            
            Button("Submit Review") {
                Task {
                    await submitReview()
                }
            }
        }
        .padding()
    }
    
    func handleCriterionSelect(row: Int, column: Int) {
        if let index = selectedCriteria.firstIndex(where: {
            $0.row == row && $0.column == column
        }) {
            selectedCriteria.remove(at: index)
        } else {
            selectedCriteria.removeAll { $0.row == row }
            selectedCriteria.append(SelectedCriterion(row: row, column: column))
        }
    }
    
    func submitReview() async {
        do {
            let userId = try await APIService.shared.getUserId()
            
            let review = try await APIService.shared.createReview(
                assignmentId: assignmentId,
                reviewerId: userId,
                revieweeId: revieweeID
            )
            
            for c in selectedCriteria {
                try await APIService.shared.createCriterion(
                    reviewId: review.id,
                    row: c.row,
                    column: c.column,
                    comment: ""
                )
            }
            
            print("Review submitted!")
            
        } catch {
            print("Error:", error)
        }
    }
}


