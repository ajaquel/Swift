//
//  Buttonlabel.swift
//  Events Radar
//
//  Created by Alejandro on 5/6/22.
//

import SwiftUI

struct ButtonLabel: View {
    
    let symbolName: String
    let label: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
            Text(label)
        }
        .font(Font.system(size: 18))
//        .padding(10)
        .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
        .foregroundColor(.white)
        .cornerRadius(5)
        .opacity(0.8)

    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(symbolName: "camera", label: "Camera")
    }
}



//struct modifiedButtonStyle: ButtonStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .font(Font.system(size: 18))
//            .foregroundColor(configuration.isPressed ? Color.pink : Color.white)
//            .padding(10)
//            .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
//            .opacity(0.8)
//            .cornerRadius(5)
//    }
//}


