//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//
import SwiftUI
import UIKit

struct MainTabView: View {
    @StateObject var recipeData = RecipeData()
    @Binding var selectedColor: Color
        
    var body: some View {
        
        ZStack{
            VStack{
                
            TabView {
                    RecipeCategoryGridView(selectedColor: $selectedColor)
                        .tabItem {
                            Label("Recipes", systemImage: "list.dash")
                            }
                    NavigationView {
                        RecipesListView(viewStyle: .favorites, selectedColor: $selectedColor)
                    }.tabItem {
                        Label("Favorites", systemImage: "heart.fill") }
                    
                    SettingsView(selectedColor: $selectedColor)
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                
            }
            .environmentObject(recipeData)
            .onAppear {
                recipeData.loadRecipes()
                UITabBar.appearance().backgroundColor = UIColor((.white.opacity(0.2)))
            }
            //.accentColor(selectedColor)
        }
    }
    }

struct MainTabView_Previews: PreviewProvider {
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        MainTabView(
            selectedColor: $colorSample
        )
    }
}
