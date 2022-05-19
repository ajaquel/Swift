//
//  DeveloperList.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct TeamList: View {

    @State var developers = TeamMember.mock

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(developers) { developer in
                        TeamMemberCell(teamMember: developer)
                            .padding(4)
                    }
                }
                .padding(8)
            }
            .navigationTitle("Developers")
        }
    }

}

struct TeamMemberCell: View {

    let teamMember: TeamMember

    var body: some View {
        Row(title: teamMember.name, subtitle: teamMember.position, image: teamMember.image)
            .card(cornerRadius: 8)
    }

}


struct TeamList_Previews: PreviewProvider {
    static var previews: some View {
        TeamList()
    }
}
