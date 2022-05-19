//
//  CloudKitPushNNotification.swift
//  CloudKit 1
//
//  Created by Alejandro on 5/4/22.
//

import SwiftUI
import CloudKit

class CloudKitPushNotificationViewModel: ObservableObject {
    
    func requestNotificationPermissions() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error)
            } else if success {
                print("Notification Permission Success!")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification Permission Failure!")
            }
            
        }
    }
    
    func subscribeToNotifications() {
        
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: "Fruits", predicate: predicate, subscriptionID: "fruit_added_to_database", options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There is a new fruit!"
        notification.alertBody = "Open the App to check updates!"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully Subscribed to Notifications!")
            }
            
        }
        
    }
    
    func unsubscribeToNotifications() {
        
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruit_added_to_database") { returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully Unsubscribed to Notifications!")
            }
            
        }
    }
    
}

struct CloudKitPushNotification: View {
    
    @StateObject private var vm = CloudKitPushNotificationViewModel()
    var body: some View {
        VStack(spacing: 40) {
            
            Button("Request Notifications Permission") {
                vm.requestNotificationPermissions()
                
            }
            
            Button("Subscribbe to Notifications") {
                vm.subscribeToNotifications()
            }
            
            Button("Unsubscribbe to Notifications") {
                vm.unsubscribeToNotifications()
            }
        }
        
    }
}

struct CloudKitPushNNotification_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitPushNotification()
    }
}
