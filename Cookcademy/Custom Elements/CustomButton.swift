//
//  CustomButton.swift
//  Cookcademy
//
//  Created by Yuliia on 19.04.23.
//

import Foundation
import SwiftUI

struct CustomButtonViewModifier: ViewModifier {
    @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
  
    
    
   let frameWidth: CGFloat
    let frameHeight: CGFloat

   func body(content: Content) -> some View {
        content
         .padding()
         .foregroundColor(Color("FontColor") )
         .fontDesign(.serif)
         .frame(width: frameWidth, height: frameHeight)
         .background(.ultraThinMaterial.opacity(0.3))

    }

}

extension View {

    func withDefaultWidthCustomButton(frameWidth: CGFloat = 350, frameHeight: CGFloat = 50) -> some View {

        modifier(CustomButtonViewModifier(frameWidth: frameWidth, frameHeight: frameHeight))
        
    }
}
