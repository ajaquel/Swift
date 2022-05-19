//
//  ImageModel.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

class LoginModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""
    @Published var isLoggingIn = false

    func login() {
        isLoggingIn = true
    }

}

