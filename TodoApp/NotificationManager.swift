//
//  NotificationManager.swift
//  TodoApp
//
//  Created by Jooho Chang on 5/10/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() // Singleton for global access

    func requestAuthorization() {
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
                if success {
                    print("Authorization granted.")
                } else if let error = error {
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
        }
    
    func scheduleNotification(task: Task) {
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = "Reminder: \(task.title) is due!"
            content.sound = UNNotificationSound.default

            let targetDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: task.dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
}
