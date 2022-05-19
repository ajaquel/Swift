//
//  ViewProvider.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct ViewProvider: LibraryContentProvider {

    @LibraryContentBuilder var views: [LibraryItem] {
        LibraryItem(Row(title: "", subtitle: "", image: Image("")), category: LibraryItem.Category.control)
        LibraryItem(AppButton(Text(""), action: {}))
    }

    func modifiers<V: View>(base: V) -> [LibraryItem] {
        [
            LibraryItem(base.card(cornerRadius: 8)),
            LibraryItem(base.loading(true))
        ]
    }

}

struct ImageView: View {

    let image: Image

    var body: some View {
        image
    }

}
