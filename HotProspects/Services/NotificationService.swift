//
//  NotificationService.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import Foundation
import UserNotifications

class NotificationService: ObservableObject {
    let center = UNUserNotificationCenter.current()
    
    func addNotification(for prospect: Prospect) {
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: prospect.id.uuidString, content: content, trigger: trigger)
            self.center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                self.center.requestAuthorization(options: [.sound, .alert, .badge]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("No authorization!")
                    }
                }
            }
        }
    }
}
