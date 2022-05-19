//
//  Row.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI


struct Row: View {

    var title: String
    var subtitle: String
    var image: Image

    var body: some View {
        HStack(spacing: 8) {
            image
                .resizable()
                .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)

                Text(subtitle)
                    .opacity(0.5)
            }
            .font(.headline)

            Spacer()
        }
        .padding(8)
    }

}
