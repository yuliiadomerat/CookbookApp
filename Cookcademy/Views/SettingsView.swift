//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false

    @Binding var selectedColor: Color
    @State private var bgColor =
            Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    var body: some View {
        HStack{
        NavigationView {
                VStack {
                   // Spacer()
                   Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .fontDesign(.serif)
                        .kerning(2)
                        .foregroundColor(Color("FontColor") )
                    
                    
                    VStack{
                        Text("List Background Color")
                            .withDefaultWidthCustomButton()
                        CustomColorPickerView(selectedColor: $selectedColor)
                        
                

                    }
                    
                   // .padding()
                       // .listRowBackground(selectedColor)
                    
                       // .listRowBackground(selectedColor)
                    Toggle("Hide Optional Steps", isOn: $hideOptionalDirections)
                        .padding()
                        .withDefaultWidthCustomButton()
                    Spacer()
                }
                .padding()
                .background(selectedColor)
                
        }
        }
        .padding()
        .background(selectedColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedColor: .constant(Color("Brown")))
    }
}
