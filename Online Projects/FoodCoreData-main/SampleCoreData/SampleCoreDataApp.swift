//
//  SampleCoreDataApp.swift
//  SampleCoreData
//
//  Created by Alejandro on 05/03/2022.
//

import SwiftUI

@main
struct SampleCoreDataApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
