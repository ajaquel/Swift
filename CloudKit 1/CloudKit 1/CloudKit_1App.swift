//
//  CloudKit_1App.swift
//  CloudKit 1
//
//  Created by Alejandro on 5/2/22.
//

import SwiftUI

@main
struct CloudKit_1App: App {
    
//    let currentUserIsSignedIn = Bool.self
//
//    init() {
//        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("iCloud.CLoudKit-1") ? true : false
//        self.currentUserIsSignedIn = userIsSignedIn
//    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            CloudKitCrud()
            CloudKitPushNotification()
        }
    }
}
