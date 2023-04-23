//
//  RecipeDetailView.swift
//  RecipeTracker
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe

    @Binding var selectedColor: Color
    
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
    @State private var isPresenting = false
    @EnvironmentObject private var recipeData: RecipeData

    var body: some View {
        VStack {
            
            // Header:
            HStack(alignment:.top){
                Text(recipe.mainInformation.name)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .fontDesign(.serif)
                    .kerning(2)
                    .foregroundColor(Color("FontColor") )
                
                Spacer()
                
                HStack {
                      Button(action: {
                       isPresenting = true
                        }, label: {
                            Text("Edit")
                            .foregroundColor(Color("FontColor") )
                            .fontDesign(.serif)
                
                               })
                                    Button(action: {
                                        recipe.isFavorite.toggle()
                                    }, label: {
                                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                           .foregroundColor(Color("FontColor") )
                                    })
                                }
                
                
            }
            .padding()
            
            VStack{
                HStack {
                    
                    Text("Author: \(recipe.mainInformation.author)")
                        .font(.headline)
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                        .padding()
                    Spacer()
                }
                HStack {
                    Text(recipe.mainInformation.description)
                        .font(.headline)
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                        .padding()
                    Spacer()
                }
                
            }
            .background(.ultraThinMaterial.opacity(0.3))
                ScrollView {
                    Section(header: Text("Ingredients")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                        .padding()
                            
                            
                    ) {
                        ForEach(recipe.ingredients.indices, id: \.self) { index in
                            let ingredient = recipe.ingredients[index]
                            Text(ingredient.description)
                                .font(.subheadline)
                                .fontDesign(.serif)
                                .foregroundColor(Color("FontColor") )
                            
                        }
                        
                       
                        
                    }
                    //.padding()
    
                    Section(header: Text("Directions")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                        .padding()
                    
                    
                    ) {
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            let direction = recipe.directions[index]
                            if direction.isOptional && hideOptionalDirections {
                                EmptyView()
                            } else {
                                
                                    HStack(alignment:.firstTextBaseline) {
                                        let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalDirections) ?? 0
                                        Text("\(index + 1). ").bold()
                                            .font(.subheadline)
                                            .fontDesign(.serif)
                                        
                                            .foregroundColor(Color("FontColor") )
                                        
                                        
                                        Text("\(direction.isOptional ? "(Optional) " : "")\(direction.description)")
                                        
                                            .font(.subheadline)
                                            .fontDesign(.serif)
                                            .foregroundColor(Color("FontColor") )
                                        
                                        Spacer(minLength: 0)
                                }
                               
                                .padding()
                            
                                .foregroundColor(Color("FontColor") )
                            }
                        }
                    }
                }
                
        }
      
        .background(selectedColor)
//        
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(selectedColor: $selectedColor, recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
            }
            .onDisappear {
                recipeData.saveRecipes()
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe, selectedColor: $colorSample)
        }
    }
}
