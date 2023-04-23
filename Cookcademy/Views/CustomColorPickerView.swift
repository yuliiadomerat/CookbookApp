//
//  CustomColorPickerView.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

class ColorTheme: ObservableObject {
    @Published var cc: Color = Color("Brown")
}

struct CustomColorPickerView: View {

    @Binding var selectedColor: Color
    let colors: [Color] = [Color("Blue"), Color("Brown"), Color("Grey"), Color("Purple"), Color("Red")]
    
var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            self.selectedColor = color
                        }) {
                            Image(systemName: self.selectedColor == color ? "checkmark.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .shadow(color: Color("FontColor"), radius: 7)
                                
                        }.accentColor(color)
                    }
                }
                .padding()
            }
        }
    }


//struct CustomColorPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomColorPickerView()
//    }
//}
