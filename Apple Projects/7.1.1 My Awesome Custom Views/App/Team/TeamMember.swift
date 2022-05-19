//
//  Developer.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

struct TeamMember {

    let name: String
    let image: Image
    let position: String

}

extension TeamMember: Identifiable {
    var id: String {
        name
    }
}

extension TeamMember {
    static let mock: [TeamMember] = [
        TeamMember(name: "Andreas", image: Image("Andreas"), position: "Android Developer"),
        TeamMember(name: "Balazs", image: Image("Balazs"), position: "Android Developer"),
        TeamMember(name: "Frederik", image: Image("Frederik"), position: "Android Developer"),
        TeamMember(name: "Ilia", image: Image("Ilia"), position: "iOS Developer"),
        TeamMember(name: "Josip", image: Image("Josip"), position: "Android Developer"),
        TeamMember(name: "Julian", image: Image("Julian"), position: "iOS Developer"),
        TeamMember(name: "Lilly", image: Image("Lilly"), position: "Marketing"),
        TeamMember(name: "Malte", image: Image("Malte"), position: "Managing Director"),
        TeamMember(name: "Michael", image: Image("Michael"), position: "iOS Developer"),
        TeamMember(name: "Mischa", image: Image("Mischa"), position: "iOS Developer"),
        TeamMember(name: "Nasir", image: Image("Nasir"), position: "iOS Developer"),
        TeamMember(name: "Paul", image: Image("Paul"), position: "iOS Developer"),
        TeamMember(name: "Sebastian", image: Image("Sebastian"), position: "Technical Lead"),
        TeamMember(name: "Stavro", image: Image("Stavro"), position: "Android Developer"),
        TeamMember(name: "Stefan", image: Image("Stefan"), position: "Managing Director"),
    ]
}
