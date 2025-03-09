//
//  HomeViewModelTests.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//

import Testing
@testable import BiteBook

struct HomeViewModelTests {
    
    @Test func testSortRecipes() {
        let mockService = MockRecipeService()
        let viewModel = HomeViewModel(recipeService: mockService)

        // Set up mock recipes
        viewModel.recipes = [
            Recipe(
                id: 1,
                name: "Test Recipe 1",
                ingredients: ["Ingredient 1"],
                instructions: ["Step 1"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Healthy"],
                userId: 123,
                image: "test-image.jpg",
                rating: 4.0,
                reviewCount: 100,
                mealType: ["Lunch"]
            ),
            Recipe(
                id: 2,
                name: "Test Recipe 2",
                ingredients: ["Ingredient 2"],
                instructions: ["Step 2"],
                prepTimeMinutes: 15,
                cookTimeMinutes: 25,
                servings: 2,
                difficulty: "Medium",
                cuisine: "Mexican",
                caloriesPerServing: 400,
                tags: ["Spicy"],
                userId: 456,
                image: "test-image-2.jpg",
                rating: 4.5,
                reviewCount: 50,
                mealType: ["Dinner"]
            )
        ]

        // Test sorting by rating
        viewModel.sortRecipes(by: .rating)
        #expect(viewModel.recipes[0].name == "Test Recipe 2")
        #expect(viewModel.recipes[1].name == "Test Recipe 1")

        // Test sorting by preparation time
        viewModel.sortRecipes(by: .preparationTime)
        #expect(viewModel.recipes[0].name == "Test Recipe 1")
        #expect(viewModel.recipes[1].name == "Test Recipe 2")
    }
    
    @Test func testSelectCategory() {
        let mockService = MockRecipeService()
        let viewModel = HomeViewModel(recipeService: mockService)
        
        // Set up mock recipes
        viewModel.recipes = [
            Recipe(
                id: 1,
                name: "Test Recipe 1",
                ingredients: ["Ingredient 1"],
                instructions: ["Step 1"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Healthy"],
                userId: 123,
                image: "test-image.jpg",
                rating: 4.5,
                reviewCount: 100,
                mealType: ["Lunch"]
            )
        ]
        
        // Test selecting a category
        viewModel.selectCategory("Lunch")
        #expect(viewModel.selectedCategory == "Lunch")
    }
    
    @Test func testFilteredRecipes() {
        let mockService = MockRecipeService()
        let viewModel = HomeViewModel(recipeService: mockService)

        viewModel.recipes = [
            Recipe(
                id: 1,
                name: "Test Recipe 1",
                ingredients: ["Ingredient 1"],
                instructions: ["Step 1"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Healthy"],
                userId: 123,
                image: "test-image.jpg",
                rating: 4.5,
                reviewCount: 100,
                mealType: ["Lunch"]
            ),
            Recipe(
                id: 2,
                name: "Test Recipe 2",
                ingredients: ["Ingredient 2"],
                instructions: ["Step 2"],
                prepTimeMinutes: 15,
                cookTimeMinutes: 25,
                servings: 2,
                difficulty: "Medium",
                cuisine: "Mexican",
                caloriesPerServing: 400,
                tags: ["Spicy"],
                userId: 456,
                image: "test-image-2.jpg",
                rating: 4.0,
                reviewCount: 50,
                mealType: ["Dinner"]
            )
        ]

        // Test filtering by search text
        viewModel.searchText = "Recipe 1"
        #expect(viewModel.filteredRecipes.count == 1)
        #expect(viewModel.filteredRecipes[0].name == "Test Recipe 1")

        // Test filtering by category
        viewModel.searchText = ""
        viewModel.selectedCategory = "Dinner"
        #expect(viewModel.filteredRecipes.count == 1)
        #expect(viewModel.filteredRecipes[0].name == "Test Recipe 2")

        // Test filtering by both search text and category
        viewModel.searchText = "Recipe"
        viewModel.selectedCategory = "Lunch"
        #expect(viewModel.filteredRecipes.count == 1)
        #expect(viewModel.filteredRecipes[0].name == "Test Recipe 1")
    }
    
    
    @Test func testFetchRecipesSuccess() async throws {
        let mockService = MockRecipeService()
        mockService.mockRecipes = RecipeResponse(recipes: [
            Recipe(
                id: 1,
                name: "Test Recipe 1",
                ingredients: ["Ingredient 1"],
                instructions: ["Step 1"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Healthy"],
                userId: 123,
                image: "test-image.jpg",
                rating: 4.5,
                reviewCount: 100,
                mealType: ["Lunch"]
            )
        ])

        let viewModel = HomeViewModel(recipeService: mockService)

        // Wait for the asynchronous operation to complete
        await viewModel.getRecipesAsync()

        // Assertions
        #expect(viewModel.recipes.count == 1)
        #expect(viewModel.recipes[0].name == "Test Recipe 1")
        #expect(viewModel.loadingState == false)
        #expect(viewModel.error == nil)
    }
    
}
