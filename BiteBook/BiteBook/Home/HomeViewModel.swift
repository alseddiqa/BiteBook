//
//  HomeViewModel.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI
class HomeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "All"
    @Published var loadingState: Bool = false
    @Published var error: APIError?
    @Published var uniqueCategories: [String] = ["All"]
    
    private let recipeService: RecipeService
    
    init(recipeService: RecipeService = APITasks.shared) {
        self.recipeService = recipeService
    }
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty && selectedCategory == "All" {
            return recipes
        } else {
            return recipes.filter { recipe in
                let searchTextMatch = searchText.isEmpty || recipe.name.localizedCaseInsensitiveContains(searchText)
                let categoryMatch = selectedCategory == "All" || recipe.mealType.contains(selectedCategory)
                return searchTextMatch && categoryMatch
            }
        }
    }
    
    func getRecipes() {
        loadingState = true
        error = nil
        Task {
            do {
                if let response = try await recipeService.fetchRecipes() { // Use recipeService, not APITasks.shared
                    DispatchQueue.main.async {
                        self.recipes = response.recipes
                        self.updateCategories()
                        self.loadingState = false
                    }
                }
            } catch let apiError as APIError {
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.error = apiError
                }
            } catch {
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.error = APIError.requestFailed(error)
                }
            }
        }
    }
    
    private func updateCategories() {
        var categories = Set<String>()
        
        for recipe in recipes {
            categories.formUnion(recipe.mealType)
        }
        
        var sortedCategories = Array(categories)
        sortedCategories.sort()
        
        uniqueCategories = ["All"] + sortedCategories
    }
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func sortRecipes(by option: SortOption) {
        switch option {
        case .rating:
            recipes.sort { $0.rating > $1.rating }
        case .preparationTime:
            recipes.sort { $0.prepTimeMinutes < $1.prepTimeMinutes }
        }
    }
    
    //For testing purposes
    func getRecipesAsync() async {
        return await withCheckedContinuation { continuation in
            getRecipes()
            // Observe when the loading state changes to false (indicating completion)
            let cancellable = self.$loadingState
                .sink { loadingState in
                    if !loadingState {
                        continuation.resume()
                    }
                }
            // Store the cancellable to keep the observation alive
            DispatchQueue.main.async {
                _ = cancellable // Keep the observer alive
            }
        }
    }
    
}

enum SortOption {
    case rating
    case preparationTime
}
