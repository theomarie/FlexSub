//
//  RequestManager.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//
import Foundation

@Observable class RequestManager {
    static let shared = RequestManager()
    private init() {}
    
    func perform<T>(_ operation: @escaping () async throws -> T) async -> RequestState<T> {
        var state: RequestState<T> = .loading  // Spécifier explicitement le type
        
        do {
            let result = try await operation()
            state = .success(result)
        } catch {
            state = .error(error)
        }
        
        return state
    }
}


