//
//  ServiceManager.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import Foundation

class ServiceManager: NSObject {
    
    public func authRequest() async throws {
        let url = requestType.auth.rawValue
        
        guard let authEnpoint = URL(string: url) else {
            debugPrint("Verify Endpoint... ")
            return
        }
        
        var request = URLRequest(url: authEnpoint)
        request.httpMethod = methodType.get.rawValue
        request.timeoutInterval = 10
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(URLBases().tokenAuth)", forHTTPHeaderField: "Authorization")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print("Esta es la data: \(String(decoding: data, as: UTF8.self))")
        }
    }
    
    func upcomingRequest() async throws -> Data {
        let url = requestType.upcoming.rawValue
        
        guard let authEnpoint = URL(string: url) else {
            debugPrint("Verify Endpoint... ")
            return Data()
        }
        var components = URLComponents(url: authEnpoint, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "es-ES"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = methodType.get.rawValue
        request.timeoutInterval = 10
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(URLBases().tokenAuth)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
    }
    
    func getTopRatedData(page: String) async throws -> Data {
        let url = requestType.topRated.rawValue
        
        guard let authEnpoint = URL(string: url) else {
            debugPrint("Verify Endpoint... ")
            return Data()
        }
        var components = URLComponents(url: authEnpoint, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "es-ES"),
          URLQueryItem(name: "page", value: page),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = methodType.get.rawValue
        request.timeoutInterval = 10
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(URLBases().tokenAuth)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
    }
}
