//
//  ContentView.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = Tabs.prospects
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProspectsView(filter: .none)
                .tag(Tabs.prospects)
                .tabItem { Label("Everyone", systemImage: "person.3") }
            ProspectsView(filter: .contacted)
                .tag(Tabs.contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }
            ProspectsView(filter: .uncontacted)
                .tag(Tabs.uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }
            MeView()
                .tag(Tabs.me)
                .tabItem { Label("Me", systemImage: "person.crop.square") }
        }
    }
}

extension ContentView {
    enum Tabs {
        case prospects, contacted, uncontacted, me
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
