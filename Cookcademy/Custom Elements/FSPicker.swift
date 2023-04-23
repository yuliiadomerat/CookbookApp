//
//  FSPicker.swift
//  Cookcademy
//
//  Created by Yuliia on 09.04.23.
//

import Foundation
import SwiftUI

struct FSPicker<SelectionValue: Hashable, Content: View>: View {
  @Namespace var ns
  @Binding var selection: SelectionValue
  @ViewBuilder let content: Content
    
  @AppStorage("hideOptionalDirections") private var hideOptionalDirections: Bool = false
  //@Binding var selectedColor: Color

  public var body: some View {
    let contentMirror = Mirror(reflecting: content)
    let blocksCount = Mirror(reflecting: contentMirror.descendant("value")!).children.count // How many children?
    HStack {
      ForEach(0..<blocksCount) { index in
        let tupleBlock = contentMirror.descendant("value", ".\(index)")
        let text = Mirror(reflecting: tupleBlock!).descendant("content") as! Text
        let tag = Mirror(reflecting: tupleBlock!).descendant("modifier", "value", "tagged") as! SelectionValue

        Button {
            withAnimation(.easeInOut){
                selection = tag
            }} label: {
          text
            .fontDesign(.serif)
            .padding(.vertical, 16)
        }
        .background(
          Group {
            if tag == selection {
                Color("FontColor") .frame(height: 2)
                .matchedGeometryEffect(id: "selector", in: ns)
            }
          },
          alignment: .bottom
        )
        .accentColor(tag == selection ?  Color("FontColor")  : .gray)
      }
    }
  }
}
