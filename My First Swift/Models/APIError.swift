//
//  APIError.swift
//  MovieFinder
//

import Foundation

struct APIError: Error {
    let errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
