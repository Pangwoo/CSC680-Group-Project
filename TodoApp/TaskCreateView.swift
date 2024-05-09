import SwiftUI

struct TaskCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = 1
    @State private var selectedCategory: TaskCategory = .assignments

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            Stepper("Priority: \(priority)", value: $priority, in: 1...5)
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(TaskCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }

            Button("Add Task") {
                viewModel.addTask(title: title, description: description, dueDate: dueDate, priority: priority, category: selectedCategory.rawValue)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Create Task")
    }
}
