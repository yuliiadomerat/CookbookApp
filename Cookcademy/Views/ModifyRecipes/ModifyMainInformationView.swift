//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct ModifyMainInformationView: View {
    
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
    @Binding var selectedColor: Color


    @Binding var mainInformation: MainInformation
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        
        VStack(spacing: 10){
            TextField("Recipe Name", text: $mainInformation.name)
                .withDefaultWidthCustomButton()


            TextField("Author", text: $mainInformation.author)
                .withDefaultWidthCustomButton()
              
        
            TextField("Short Description", text: $mainInformation.description)
                .withDefaultWidthCustomButton(frameHeight: 150)
               
            
            Picker(selection: $mainInformation.category, label: HStack {
                
                    Text(mainInformation.category.rawValue)
                       .foregroundColor(Color("FontColor") )
                        .fontDesign(.serif)
                    
                }) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                            .foregroundColor(Color("FontColor") )
                            .fontDesign(.serif)
                    }
                }

                .frame(height: 100)
                .pickerStyle(WheelPickerStyle())
                

        }
        .padding()
        .background(selectedColor)
 
        

    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "Test Name",
                                                        description: "Test Description",
                                                        author: "Test Author",
                                                        category: .breakfast)
    @State static var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast)
    @State static var colorSample = Color("Brown")
        
    static var previews: some View {
        ModifyMainInformationView(selectedColor: $colorSample, mainInformation: $mainInformation)
        ModifyMainInformationView(selectedColor: $colorSample, mainInformation: $emptyInformation)
    }
}
