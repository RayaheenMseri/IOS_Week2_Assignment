//
//  TaskDetailsView.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//


import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject var details: Task  // Observes the Task object to reflect changes
    @Environment(\.dismiss) private var dismiss  // Provides functionality to dismiss the view
    @ObservedObject var taskModel: TaskViewModel  // Observes the task model for any updates
    @Binding var isDarkMode: Bool  // Binding to dark mode state
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20){  // Vertical stack to arrange the view elements
            
            // Task Type with background color from taskColor
            HStack{
                Spacer()  // Align the content in the center
                ZStack{
                    Rectangle()
                        .cornerRadius(50)  // Rounded corners
                        .foregroundColor(details.taskColor)  // Background color based on task's color
                        .frame(width: 130, height: 50)  // Set frame for the color box
                    Text("\(details.taskType)")  // Display task type in the box
                        .font(.callout.bold())
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background{
                            Capsule()  // Capsule shape background for text
                                .fill(.white.opacity(0.2))
                        }
                }
            }
            
            // Task Image centered with spacing
            HStack {
                Spacer()  // Push the image to center
                Image(systemName: "list.bullet.rectangle")  // Icon representing the task list
                    .resizable()
                    .frame(width: 80, height: 80)  // Set size for the icon
                    .padding()
                Spacer()  // Keeps the image centered by adding space on both sides
            }
            
            // Task Title
            Text("Task Title :")
                .font(.headline)
            Text(details.title)  // Display task title from details
            
            Divider()  // Divider line between sections
                .background(Color.customColor)  // Custom color for the divider
            
            // Task Date and Time with icons
            HStack{
                Image(systemName: "calendar")  // Calendar icon for the task date
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.horizontal,5)
                VStack(alignment: .leading){
                    Text("Task Date")  // Label for task date
                        .font(.headline)
                    Text(details.taskDeadLine.formatted(date: .abbreviated, time: .omitted))  // Formatted task deadline
                }
                Spacer()
                
                Image(systemName: "clock")  // Clock icon for the task time
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.horizontal,5)
                VStack(alignment: .leading){
                    Text("Task Time")  // Label for task time
                        .font(.headline)
                    Text(details.taskDeadLine.formatted(date: .omitted, time: .shortened))  // Shortened task time
                }
            }
            .padding(.horizontal)
            
            Divider()  // Divider line for task status section
                .background(Color.customColor)
            
            // Task Status
            Text("Task Status :")
                .font(.headline)
            Text(details.isCompleted ? "Completed" : "Not Completed")  // Show status text based on task completion
                .padding()
                .font(.callout.bold())  // Bold callout font
                .foregroundColor(details.isCompleted ? .green : .red)  // Green if completed, red if not
                .background{
                    Capsule()  // Capsule background with color based on completion status
                        .fill(details.isCompleted ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                }
                .frame(alignment: .center)  // Center the status text within the capsule
            
            Spacer()  // Adds extra space at the bottom
        }.padding()  // Add padding to the entire VStack
    }
}



#Preview {
    TaskDetailsView(details:Task(title: "Submit Project Report", taskColor: .purple, taskDeadLine: Date().addingTimeInterval(18000), taskType: .Basic, isCompleted: false), taskModel: TaskViewModel(), isDarkMode: .constant(false))
}

