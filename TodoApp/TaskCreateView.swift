import SwiftUI

struct TaskCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = 1
    @State private var selectedCategory: TaskCategory = .assignments
    @State private var enableNotification = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    TextField("Description", text: $description).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute]).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    Stepper("Priority: \(priority)", value: $priority, in: 1...5).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TaskCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }.padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    
                    Toggle("Enable Notification", isOn: $enableNotification).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                }

                Section {
                    Button("Add Task") {
                        viewModel.addTask(title: title, description: description, dueDate: dueDate, priority: priority, category: selectedCategory.rawValue, enableNotification: enableNotification)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("") // Empty title here
            .toolbar {
                ToolbarItem(placement: .principal) { // Custom view in the navigation bar
                    VStack {
                        Text("Create Task")
                            .font(.largeTitle) // Large custom font size
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct TaskCreateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreateView(viewModel: TaskViewModel())
    }
}



#Preview {
    TaskListView()
}
