//
//  FavoriteView.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    if favoritesManager.favoriteRecipes.isEmpty {
                        VStack {
                            Spacer()
                            EmptyStateView(message: "You haven't added any recipes yet!")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            Spacer()
                        }
                    } else {
                        VStack(spacing: 20) {
                            ForEach(favoritesManager.favoriteRecipes, id: \.id) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeRow(recipe: recipe)
                                }
                            }
                        }
                        .padding(20)
                    }
                }
                
            }
            .navigationTitle("Favorites")
        }
    }
}
