//
//  EventsSettingsView.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI

struct EventsSettingsView: View {
    
    @State private var distance: Double = 5
    
    @State private var isEditing: Bool = false
    @State private var isSelected: Bool = false
    
    @State private var isSelectedMusic: Bool = false
    @State private var isSelectedFestival: Bool = false
    @State private var isSelectedSocial: Bool = false
    @State private var isSelectedUnrest: Bool = false
    @State private var isSelectedAccident: Bool = false
    @State private var isSelectedDisaster: Bool = false
    @State private var isSelectedNature: Bool = false
    @State private var isSelectedFood: Bool = false
    @State private var isSelectedPolitical: Bool = false
    @State private var isSelectedExercise: Bool = false
    @State private var isSelectedSale: Bool = false
    @State private var isSelectedOther: Bool = false
    @State private var isSelectedActive: Bool = true
    @State private var isSelectedDone: Bool = false
    
    var body: some View {
        VStack {
            Text("Settings")
                .fontWeight(.thin)
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
                .foregroundColor(.white)

            
            Text("Set up your events filtering preferences.")
                .padding()
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Radius")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            Slider(
                value: $distance,
                in: 1...50,
                step: 1
            )
            {
                Text("Distance")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("50")
            } onEditingChanged: { editing in
                isEditing = editing
            }.tint(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
            .frame(width: 300)
            Text("\(distance, specifier: "%.0f") miles")
                .foregroundColor(isEditing ? .red : Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
            
            Text("Categories")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            
            Group {
                HStack {
                    Toggle(isOn: $isSelectedMusic) { Label(isSelectedMusic ? "Music" : "Music", systemImage: "music.quarternote.3").symbolVariant(isSelectedMusic ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedFestival) { Label(isSelectedFestival ? "Festival" : "Festival", systemImage: "music.mic").symbolVariant(isSelectedFestival ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedSocial) { Label(isSelectedSocial ? "Social" : "Social", systemImage: "person.3").symbolVariant(isSelectedSocial ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedUnrest) { Label(isSelectedUnrest ? "Unrest" : "Unrest", systemImage: "figure.wave").symbolVariant(isSelectedUnrest ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedAccident) { Label(isSelectedAccident ? "Accident" : "Accident", systemImage: "airplane.arrival").symbolVariant(isSelectedAccident ? .fill : .none) }

                    Toggle(isOn: $isSelectedDisaster) { Label(isSelectedDisaster ? "Disaster" : "Disaster", systemImage: "waveform").symbolVariant(isSelectedDisaster ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedNature) { Label(isSelectedNature ? "Nature" : "Nature", systemImage: "globe.americas").symbolVariant(isSelectedNature ? .fill : .none) }
                
                    Toggle(isOn: $isSelectedFood) { Label(isSelectedFood ? "Food" : "Food", systemImage: "cart").symbolVariant(isSelectedFood ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedPolitical) { Label(isSelectedPolitical ? "Political" : "Political", systemImage: "building.columns").symbolVariant(isSelectedPolitical ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedSale) { Label(isSelectedSale ? "Sale" : "Sale", systemImage: "dollarsign.circle").symbolVariant(isSelectedSale ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedExercise) { Label(isSelectedExercise ? "Exercise" : "Exercise", systemImage: "bolt").symbolVariant(isSelectedExercise ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedOther) { Label(isSelectedOther ? "Other" : "Other", systemImage: "infinity").symbolVariant(isSelectedOther ? .fill : .none) }
                }
            }.toggleStyle(.button)
            .tint(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
            
            Text("Status")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Group {
                    Toggle(isOn: $isSelectedActive) { Label(isSelectedActive ? "Current" : "Current", systemImage: "hourglass").symbolVariant(isSelectedActive ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedDone) { Label(isSelectedDone ? "Finished" : "Finished", systemImage: "hourglass.tophalf.filled").symbolVariant(isSelectedDone ? .fill : .none) }
                }
                .toggleStyle(.button)
                .tint(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
            }
            
            Spacer()

        }
    }
    

}

struct EventsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsSettingsView()
    }
}
