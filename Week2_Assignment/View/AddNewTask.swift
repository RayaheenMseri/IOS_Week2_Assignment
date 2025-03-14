//
//  AddNewTask.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//

import SwiftUI

struct AddNewTask: View {
    @ObservedObject var taskModel: TaskViewModel // Observing the task model for data updates
    @Environment(\.dismiss) var dismiss // Used to dismiss the current view
    @Namespace var animation // Namespace for animation effects
    @State var taskTitle: String = "" // State to hold the task title input
    @State var taskColor: Color = .yellow // State to hold the selected task color
    @State var taskDeadLine: Date = Date() // State to hold the task deadline
    @State var taskType: TaskType = .Basic // State to hold the selected task type
    @State var showDatePicker: Bool = false // State to control showing the date picker
    @Binding var isDarkMode: Bool // Binding to handle dark mode toggle

    var body: some View {
        VStack(spacing:12) {
            // Header with "Add New Task" text and back button
            Text("Add New Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button{
                        dismiss() // Dismiss the current view when back button is tapped
                    } label: {
                        Image(systemName: "arrow.left.circle")
                            .font(.title3)
                            .foregroundColor(isDarkMode ? .white : .black) // Adjust color based on dark mode
                    }
                }
            
            // Task Color Selection Section
            VStack(alignment: .leading, spacing: 12){
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
                HStack(spacing: 12){
                    // Loop through colors to create color circles for selection
                    ForEach(colors, id: \.self){ color in
                        Circle()
                            .fill(color)
                            .frame(width: 25, height: 25)
                            .background{
                                if taskColor == color {
                                    Circle()
                                        .stroke(.gray) // Stroke for the selected color
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                taskColor = color // Set selected color for the task
                            }
                    }
                }
                .padding(.top,10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,30)
            
            Divider()
                .background(Color.customColor) // Custom divider
                .padding(.vertical,10)
            
            // Task Deadline Section
            VStack(alignment: .leading, spacing: 12){
                Text("Task DeadLine")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + taskDeadLine.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.top,10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing){
                Button{
                    showDatePicker.toggle() // Toggle date picker visibility when button is tapped
                }label:{
                    Image(systemName: "calendar")
                        .foregroundColor(isDarkMode ? .white : .black)
                }
            }
            
            Divider()
                .background(Color.customColor)
            
            // Task Title Input Section
            VStack(alignment: .leading, spacing: 12){
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskTitle) // TextField for entering the task title
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .padding(.leading,10)
                    .background(isDarkMode ? .white.opacity(0.4) : .gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 5)
            }
            .textFieldStyle(.automatic)
            .padding(.top, 10)
            
            Divider()
                .background(Color.customColor)
            
            // Task Type Selection Section
            VStack(alignment: .leading, spacing: 12){
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    // Loop through all task types and display as selectable options
                    ForEach(TaskType.allCases){ type in
                        Text(type.rawValue)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskType.rawValue == type.rawValue ? (isDarkMode ? .black : .white) : (isDarkMode ? .white : .black)) // Adjust text color based on selection
                            .background{
                                if taskType.rawValue == type.rawValue {
                                    Capsule()
                                        .fill(isDarkMode ? .white : .black) // Highlight selected type with capsule
                                        .matchedGeometryEffect(id: "Type", in: animation) // Animation for matched geometry effect
                                } else {
                                    Capsule()
                                        .stroke(.black) // Border for unselected types
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation {
                                    taskType = type // Update selected task type
                                }
                            }
                    }
                }
                .padding(.top, 8)
            }.padding(.vertical,10)
            
            Divider()
                .background(Color.customColor)
            
            // Save Task Button
            Button{
                withAnimation(.smooth) {
                    taskModel.addTask(task: Task(title: taskTitle, taskColor: taskColor, taskDeadLine: taskDeadLine, taskType: taskType, isCompleted: false)) // Add new task
                    dismiss() // Dismiss the view after task is saved
                }
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(isDarkMode ? .black : .white)
                    .background{
                        Capsule()
                            .fill(isDarkMode ? .white : .black)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskTitle.isEmpty) // Disable button if title is empty
            .opacity(taskTitle.isEmpty ? 0.5 : 1) // Adjust opacity when button is disabled
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay{
            // Date Picker Overlay
            ZStack {
                if showDatePicker{
                    Rectangle()
                        .fill(.ultraThinMaterial) // Background material for the date picker
                        .ignoresSafeArea(edges: .all)
                        .onTapGesture {
                            showDatePicker = false // Dismiss the date picker when tapped outside
                        }
                    
                    DatePicker("", selection: $taskDeadLine, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical) // Graphical date picker style
                        .labelsHidden()
                        .padding()
                        .foregroundColor(isDarkMode ? .white : .black)
                        .background(isDarkMode ? .black : .white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: showDatePicker) // Smooth animation for date picker
        }
    }
}


#Preview {
    AddNewTask(taskModel: TaskViewModel(), isDarkMode: .constant(false))
}
