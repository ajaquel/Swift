//
//  My_DateApp.swift
//  My Date WatchKit Extension
//
//  Created by Alejandro on 5/9/22.
//

import SwiftUI

@main
struct My_DateApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
