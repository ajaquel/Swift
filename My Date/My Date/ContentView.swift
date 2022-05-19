//
//  ContentView.swift
//  My Date
//
//  Created by Alejandro on 5/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var date = Date()
    
    var body: some View {
        

        
        VStack {
            Spacer()
            Text(Date.now, format: .dateTime.weekday(.wide))
                .font(.system(size: 60, weight: .bold, design: .default))
//                .padding(.all, 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .minimumScaleFactor(0.7)
            Spacer()
            Text(Date.now, format: .dateTime.day().month(.wide).year())
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .minimumScaleFactor(0.7)
//                    .padding(.all, 5)
            Text("\(timeString(date: date))")
//            Text(Date.now, format: .dateTime.hour(.twoDigits(amPM: .wide)).minute(.twoDigits).second(.twoDigits))
                .onAppear(perform: {let _ = self.updateTimer})
                .font(.system(size: 30, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .center)
                .minimumScaleFactor(0.7)
//                .padding(.all, 5)
            Spacer()
            Text(Date.now, format: .dateTime.timeZone(.genericName(.long)))
            .font(.system(size: 28, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, alignment: .center)
            .minimumScaleFactor(0.7)
//            .padding(.top)
            
            Text(Date.now, format: .dateTime.timeZone(.localizedGMT(.long)))
            .font(.system(size: 28, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, alignment: .center)
            .minimumScaleFactor(0.7)
//            .padding(.top)
            Spacer()
//            Divider()
            
            


//            Text("Under the Divider")
//            Text("\(date)")
//            Text("\(timeString(date: date))")
//            Text("\(timeString(date: date))")
//            .onAppear(perform: {let _ = self.updateTimer})
            
//            Spacer()
        }
    
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }
    
    func timeString(date: Date) -> String {
         let time = timeFormat.string(from: date)
         return time
    }
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.date = Date() })
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
