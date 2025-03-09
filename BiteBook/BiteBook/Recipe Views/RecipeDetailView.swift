//
//  Untitled.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Recipe Image
                WebImage(url: URL(string: recipe.image))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .padding(.horizontal, -16)
                    .padding(.top, 0)
                    .ignoresSafeArea(edges: .top)

                VStack(alignment: .leading, spacing: 16) {

                    // Recipe Details
                    HStack(spacing: 20) {
                        infoItem(
                            title: "Time",
                            value: "\(recipe.prepTimeMinutes + recipe.cookTimeMinutes) min",
                            icon: "clock",
                            color: .green
                        )
                        Spacer()
                        infoItem(
                            title: "Calories",
                            value: "\(recipe.caloriesPerServing) cal",
                            icon: "flame",
                            color: .red
                        )
                        Spacer()
                        infoItem(
                            title: "Servings",
                            value: "\(recipe.servings)",
                            icon: "person.2",
                            color: .blue
                        )
                    }
                    .frame(maxWidth: .infinity) // Ensures it expands
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)


                    // Ingredients Section
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top, 8)

                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(.orange)
                                Text(ingredient)
                                    .font(.body)
                            }
                        }
                    }

                    // Instructions Section
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top, 8)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.element) { index, step in
                            HStack(alignment: .top) {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .frame(width: 24, height: 24)
                                    .background(Color.orange.opacity(0.8))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(step)
                                        .bold()
                                }
                            }
                        }
                    }
                    Button(action: {
                        favoritesManager.toggleFavorite(recipe: recipe)
                    }) {
                        Text(favoritesManager.isFavorite(recipe: recipe) ? "Remove from Favorite" : "Add to Favorite")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(favoritesManager.isFavorite(recipe: recipe) ? Color.gray : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func infoItem(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)

            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(.primary)

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

}
