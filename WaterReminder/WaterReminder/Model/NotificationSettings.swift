//
//  NotificationSettings.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 1.12.21.
//
import UIKit
import Foundation

class Notification {
    
    let notificationContent = UNUserNotificationCenter.current()
    public typealias PermissionRequest = (_ userPermission: Bool) -> ()
    
    func setPermission(completion: @escaping PermissionRequest)  {
        notificationContent.getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success, deniedPermission) in
                    guard success != nil else { completion(false); return}
                    self.scheduleLocalNotification()
                    completion(true)
                })
            case .authorized:
                completion(true)
                self.scheduleLocalNotification()
            case .denied:
                completion(false)
                print("Application Not Allowed to Display Notifications")
            case .provisional:
                print("Unknown case")
            case .ephemeral:
                print("Unknown case")
            @unknown default:
                print("Default case")
            }
        }

    }
    
    private func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "Are you there?"
        content.body = "This Is your body speaking. Don't forget to drink water or something like this!"

        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: content, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool?, _ deniedPermission: Bool?) -> ()) {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if success {
                completionHandler(true, nil)
            } else {
                completionHandler(nil, true)
            }
        }
    }
    
    func dismissNotifications() {
        notificationContent.removeAllPendingNotificationRequests()
    }
}
