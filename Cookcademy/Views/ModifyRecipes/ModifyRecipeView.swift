//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct ModifyRecipeView: View {
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false

    @Binding var selectedColor: Color
    
    @Binding var recipe: Recipe

    @State private var selection = Selection.main
    

    var body: some View {
       
            VStack {
                FSPicker(selection: $selection) {
                    Text("Main Info")
                        .tag(Selection.main)
                    
                    
                    Text("Ingredients")
                        .tag(Selection.ingredients)
                    
                    
                    Text("Directions")
                        .tag(Selection.directions)
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selection {
                case .main:
                    ModifyMainInformationView(selectedColor: $selectedColor, mainInformation: $recipe.mainInformation)
                case .ingredients:
                    ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients, selectedColor: $selectedColor)
                case .directions:
                    ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions, selectedColor: $selectedColor)
                }
             
                Spacer()       
        }
        .background(selectedColor)
      
    }
    
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        ModifyRecipeView(selectedColor: $colorSample, recipe: $recipe)
    }
}
