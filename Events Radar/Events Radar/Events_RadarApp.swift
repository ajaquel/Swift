//
//  Events_RadarApp.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI
import CloudKit

@main
struct Events_RadarApp: App {
    
    let container = CKContainer(identifier: "iCloud.eventlist")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer) // This section helps with the automatic dismissal of the keyboard when screen is tapped.
                .environmentObject(ViewModel()) // This helps with the pictures taking/handling feature
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintsBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
