//
//  ModifyComponentsView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible, Codable {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(selectedColor: Binding<Color>, component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    
    @State private var newComponent = Component()
    
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
    
    @Binding var selectedColor: Color

    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(selectedColor: $selectedColor, component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }
                //.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                
                Spacer()
                NavigationLink(destination: addComponentView, label:{
                    HStack{
                        
                        Spacer()
                        VStack{
                            Text("Add the first \(Component.singularName())")
                                .padding()
                                .foregroundColor(Color("FontColor") )
                                .fontDesign(.serif)
                            
                            
                        }
                        .padding()
                        
                        Spacer()
                        
                    }
                    .background(selectedColor)
                    .ignoresSafeArea()
                    .padding()
                    
                })
                Spacer()
            } else {
                HStack {
                    Text(Component.pluralName().capitalized)
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                        .fontWeight(.heavy)
                        .font(.title)
                      
                    
                    Spacer()
                    
                    EditButton()
                        .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                      
                }
                .padding()
                ScrollView {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        let editComponentView = DestinationView(selectedColor: $selectedColor, component: $components[index]) { _ in return }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                        NavigationLink( destination: editComponentView, label: {
                            Text(component.description)
                                .font(.headline)
                                .withDefaultWidthCustomButton()
                            
                        })
                    }
                    .onDelete { components.remove(atOffsets: $0) }
                    .onMove { indices, newOffet in components.move(fromOffsets: indices, toOffset: newOffet) }
                    .listRowBackground(selectedColor)
                    NavigationLink(
                        destination: addComponentView, label:{
                            
                            Image(systemName: "plus")
                                .font(.title)
                                .withDefaultWidthCustomButton(frameWidth: 100)
                        })
                       
                }
                Spacer()
                .foregroundColor(Color("FontColor") )
            }
        }
        .padding()
        .background(selectedColor)
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    @State static var emptyIngredients = [Ingredient]()
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients, selectedColor: $colorSample)
        }
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients, selectedColor: $colorSample)
        }
    }
}
