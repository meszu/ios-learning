//
//  TAB.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 12. 12..
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems = [
    TabItem(name: "Home", icon: "house", color: .teal, selection: .home),
    TabItem(name: "Explore", icon: "magnifyingglass", color: .blue, selection: .explore),
    TabItem(name: "Notifications", icon: "bell", color: .red, selection: .notifications),
    TabItem(name: "Friends", icon: "person.3", color: .pink, selection: .friends)
]

enum Tab: String {
    case home
    case explore
    case notifications
    case friends
}
