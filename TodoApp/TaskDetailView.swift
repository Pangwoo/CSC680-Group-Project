//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/9/24.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle) // Sets the title font to large
                .padding()
            Text(task.description)
                .font(.body) // Sets the description font to body
                .padding()
            Text("Due: \(task.dueDate, style: .date) \(task.dueDate, style: .time)") // Displays the due date
                .font(.headline) // Sets the due date font to headline
                .padding()
            HStack {
                Text("Completed: ") // Label for completion status
                    .font(.headline) // Sets the label font to headline
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle") // Shows an icon based on completion status
            }
            .padding()
            Text("Category: \(task.category.rawValue)") // Displays the category of the task
                .font(.subheadline) // Sets the category font to subheadline
                .padding()
            Spacer()
        }
        .navigationBarTitle("Task Details", displayMode: .inline) // Sets the navigation bar title
        .padding()
    }
}

