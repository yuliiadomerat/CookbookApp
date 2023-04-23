//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI
import UIKit


struct ModifyIngredientView: ModifyComponentView {

    @Binding var selectedColor: Color
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    init(
        selectedColor: Binding<Color>,
        component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._selectedColor = selectedColor
        self._ingredient = component
        self.createAction = createAction
    }

    
    @Environment(\.presentationMode) private var mode
    @EnvironmentObject private var recipeData: RecipeData

    var body: some View {
        VStack{
            Spacer()
            VStack {
                TextField("Ingredient Name", text: $ingredient.name)
                    .withDefaultWidthCustomButton()
                
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                            .foregroundColor(.white)
                            .keyboardType(.numbersAndPunctuation)
                    }
                    .foregroundColor(.white)
                }
                .withDefaultWidthCustomButton()
                
                Picker(selection: $ingredient.unit, label: HStack {
                    Text("Unit")
                        .foregroundColor(.white)
                        .fontDesign(.serif)
                    Spacer()
                    Text(ingredient.unit.rawValue)
                        .foregroundColor(.white)
                        .fontDesign(.serif)
                }) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                            .padding()
                            .foregroundColor(.white)
                            .fontDesign(.serif)
                        
                    }
                }
                .frame(height: 100)
                .pickerStyle(WheelPickerStyle())
                
                HStack {
                    Spacer()
                    Button(action: {
                        createAction(ingredient)
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Text( "Save")
                            .withDefaultWidthCustomButton(frameWidth: 100)
                    })
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
        .background(selectedColor)
        .ignoresSafeArea()
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            ModifyIngredientView(
                selectedColor: .constant(Color("Brown")),
                component: $recipe.ingredients[0]) { ingredient in
                print(ingredient)
            }
        }
    }
}
