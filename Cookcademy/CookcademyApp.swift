//
//  CookcademyApp.swift
//  Cookcademy
//
//  Created by Yuliia on 20.04.23.
//

import SwiftUI

@main


struct CookcademyApp: App {
@StateObject var cModel = ColorTheme()
  var body: some Scene {
        WindowGroup {
            MainTabView(selectedColor: $cModel.cc)
                .environmentObject(cModel)
        }
    }
}
