//
//  TodoListApplication.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/7/24.
//

import SwiftUI

@main
struct TodoListApplication: App {
    
    init() {
            NotificationManager.instance.requestAuthorization()
        }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
