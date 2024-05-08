//
//  ContentView.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/7/24.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State private var selectedCategory: TaskCategory?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    categoryButton(for: nil, icon: "tray.full", label: "All")
                    categoryButton(for: .assignments, icon: "books.vertical", label: "Assignments")
                    categoryButton(for: .personal, icon: "person.crop.circle", label: "Personal")
                    categoryButton(for: .family, icon: "house.fill", label: "Family")
                    categoryButton(for: .others, icon: "ellipsis", label: "Others")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding([.horizontal, .top])

                // show the title for chosen category
                Text(displayTitle)
                    .font(.title)
                    .padding(.bottom, 5)

                List {
                    ForEach(filteredTasks) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                Text("Due: \(task.dueDate, style: .date)")
                                Text("Priority: \(task.priority)")
                            }
                            Spacer()
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.updateTaskStatus(id: task.id, isCompleted: !task.isCompleted)
                                }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("To Do Lists")
            .navigationBarItems(trailing:
                NavigationLink("Add Task", destination: TaskCreateView(viewModel: viewModel))
            )
        }
    }

    // function for creating category button
    private func categoryButton(for category: TaskCategory?, icon: String, label: String) -> some View {
        Button(action: {
            selectedCategory = category
        }) {
            VStack {
                Image(systemName: icon)
                    .padding(2)
            }
            .padding()
            .foregroundColor(selectedCategory == category ? .blue : .primary)
            .background(selectedCategory == category ? Color(UIColor.systemBlue.withAlphaComponent(0.1)) : Color.clear)
            .cornerRadius(8)
        }
    }

    // display title based on the selected category
    private var displayTitle: String {
        guard let category = selectedCategory else {
            return "All"
        }
        return "\(category.rawValue)"
    }

    // show filtered lists
    private var filteredTasks: [Task] {
        guard let selectedCategory = selectedCategory else {
            return viewModel.tasks
        }
        return viewModel.tasks.filter { $0.category == selectedCategory }
    }

    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let taskId = filteredTasks[index].id
            viewModel.removeTask(id: taskId)
        }
    }
}





#Preview {
    TaskListView()
}
