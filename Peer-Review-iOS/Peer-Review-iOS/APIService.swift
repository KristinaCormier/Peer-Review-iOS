////
//  APIService.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//

import Foundation

// MARK: - Empty Response
struct EmptyResponse: Codable {}

class APIService {
    static let shared = APIService()
    
    // 🔴 CHANGE THIS TO YOUR MAC LAN IP (IPv4) FOR DEVICE TESTING
    private let baseURL: String
    
    init() {
        #if targetEnvironment(simulator)
        // Simulator can often reach localhost
        self.baseURL = "http://127.0.0.1:5000"
        #else
        // Physical device must use your Mac's LAN IPv4 address
        self.baseURL = "http://localhost:5000" // <-- Replace with your actual LAN IP
        #endif
    }
    
    private var token: String? {
        UserDefaults.standard.string(forKey: "authToken")
    }
    
    // MARK: - Generic Request
    private func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - API Calls
extension APIService {
    
    func login(email: String, password: String) async throws -> LoginResponse {
        struct Body: Codable {
            let email: String
            let password: String
        }
        
        let body = try JSONEncoder().encode(Body(email: email, password: password))
        
        let response: LoginResponse = try await request(
            endpoint: "/login",
            method: "POST",
            body: body
        )
        
        UserDefaults.standard.set(response.token, forKey: "authToken")
        return response
    }
    
    func listClasses() async throws -> [Course] {
        try await request(endpoint: "/classes")
    }
    
    func listAssignments(classId: Int) async throws -> [Assignment] {
        try await request(endpoint: "/classes/\(classId)/assignments")
    }
    
    func getUserId() async throws -> Int {
        struct Response: Codable { let id: Int }
        let res: Response = try await request(endpoint: "/me")
        return res.id
    }
    
    func createReview(assignmentId: Int, reviewerId: Int, revieweeId: Int) async throws -> Review {
        struct Body: Codable {
            let assignmentId: Int
            let reviewerId: Int
            let revieweeId: Int
        }
        let body = try JSONEncoder().encode(
            Body(assignmentId: assignmentId, reviewerId: reviewerId, revieweeId: revieweeId)
        )
        return try await request(endpoint: "/reviews", method: "POST", body: body)
    }
    
    func createCriterion(reviewId: Int, row: Int, column: Int, comment: String) async throws {
        struct Body: Codable {
            let reviewId: Int
            let row: Int
            let column: Int
            let comment: String
        }
        let body = try JSONEncoder().encode(
            Body(reviewId: reviewId, row: row, column: column, comment: comment)
        )
        let _: EmptyResponse = try await request(endpoint: "/criteria", method: "POST", body: body)
    }
}
