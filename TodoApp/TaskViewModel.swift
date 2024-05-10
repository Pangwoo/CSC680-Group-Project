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
    @Published var sortCriteria: SortCriteria = .addedDate
    
    enum SortCriteria {
            case dueDate, addedDate, priority
        }

    func addTask(title: String, description: String, dueDate: Date, priority: Int, category: String, enableNotification: Bool) {
        let categoryEnum = TaskCategory(rawValue: category) ?? .others
        let newTask = Task(title: title, description: description, dueDate: dueDate, priority: priority, category: categoryEnum)
        tasks.append(newTask)
        sortTasks()
        if enableNotification {
            NotificationManager.instance.scheduleNotification(task: newTask)
        }
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
    
    func completeTask(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            let completedTask = tasks.remove(at: index)
            completedTasks.append(completedTask)
        }
    }
    
    func sortTasks() {
        switch sortCriteria {
        case .dueDate:
            tasks.sort { $0.dueDate < $1.dueDate }
        case .addedDate:
            tasks.sort { $0.addedDate < $1.addedDate }
        case .priority:
            tasks.sort { $0.priority > $1.priority }
        }
    }
    
    func setSortCriteria(_ criteria: SortCriteria) {
            sortCriteria = criteria
            sortTasks()
        }
}

