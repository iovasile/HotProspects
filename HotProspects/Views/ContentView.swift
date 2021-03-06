//
//  ContentView.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var prospects = Prospects()
    let notificationService = NotificationService()
    
    var body: some View {
        TabView() {
            ProspectsView(filter: .none)
                .tabItem { Label("Everyone", systemImage: "person.3") }
            ProspectsView(filter: .contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }
            ProspectsView(filter: .uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }
            MeView()
                .tabItem { Label("Me", systemImage: "person.crop.square") }
        }
        .environmentObject(prospects)
        .environmentObject(notificationService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
