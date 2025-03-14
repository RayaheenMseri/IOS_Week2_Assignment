//
//  Task.swift
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 14/09/1446 AH.
//

import SwiftUI

enum TaskType: String, CaseIterable, Identifiable{
    case Basic = "Basic"
    case Important = "Important"
    case Urgent = "Urgent"
    
    var id: String { return self.rawValue }
}

class Task: Identifiable, ObservableObject {
    var id = UUID()
    var title: String = ""
    var taskColor: Color
    var taskDeadLine: Date
    var taskType : TaskType
    var isCompleted: Bool = false
    
    init(title: String, taskColor: Color, taskDeadLine: Date, taskType: TaskType, isCompleted: Bool) {
        self.title = title
        self.taskColor = taskColor
        self.taskDeadLine = taskDeadLine
        self.taskType = taskType
        self.isCompleted = isCompleted
    }
}
