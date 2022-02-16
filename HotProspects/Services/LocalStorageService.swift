//
//  LocalStorageService.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import Foundation

class LocalStorageService {
    private let prospectsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("prospects")
    
    func loadProspectsData() -> [Prospect] {
        do {
            let data = try Data(contentsOf: prospectsPath)
            let prospects = try JSONDecoder().decode([Prospect].self, from: data)
            return prospects
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveProspectData(_ prospects: [Prospect]) {
        do {
            let data = try JSONEncoder().encode(prospects)
            try data.write(to: prospectsPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save prospects")
        }
    }
}
