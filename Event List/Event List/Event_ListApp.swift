//
//  Event_ListApp.swift
//  Event List
//
//  Created by Alejandro on 4/25/22.
//

import SwiftUI
import CloudKit

@main
struct Event_ListApp: App {
    
    let container = CKContainer(identifier: "iCloud.eventlist")
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ItemListViewModel(container: container))
        }
    }
}
