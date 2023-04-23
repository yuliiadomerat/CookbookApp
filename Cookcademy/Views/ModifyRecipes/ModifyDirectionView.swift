//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//
import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    @Binding var selectedColor: Color
    init(
        selectedColor: Binding<Color>,
        component: Binding<Direction>,
        createAction: @escaping (Direction) -> Void) {
        self._selectedColor = selectedColor
        self._direction = component
        self.createAction = createAction
    }
    
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false

    @Environment(\.presentationMode) private var mode
    @EnvironmentObject private var recipeData: RecipeData

    var body: some View {
        VStack(){
           Spacer()
            VStack {
                TextField("Direction Description", text: $direction.description)
                    .withDefaultWidthCustomButton()
                
                Toggle(isOn: $direction.isOptional, label: {
                    Text("Optional")
                })
                .withDefaultWidthCustomButton()
                
                HStack (alignment: .center){
                    Spacer()
                    Button(action: {
                        createAction(direction)
                        mode.wrappedValue.dismiss()
                    }, label:{
                        Text("Save")
                            .withDefaultWidthCustomButton(frameWidth: 100)
                        
                    })
                    Spacer()
                }
            }
            
            
            Spacer()
        }
       
        .foregroundColor(Color("FontColor") )
        .padding()
        .background(selectedColor)
  
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            ModifyDirectionView(selectedColor: .constant(Color("Brown")), component: $recipe.directions[0]) { direction in
                print(direction)
            }
        }
    }
}
