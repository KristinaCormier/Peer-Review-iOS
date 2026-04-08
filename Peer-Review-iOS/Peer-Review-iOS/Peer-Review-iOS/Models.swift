//
//  Assignment.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//


import Foundation

struct Assignment: Codable, Identifiable {
    let id: Int
    let name: String
}

struct Course: Codable, Identifiable {
    let id: Int
    let name: String
}

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String?
}

struct StudentGroup: Codable {
    let userID: Int
    let groupID: Int
    let assignmentID: Int
}

struct Review: Codable {
    let id: Int
    let grades: [Int]
}

struct LoginResponse: Codable {
    let token: String
    let must_change_password: Bool
}
