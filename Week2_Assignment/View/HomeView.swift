//
//  ContentView.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 13/09/1446 AH.
//


import SwiftUI

// HomeView is the main view of the task manager app
struct HomeView: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()  // Task view model to manage tasks
    @Namespace var animation  // Used for smooth animations between views
    @State private var isDarkMode = false  // State to toggle between light and dark mode
    
    var body: some View {
        NavigationStack {  // Navigation container for pushing views
            GeometryReader { geometry in  // To adapt layout to screen size
                ScrollView(.vertical, showsIndicators: false) {  // Vertical scroll view without scroll indicators
                    VStack {
                        Text("Task Manager")  // Title of the app
                            .font(.title2.bold())
                        
                        // Header for "TO DO LIST"
                        HStack {
                            Text("TO DO LIST")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical)
                            Spacer()
                            DarkModeToggle(isDarkMode: $isDarkMode)  // Dark mode toggle
                        }
                        
                        // Segmented bar and sort button
                        HStack {
                            CustomSegmentedBar(taskModel: taskModel, animation: animation, isDarkMode: $isDarkMode)
                                .padding(.top, 5)
                            
                            Text("↑↓")  // Button to sort tasks
                                .onTapGesture {
                                    taskModel.tasks = taskModel.sortTasks()  // Sort tasks
                                }
                        }
                    }
                    .padding()
                    
                    // Define grid layout to adapt to screen size
                    let columns: [GridItem] = [
                        GridItem(.adaptive(minimum: geometry.size.width * 0.9))  // 90% of screen width
                    ]
                    
                    // Filter tasks based on the current tab
                    let filteredTasks = getFilteredTasks(for: taskModel.currentTab)
                    
                    // LazyVGrid to display tasks in a flexible grid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredTasks) { task in
                            TaskRow(task: task, taskModel: taskModel, isDarkMode: $isDarkMode)
                                .padding(.horizontal)
                                .transition(.move(edge: .top))  // Smooth transition when tasks appear
                        }
                    }
                    .padding(.bottom, 60)  // Extra space at the bottom for button
                }
                .overlay(alignment: .bottom) {
                    // Add Task button at the bottom of the screen
                    Button {
                        taskModel.openAddTask.toggle()  // Open Add Task view
                    } label: {
                        Label {
                            Text("Add Task")
                                .font(.callout)
                                .fontWeight(.semibold)
                        } icon: {
                            Image(systemName: "plus.app.fill")
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(.black, in: Capsule())  // Rounded button with background
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                    .background {
                        // Gradient background for button area
                        LinearGradient(
                            colors: [.white.opacity(0.05), .white.opacity(0.4), .white.opacity(0.7)],
                            startPoint: .top, endPoint: .bottom
                        )
                        .ignoresSafeArea()
                    }
                }
                .fullScreenCover(isPresented: $taskModel.openAddTask) {
                    // Full screen cover for adding a new task
                    AddNewTask(taskModel: taskModel, isDarkMode: $isDarkMode)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)  // Toggle between light and dark mode
        }
    }
    
    // Filter tasks based on the selected tab (Today, Upcoming, Done)
    private func getFilteredTasks(for tab: String) -> [Task] {
        switch tab {
        case "Today":
            return taskModel.tasks.filter { task in
                let calendar = Calendar.current
                return calendar.isDateInToday(task.taskDeadLine) && !task.isCompleted
            }
        case "Upcoming":
            return taskModel.tasks.filter { task in
                let calendar = Calendar.current
                return task.taskDeadLine > Date() && !calendar.isDateInToday(task.taskDeadLine)
            }
        case "Done":
            return taskModel.tasks.filter { $0.isCompleted }
        default:
            return taskModel.tasks
        }
    }
}

#Preview {
    HomeView()
}
