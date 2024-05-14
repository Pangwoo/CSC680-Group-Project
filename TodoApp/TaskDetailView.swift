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
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.primary)

            Text(task.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)

            Text("Due: \(task.dueDate, style: .date) \(task.dueDate, style: .time)")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(8)

            HStack {
                Text("Completed:")
                    .font(.headline)
                    .foregroundColor(.green)
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .red)
                    .imageScale(.large)
            }
            .padding()
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)

            Text("Category: \(task.category.rawValue)")
                .font(.subheadline)
                .foregroundColor(.purple)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Task Details", displayMode: .inline)
    }
}


#Preview {
    TaskListView()
}
