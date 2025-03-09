//
//  BiteBookApp.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//

import SwiftUI
import SwiftfulLoadingIndicators
import SDWebImageSwiftUI

@main
struct BiteBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject var favoritesManager = FavoritesManager() // Create instance here
    @State private var showLaunchScreen = true

    var body: some View {
        ZStack {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Delay for 2 seconds
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                TabView {
                    // Home Tab
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    // Favorite Tab
                    FavoriteView()
                        .tabItem {
                            Label("Favorite", systemImage: "heart")
                        }
                }
                .accentColor(.orange)
                .environmentObject(favoritesManager)
            }
        }
    }
}


struct LaunchScreenView: View {
    var body: some View {
        // Your launch screen design here
        VStack {
            Image("AppLogo") //replace AppLogo with your logo name in Assets.
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Bite Book")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.medium)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange) //or any background colour.
    }
}
