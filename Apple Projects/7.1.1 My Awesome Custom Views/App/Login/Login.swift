//
//  ImageList.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct Login: View {

    @ObservedObject var model: LoginModel

    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $model.username)
                .padding(8)
                .card()

            SecureField("Password", text: $model.password)
                .padding(8)
                .card()

            AppButton(Text("Login").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/),
                      action: model.login,
                      isExecuting: model.isLoggingIn)
        }
        .padding(32)
        .card()
        .padding(32)
    }

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(model: .init())
            .preferredColorScheme(.dark)
    }
}
