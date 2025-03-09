//
//  HomeView.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(recipeService: APITasks.shared)
    @State private var showingFilterSheet = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                if !viewModel.recipes.isEmpty {
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                }
                ZStack {
                    // Loading state
                    if viewModel.loadingState {
                        LoadingView()
                    }
                    // Error state
                    else if viewModel.error != nil {
                        ErrorView(
                            error: viewModel.error,
                            retryAction: viewModel.getRecipes
                        )
                    }
                    // Content state
                    else {
                        VStack(alignment: .leading, spacing: 16) {
                            // Categories only shown when we have recipes
                            if !viewModel.recipes.isEmpty {
                                CategoryScrollView(
                                    categories: viewModel.uniqueCategories,
                                    selectedCategory: viewModel.selectedCategory,
                                    onSelect: viewModel.selectCategory
                                )
                            }
                            
                            // Main content area (recipes list or empty state)
                            if viewModel.filteredRecipes.isEmpty {
                                EmptyStateView(message: "No recipes found 🥺")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                RecipeListView(recipes: viewModel.filteredRecipes)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                viewModel.getRecipes()
            }
            .refreshable {
                viewModel.getRecipes()
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingFilterSheet = true
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $showingFilterSheet) {
                FilterSheet(viewModel: viewModel)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }

    
    struct CategoryButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.system(.subheadline, weight: .semibold))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(isSelected ? Color.orange : Color(.systemGray5))
                    .foregroundColor(isSelected ? .white : .primary)
                    .cornerRadius(4)
            }
        }
    }

    struct CategoryScrollView: View {
        let categories: [String]
        let selectedCategory: String
        let onSelect: (String) -> Void
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        CategoryButton(
                            title: category,
                            isSelected: category == selectedCategory
                        ) {
                            onSelect(category)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    

    struct RecipeListView: View {
        let recipes: [Recipe]
        
        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

private struct SearchBar: View {
    @Binding var text: String
    @State private var promptIndex = 0
    @State private var displayedPrompt = ""
    @State private var charIndex = 0
    let prompts = ["Search recipes...", "What would you like to eat...", "Find your next meal..."]

    var body: some View {
        HStack {
            TextField(displayedPrompt.isEmpty ? prompts[promptIndex] : displayedPrompt, text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                    UIApplication.shared.resignFirstResponder()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear {
            startPromptAnimation()
        }
    }

    private func startPromptAnimation() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                charIndex = 0
                displayedPrompt = ""
                promptIndex = (promptIndex + 1) % prompts.count
                startTypingAnimation()
            }
        }
    }

    private func startTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if charIndex < prompts[promptIndex].count {
                displayedPrompt.append(prompts[promptIndex][prompts[promptIndex].index(prompts[promptIndex].startIndex, offsetBy: charIndex)])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct FilterSheet: View {
        @ObservedObject var viewModel: HomeViewModel
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Sort By")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Button(action: {
                    viewModel.sortRecipes(by: .rating)
                    dismiss()
                }) {
                    Text("Highest Rating ⭐️")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.sortRecipes(by: .preparationTime)
                    dismiss()
                }) {
                    Text("Lowest Preparation Time ⏱️")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
    }

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
