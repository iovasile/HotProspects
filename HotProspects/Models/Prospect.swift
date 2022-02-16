//
//  Prospect.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    private let localStorage = LocalStorageService()
    @Published private(set) var people: [Prospect]
    
    init() { people = localStorage.loadProspectsData() }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() { localStorage.saveProspectData(people) }
    
    func add(_ prospect: Prospect) {
        objectWillChange.send()
        people.append(prospect)
        save()
    }
}
