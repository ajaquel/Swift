//
//  ContentView.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI
import CloudKit

struct ContentView: View {
        
    @State private var selection: Tab = .eventsfeatured

    enum Tab {
        case eventsfeatured
        case eventsnew
        case eventslist
        case eventsmap
        case eventssetting
    }

    var body: some View {
        TabView(selection: $selection) {
            
            EventsNewView()
                .tabItem {
                    Label("New Event", systemImage: "plus.circle")
                }
                .tag(Tab.eventsnew)

//            EventsListView()
            EventsListView(vm: ItemListViewModel(container: CKContainer.default()))
                .tabItem {
                    Label("List View", systemImage: "list.bullet")
                }
                .tag(Tab.eventslist)
            
            EventsFeatured()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.eventsfeatured)
            
            EventsMapView()
                .tabItem {
                    Label("Map View", systemImage: "map")
                }
                .tag(Tab.eventsmap)
            
            EventsSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tab.eventssetting)
        }.accentColor(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
