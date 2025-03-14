//
//  TaskRow.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//

import SwiftUI

@ViewBuilder
func TaskRow(task: Task, taskModel: TaskViewModel, isDarkMode: Binding<Bool>) -> some View {
    HStack{
        VStack(alignment: .leading, spacing: 10){
            
            // Task Type with capsule background and delete/edit options
            HStack{
                Text("\(task.taskType)")  // Task Type label
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.2))  // Subtle capsule background
                    }
                Spacer()
                
                // Delete button
                Button{
                    withAnimation(.easeInOut){
                        taskModel.deleteTask(task: task)  // Delete task with animation
                    }
                }label:{
                    Image(systemName: "trash")  // Trash icon for deletion
                        .foregroundColor(.black)
                }
                
                // Edit button only if task is not completed
                if !task.isCompleted {
                    NavigationLink {
                        EditTaskView(taskModel: taskModel, details: task, isDarkMode: isDarkMode)  // Navigate to edit view
                    } label: {
                        Image(systemName: "square.and.pencil")  // Pencil icon for editing
                            .foregroundColor(.black)
                    }
                }
            }
            
            // Task Title with navigation link to Task Details
            HStack{
                Text(task.title)  // Task Title
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                Spacer()
                
                // Navigate to Task Details View
                NavigationLink {
                    TaskDetailsView(details: task, taskModel: taskModel, isDarkMode: isDarkMode)
                } label: {
                    Image(systemName: "chevron.right")  // Chevron icon for navigation
                        .foregroundColor(.black)
                }.padding(.trailing, 5)
            }
            
            // Deadline and completion button
            HStack(alignment: .bottom, spacing: 0){
                VStack(alignment: .leading, spacing: 10){
                    Label{
                        Text(task.taskDeadLine.formatted())  // Formatted task deadline
                    } icon: {
                        Image(systemName: "calendar")  // Calendar icon
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Mark task as completed button (only if not completed)
                if !task.isCompleted {
                    Button{
                        taskModel.updateTaskCompletion(task: task, isCompleted: true)  // Mark task as completed
                    } label: {
                        Circle()  // Circle button for completion
                            .strokeBorder(.black, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }
                }
            }

        }
        .padding()  // Padding around the VStack
        .frame(maxWidth: .infinity)  // Ensures the content stretches to fill the width
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)  // Rounded background
                .fill(task.taskColor)  // Background color based on task's color
        }
    }
    .transition(.scale)  // Scale transition for added/removed rows
}
