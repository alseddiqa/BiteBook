//
//  Untitled.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            WebImage(url: URL(string: recipe.image))
            // Placeholder while loading
                .resizable()
                .scaledToFill()
                .frame(height: 130)
                .clipped()

            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.green)
                        Text("\(recipe.prepTimeMinutes + recipe.cookTimeMinutes) min")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", recipe.rating))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(16)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}
