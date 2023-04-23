//
//  ContentView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct RecipesListView: View {    
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle

    @State private var isPresenting = false
    @State private var newRecipe = Recipe()

    @Binding var selectedColor: Color
    
    var body: some View {
      
        HStack(){
            VStack(alignment: .leading){
                
                
                //Title ans Navigation toolbar
                HStack(){
                 
                    
                    // Title Add func
                Text(navigationTitle)
                   
                    .font(.title)
                    .fontWeight(.heavy)
                    .fontDesign(.serif)
                    .kerning(2)
                    .foregroundColor(Color("FontColor") )
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                                        newRecipe = Recipe()
                                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                                        isPresenting = true
                                    }, label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(Color("FontColor") )
                                    })
                
                
            }
                .padding()
                ScrollView {
                    ForEach(recipes) { recipe in
                        NavigationLink(
                            recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe), selectedColor: $selectedColor))
                                .withDefaultWidthCustomButton()
                        
                    }
                       
                   // .onDelete(perform: )
                }
                .padding()
                
                
            }
            Spacer()
        }
        .padding(.top, -10)
        .background(selectedColor)

        .sheet(isPresented: $isPresenting, content: {
            NavigationView {
                ModifyRecipeView(selectedColor: $selectedColor, recipe: $newRecipe)                
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            if newRecipe.isValid {
                                Button("Add") {
                                    recipeData.add(recipe: newRecipe)
                                    isPresenting = false
                                }
                            }
                        }
                    })
            }
        })
    }
}

extension RecipesListView {
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }

    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast), selectedColor: $colorSample)
        }.environmentObject(RecipeData())
    }
}
