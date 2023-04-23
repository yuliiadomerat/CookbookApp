//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @EnvironmentObject private var recipeData: RecipeData
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
    @Binding var selectedColor: Color
    var body: some View {
            NavigationView {
            VStack(){
                    
                    Text("Categories")
                        .padding()
                        .font(.title)
                        .fontWeight(.heavy)
                        .fontDesign(.serif)
                        .kerning(2)
                        .foregroundColor(Color("FontColor") )
                    
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem()], content: {
                            ForEach(MainInformation.Category.allCases, id: \.self) { category in
                                NavigationLink(
                                    destination: RecipesListView(viewStyle: .singleCategory(category), selectedColor: $selectedColor),
                                    label: {
                                        CategoryView(category: category, selectedColor: $selectedColor)
                                    })
                            }
                        })
                        
                    }
                    
                }.background(selectedColor)
             
            }
            .background(selectedColor
                .ignoresSafeArea())
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
    @Binding var selectedColor: Color
   
    
    var body: some View {
        VStack{
            ZStack(){
     
    
                    HStack(){
                        
                        Text(category.rawValue)
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundColor(Color("FontColor") )
                          
                        
                        Spacer()
                            .frame(maxWidth: 150)
                        
                        
                    }
                    .frame(width: 350, height: 70)
                    .cornerRadius(10)
                    .background(.ultraThinMaterial.opacity(0.4))
                    
                    Image(category.rawValue)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .offset(x: 80, y: -20)
               
                    
                
            }
            
            
        }
        .frame(width: 350, height: 140)
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    @State static var colorSample = Color("Brown")
    static var previews: some View {
        RecipeCategoryGridView(selectedColor: $colorSample)
    }
}
