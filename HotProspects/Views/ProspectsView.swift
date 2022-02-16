//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI

struct ProspectsView: View {
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle(title)
        }
    }
    
    var title: String {
        switch filter {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted People"
            case .uncontacted:
                return "Uncontacted People"
        }
    }
}

extension ProspectsView {
    enum FilterType {
        case none, contacted, uncontacted
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
