//
//  Recipe.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 04/03/2025.
//
import Foundation

public struct Recipe: Codable {
    public let id: Int
    public let name: String
    public let ingredients: [String]
    public let instructions: [String]
    public let prepTimeMinutes: Int
    public let cookTimeMinutes: Int
    public let servings: Int
    public let difficulty: String
    public let cuisine: String
    public let caloriesPerServing: Int
    public let tags: [String]
    public let userId: Int
    public let image: String
    public let rating: Double
    public let reviewCount: Int
    public let mealType: [String]
    
    public init(id: Int, name: String, ingredients: [String], instructions: [String],
                prepTimeMinutes: Int, cookTimeMinutes: Int, servings: Int,
                difficulty: String, cuisine: String, caloriesPerServing: Int,
                tags: [String], userId: Int, image: String, rating: Double,
                reviewCount: Int, mealType: [String]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.caloriesPerServing = caloriesPerServing
        self.tags = tags
        self.userId = userId
        self.image = image
        self.rating = rating
        self.reviewCount = reviewCount
        self.mealType = mealType
    }
}

public struct RecipeResponse: Decodable {
    public let recipes: [Recipe]
}
