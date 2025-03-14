//
//  TaskViewModel.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 13/09/1446 AH.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Finish SwiftUI Assignment", taskColor: .blue, taskDeadLine: Date().addingTimeInterval(3600), taskType: .Important, isCompleted: false),
           Task(title: "Buy Groceries", taskColor: .green, taskDeadLine: Date().addingTimeInterval(7200), taskType: .Basic, isCompleted: false),
           Task(title: "Prepare for Meeting", taskColor: .red, taskDeadLine: Date().addingTimeInterval(10800), taskType: .Urgent, isCompleted: false),
           Task(title: "Go to the Gym", taskColor: .orange, taskDeadLine: Date().addingTimeInterval(14400), taskType: .Basic, isCompleted: false),
           Task(title: "Submit Project Report", taskColor: .purple, taskDeadLine: Date().addingTimeInterval(18000), taskType: .Important, isCompleted: false)
    ]
    
    
    @Published var currentTab: String = "Today"
    @Published var openAddTask: Bool = false
    @Published var openEditTask: Bool = false

    // add task
    func addTask(task: Task) {
        tasks.append(task)
        print(tasks.last?.title ?? "No Task Added")
    }
    
    // update completion status
    func updateTaskCompletion(task: Task, isCompleted: Bool) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = isCompleted
            objectWillChange.send()
        }
    }
    
    // edit task
    func editTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    // delete task
    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks.remove(at: index)
        }
    }
    
    // sort task A-Z
    func sortTasks() -> [Task]{
        return tasks.sorted { $0.title < $1.title }
    }

}


