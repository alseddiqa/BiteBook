//
//  MockService.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//

import Foundation
@testable import BiteBook

class MockRecipeService: RecipeService {
    var shouldFail = false
    var mockRecipes: RecipeResponse?

    func fetchRecipes() async throws -> RecipeResponse? {
        if shouldFail {
            throw APIError.requestFailed(NSError(domain: "TestError", code: -1, userInfo: nil))
        }
        return mockRecipes
    }
}
