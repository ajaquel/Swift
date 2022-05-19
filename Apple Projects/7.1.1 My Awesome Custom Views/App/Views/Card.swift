//
//  Card.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct Card: ViewModifier {

    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .cornerRadius(cornerRadius)
            .shadow(color: Color.primary.opacity(0.2),
                    radius: 4)
    }

}

extension View {

    func card(cornerRadius: CGFloat = 8) -> some View {
        modifier(Card(cornerRadius: cornerRadius))
    }

}
