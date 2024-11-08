//
//  RequestState.swift
//  FlexSub
//
//  Created by Theo Marie on 29/10/2024.
//
import Foundation

enum RequestState<T> {
    case idle
    case loading
    case success(T)
    case error(Error)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
