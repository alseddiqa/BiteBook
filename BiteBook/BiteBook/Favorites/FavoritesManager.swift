//
//  FavoritesManager.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favoriteRecipes: [Recipe] = []

    init() {
        loadFavorites()
    }

    func toggleFavorite(recipe: Recipe) {
        if favoriteRecipes.contains(where: { $0.id == recipe.id }) {
            favoriteRecipes.removeAll { $0.id == recipe.id }
        } else {
            favoriteRecipes.append(recipe)
        }
        saveFavorites()
    }

    func isFavorite(recipe: Recipe) -> Bool {
        return favoriteRecipes.contains(where: { $0.id == recipe.id })
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favoriteRecipes"),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) {
            favoriteRecipes = decodedRecipes
        }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: "favoriteRecipes")
        }
    }
}
