//
//  CompletedTaskView.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/9/24.
//

import SwiftUI

struct CompletedTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.completedTasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        Text("Due: \(task.dueDate, style: .date) \(task.dueDate, style: .time)")
                        Text("Priority: \(task.priority)")
                    }
                }
                .onDelete { offsets in
                    offsets.map { viewModel.completedTasks[$0].id }.forEach(viewModel.removeTask)
                }
            }
            .navigationTitle("Completed Tasks")
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


