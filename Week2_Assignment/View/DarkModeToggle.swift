//
//  DarkModeToggle.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//

import SwiftUI

struct DarkModeToggle: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack {
            // Toggle to switch between light and dark modes
            Toggle(isOn: $isDarkMode){}
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: isDarkMode ? .gray : .black))
        }
    }
}

struct DarkModeToggle_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeToggle(isDarkMode: .constant(false))
    }
}
