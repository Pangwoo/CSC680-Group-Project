//
//  TaskViewModel.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/7/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var completedTasks: [Task] = []
    @Published var sortOption: SortOption = .none
    
    enum SortOption {
            case none, byDueDate, byPriority
        }

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
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks.remove(at: index)
        }
        if let completedIndex = completedTasks.firstIndex(where: { $0.id == id }) {
            completedTasks.remove(at: completedIndex)
        }
    }

//    func getSortedTasks(by priority: Bool) -> [Task] {
//        return priority ? tasks.sorted(by: { $0.priority > $1.priority }) : tasks
//    }
    
    func completeTask(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            let completedTask = tasks.remove(at: index)
            completedTasks.append(completedTask)
        }
    }
}

