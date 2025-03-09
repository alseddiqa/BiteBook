//
//  BiteBookTests.swift
//  BiteBookTests
//
//  Created by Abdullah Alseddiq on 04/03/2025.
//

import Testing
@testable import BiteBook

struct BiteBookTests {

    @Test func testRecipeInitialization() {
            let recipe = Recipe(
                id: 1,
                name: "Test Recipe",
                ingredients: ["Ingredient 1", "Ingredient 2"],
                instructions: ["Step 1", "Step 2"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Healthy", "Quick"],
                userId: 123,
                image: "test-image.jpg",
                rating: 4.5,
                reviewCount: 100,
                mealType: ["Lunch", "Dinner"]
            )

            #expect(recipe.id == 1)
            #expect(recipe.name == "Test Recipe")
            #expect(recipe.ingredients.count == 2)
            #expect(recipe.instructions.count == 2)
            #expect(recipe.prepTimeMinutes == 10)
            #expect(recipe.cookTimeMinutes == 20)
            #expect(recipe.servings == 4)
            #expect(recipe.difficulty == "Easy")
            #expect(recipe.cuisine == "Italian")
            #expect(recipe.caloriesPerServing == 300)
            #expect(recipe.tags == ["Healthy", "Quick"])
            #expect(recipe.userId == 123)
            #expect(recipe.image == "test-image.jpg")
            #expect(recipe.rating == 4.5)
            #expect(recipe.reviewCount == 100)
            #expect(recipe.mealType == ["Lunch", "Dinner"])
        }

}
