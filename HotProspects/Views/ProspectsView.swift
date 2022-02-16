//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    @EnvironmentObject var notificationService: NotificationService
    @EnvironmentObject var prospects: Prospects
    
    let filter: FilterType
    @State private var isSorting = false
    @State private var isShowingScanner = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(prospect.name)
                                    .font(.headline)
                                
                            }
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if (filter == .none && prospect.isContacted) {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .foregroundColor(.secondary)
                        }
                    }
                   
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                notificationService.addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                    
                    Button {
                        isSorting = true
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "AIonut Vasileeee\nemail@iovasile.dev", completion: handleScan)
            }
            .confirmationDialog("Sort prospects", isPresented: $isSorting) {
                Button("Sort by name") { prospects.sort(by: .name) }
                
                Button("Sort by most recent") { prospects.sort(by: .mostRecent) }
            }
        }
    }
     
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
            case .success(let result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 2 else { return }
                
                let prospect = Prospect()
                prospect.name = details[0]
                prospect.emailAddress = details[1]
                prospects.add(prospect)
            case .failure(let error):
                print(error.localizedDescription)
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
    
    var filteredProspects: [Prospect] {
        switch filter {
            case .none:
                return prospects.people.filter { _ in true }
            case .contacted:
                return prospects.people.filter { $0.isContacted }
            case .uncontacted:
                return prospects.people.filter { !$0.isContacted }
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
            .environmentObject(Prospects())
    }
}
