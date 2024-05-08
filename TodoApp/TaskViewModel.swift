//
//  TaskViewModel.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/7/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(title: String, description: String, dueDate: Date, priority: Int, category: String) {
        
        let categoryEnum = TaskCategory(rawValue: category) ?? .others
        let newTask = Task(title: title, description: description, dueDate: dueDate, priority: priority, category: categoryEnum)
        tasks.append(newTask)
    }

    func updateTaskStatus(id: UUID, isCompleted: Bool) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted = isCompleted
        }
    }

    func removeTask(id: UUID) {
        tasks.removeAll { $0.id == id }
    }

    func getSortedTasks(by priority: Bool) -> [Task] {
        return priority ? tasks.sorted(by: { $0.priority > $1.priority }) : tasks
    }
}

