//
//  Task.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/7/24.
//

import Foundation

enum TaskCategory: String, CaseIterable, Codable {
    case assignments = "Assignments"
    case personal = "Personal Tasks"
    case family = "Family"
    case others = "Others"
}

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var priority: Int
    var category: TaskCategory
    var isCompleted: Bool
    let addedDate: Date

    init(title: String, description: String, dueDate: Date, priority: Int, category: TaskCategory, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.priority = priority
        self.category = category
        self.isCompleted = isCompleted
        self.addedDate = Date()
    }
}

