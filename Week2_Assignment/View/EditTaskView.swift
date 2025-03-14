//
//  EditTaskView.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//

import SwiftUI

struct EditTaskView: View {
    @ObservedObject var taskModel: TaskViewModel
    @ObservedObject var details: Task // Manage task data
    @Environment(\.dismiss) var dismiss
    @Namespace var animation
    @State var taskTitle: String = "" // Local state for task title
    @State var taskColor: Color = .yellow // Local state for task color
    @State var taskDeadLine: Date = Date() // Local state for task deadline
    @State var taskType: TaskType = .Basic // Local state for task type
    @State var showDatePicker: Bool = false // Control date picker visibility
    @Binding var isDarkMode: Bool // Bind dark mode state

    var body: some View {
        VStack(spacing: 12) {
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        dismiss() // Dismiss view
                    } label: {
                        Image(systemName: "arrow.left.circle") // Back button
                            .font(.title3)
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                }

            // Task color selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
                HStack(spacing: 12) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 25, height: 25)
                            .background {
                                if taskColor == color {
                                    Circle()
                                        .stroke(.gray)
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                taskColor = color // Update selected color
                            }
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)

            Divider()
                .background(Color.customColor)
                .padding(.vertical, 10)

            // Task deadline display and picker button
            VStack(alignment: .leading, spacing: 12) {
                Text("Task DeadLine")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(details.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + details.taskDeadLine.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showDatePicker.toggle() // Toggle date picker visibility
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(isDarkMode ? .white : .black)
                }
            }

            Divider()
                .background(Color.customColor)

            // Task title text field
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)

                TextField("\(details.title)", text: $taskTitle)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .padding(.leading, 10)
                    .background(isDarkMode ? .white.opacity(0.4) : .gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 5)
            }
            .textFieldStyle(.automatic)
            .padding(.top, 10)

            Divider()
                .background(Color.customColor)

            // Task type selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack(spacing: 12) {
                    ForEach(TaskType.allCases) { type in
                        Text(type.rawValue)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskType.rawValue == type.rawValue ? (isDarkMode ? .black : .white) : (isDarkMode ? .white : .black))
                            .background {
                                if taskType.rawValue == type.rawValue {
                                    Capsule()
                                        .fill(isDarkMode ? .white : .black)
                                        .matchedGeometryEffect(id: "Type", in: animation)
                                } else {
                                    Capsule()
                                        .stroke(.black)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation {
                                    taskType = type // Update task type
                                }
                            }
                    }
                }
                .padding(.top, 8)
            }
            .padding(.vertical, 10)

            Divider()
                .background(Color.customColor)

            // Save button
            Button {
                withAnimation(.smooth) {
                    details.title = taskTitle
                    details.taskColor = taskColor
                    details.taskDeadLine = taskDeadLine
                    details.taskType = taskType
                    taskModel.editTask(task: details) // Save task changes
                    dismiss() // Dismiss view
                }
            } label: {
                Text("Save")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(isDarkMode ? .black : .white)
                    .background {
                        Capsule()
                            .fill(isDarkMode ? .white : .black)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskTitle.isEmpty) // Disable save if title is empty
            .opacity(taskTitle.isEmpty ? 0.5 : 1) // Adjust opacity based on title validity
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            taskTitle = details.title
            taskColor = details.taskColor
            taskType = details.taskType
            taskDeadLine = details.taskDeadLine // Initialize state with task details
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea(edges: .all)
                        .onTapGesture {
                            showDatePicker = false // Dismiss date picker on tap outside
                        }

                    DatePicker("", selection: $taskDeadLine, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .foregroundColor(isDarkMode ? .white : .black)
                        .background(isDarkMode ? .black : .white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: showDatePicker) // Animate date picker
        }
    }
}


#Preview {
    EditTaskView(taskModel: TaskViewModel(), details: Task(title: "Submit Project Report", taskColor: .purple, taskDeadLine: Date().addingTimeInterval(18000), taskType: .Important, isCompleted: false), isDarkMode: .constant(false))
}
