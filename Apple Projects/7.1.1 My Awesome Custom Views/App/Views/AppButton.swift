//
//  AppButton.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct AppButton<Label: View>: View {

    var label: Label
    var action: () -> Void
    var isExecuting = false

    init(_ label: Label, action: @escaping () -> Void, isExecuting: Bool = false) {
        self.label = label
        self.action = action
        self.isExecuting = isExecuting
    }

    var body: some View {
        Button(action: action) {
            label
                .foregroundColor(.primary)
                .padding(8)
        }
        .loading(isExecuting)
        .card()
    }

}
