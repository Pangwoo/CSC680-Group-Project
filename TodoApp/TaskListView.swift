import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State private var selectedCategory: TaskCategory?
    @State private var showingCompletedTasks = false

    var body: some View {
        NavigationView {
            VStack {
                // Category button section
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

                // Sort button section
                HStack {
                    sortButton(for: .dueDate, label: "Due Date")
                    sortButton(for: .addedDate, label: "Added Date")
                    sortButton(for: .priority, label: "Priority")
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

                // Show selected category title
                Text(displayTitle)
                    .font(.title)
                    .padding(.bottom, 5)

                // Task list section
                List {
                    ForEach(filteredTasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.updateTaskStatus(id: task.id, isCompleted: !task.isCompleted)
                                }
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .padding(.trailing, 8)

                            NavigationLink(destination: TaskDetailView(task: task)) {
                                VStack(alignment: .leading) {
                                    Text(task.title).font(.headline)
                                    Text("Due: \(task.dueDate, style: .date)")
                                    Text("Priority: \(task.priority)")
                                }
                            }

                            Spacer()
                        }
                        .swipeActions {
                            Button("Complete") {
                                viewModel.completeTask(id: task.id)
                            }
                            .tint(.green)
                            
                            Button(role: .destructive) {
                                viewModel.removeTask(id: task.id)
                            } label: {
                                Text("Delete")
                            }
                        }
                    }
                }
            }
            .navigationTitle("To Do Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Completed Tasks") {
                        showingCompletedTasks = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add Task", destination: TaskCreateView(viewModel: viewModel))
                }
            }
            .sheet(isPresented: $showingCompletedTasks) {
                CompletedTaskView(viewModel: viewModel)
            }
        }
    }

    // Function to create a category button
    private func categoryButton(for category: TaskCategory?, icon: String, label: String) -> some View {
        Button(action: {
            selectedCategory = category
        }) {
            VStack {
                Image(systemName: icon).padding(2)
            }
            .padding()
            .foregroundColor(selectedCategory == category ? .blue : .primary)
            .background(selectedCategory == category ? Color(UIColor.systemBlue.withAlphaComponent(0.1)) : Color.clear)
            .cornerRadius(8)
        }
    }

    // Function to create a sort button
    private func sortButton(for criteria: TaskViewModel.SortCriteria, label: String) -> some View {
        Button(action: {
            viewModel.setSortCriteria(criteria)
        }) {
            Text(label)
                .padding()
                .foregroundColor(viewModel.sortCriteria == criteria ? .blue : .primary)
                .background(viewModel.sortCriteria == criteria ? Color(UIColor.systemBlue.withAlphaComponent(0.1)) : Color.clear)
                .cornerRadius(8)
        }
    }

    // Display the title based on the selected category
    private var displayTitle: String {
        guard let category = selectedCategory else {
            return "All"
        }
        return "\(category.rawValue)"
    }

    // Return a list of filtered tasks
    private var filteredTasks: [Task] {
        guard let selectedCategory = selectedCategory else {
            return viewModel.tasks
        }
        return viewModel.tasks.filter { $0.category == selectedCategory }
    }
}

#Preview {
    TaskListView()
}
