//
//  APITasks.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 04/03/2025.
//

class APITasks: RecipeService {
    static let shared = APITasks()
    private init() {}
    
    func fetchRecipes() async throws -> RecipeResponse? {
        return try await APIService.shared.request(endpoint: "https://dummyjson.com/recipes")
    }
}
protocol RecipeService {
    func fetchRecipes() async throws -> RecipeResponse?
}
