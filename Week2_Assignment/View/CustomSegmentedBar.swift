//
//  CustomSegmentedBar.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 13/09/1446 AH.
//

import SwiftUI
struct CustomSegmentedBar: View {
    @ObservedObject var taskModel: TaskViewModel  // Observed TaskViewModel to track the current tab
    var animation: Namespace.ID  // Namespace for animation effect
    let tabs = ["Today", "Upcoming", "Done"]  // Tabs for the segmented control
    @Binding var isDarkMode: Bool  // Binding for dark mode setting
    
    var body: some View {
        HStack(spacing: 10) {  // Horizontal stack for the tabs
            ForEach(tabs, id: \.self) { tab in
                Text(tab)  // Display the tab name
                    .font(.callout)  // Font style for the tab
                    .fontWeight(.semibold)  // Bold weight for the font
                    .scaleEffect(0.9)  // Slightly smaller scale for the tab text
                    .foregroundColor(taskModel.currentTab == tab ? (isDarkMode ? .black : .white) : (isDarkMode ? .white : .black))  // Dynamic text color based on current tab and dark mode
                    .padding(.vertical, 6)  // Vertical padding for the text
                    .frame(maxWidth: .infinity)  // Make the tab take equal width
                    .background {
                        // Active tab background styling with animation effect
                        if taskModel.currentTab == tab {
                            Capsule()
                                .fill(isDarkMode ? .white : .black)  // Background color for the selected tab (white in dark mode, black otherwise)
                                .matchedGeometryEffect(id: "Tab", in: animation)  // Apply animation for the transition between tabs
                        }
                    }
                    .contentShape(Capsule())  // Make the entire capsule tappable
                    .onTapGesture {
                        // Change the current tab when tapped
                        withAnimation {
                            taskModel.currentTab = tab
                        }
                    }
            }
        }
    }
}
