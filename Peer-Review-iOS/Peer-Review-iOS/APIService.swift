import Foundation



struct EmptyResponse: Codable {}

class APIService {
    static let shared = APIService()
    
    private let baseURL: String
    
    init() {
        self.baseURL = "http://127.0.0.1:5001"
    }
    
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
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        print("STATUS:", httpResponse.statusCode)
        if let bodyString = String(data: data, encoding: .utf8) {
            print("RESPONSE BODY:", bodyString)
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NSError(
                domain: "APIError",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey: "Server returned status \(httpResponse.statusCode)"
                ]
            )
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension APIService {
    
    func login(email: String, password: String) async throws -> LoginResponse {
        struct Body: Codable {
            let email: String
            let password: String
        }
        
        let body = try JSONEncoder().encode(Body(email: email, password: password))
        
        let response: LoginResponse = try await request(
            endpoint: "/auth/login",
            method: "POST",
            body: body
        )
        
        UserDefaults.standard.set(response.id, forKey: "userId")
        UserDefaults.standard.set(response.email, forKey: "userEmail")
        UserDefaults.standard.set(response.name, forKey: "userName")
        UserDefaults.standard.set(response.role, forKey: "userRole")
        
        return response
    }
    
    func listClasses() async throws -> [Course] {
        try await request(endpoint: "/class/classes")
    }
    
    func listAssignments(classId: Int) async throws -> [Assignment] {
        try await request(endpoint: "/assignment/\(classId)")
    }
    
    func getUserId() async throws -> Int {
        struct Response: Codable { let id: Int }
        let res: Response = try await request(endpoint: "/user/")
        return res.id
    }
 
    func createReview(assignmentId: Int, reviewerId: Int, revieweeId: Int) async throws -> Review {
        struct Body: Codable {
            let assignment_id: Int
            let reviewer_id: Int
            let reviewee_id: Int
        }
        let body = try JSONEncoder().encode(
            Body(
                assignment_id: assignmentId,
                reviewer_id: reviewerId,
                reviewee_id: revieweeId
            )
        )
        return try await request(endpoint: "/review/", method: "POST", body: body)
    }
    
    func createCriterion(
        reviewId: Int,
        row: Int,
        column: Int,
        comment: String
    ) async throws -> EmptyResponse {
        struct Body: Codable {
            let review_id: Int
            let row: Int
            let column: Int
            let comment: String
        }

        let body = try JSONEncoder().encode(
            Body(
                review_id: reviewId,
                row: row,
                column: column,
                comment: comment
            )
        )

        return try await request(
            endpoint: "/criterion",
            method: "POST",
            body: body
        )
    }
}
