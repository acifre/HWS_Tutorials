//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/16/23.
//

import CodeScanner
import UserNotifications
import SwiftUI

struct ProspectsView: View {


    @EnvironmentObject var prospects: Prospects

    @State private var isShowingScanner = false
    @State private var isShowingSort = false



    let filterType: FilterType


    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPeople) { person in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(person.name)
                                .font(.headline)
                            Text(person.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if filterType == .none {
                            Image(systemName: person.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
                                .foregroundStyle(person.isContacted ? .green : .secondary)
                        }

                    }
                    .swipeActions {
                        if person.isContacted {
                            Button {
                                prospects.toggle(person)
                            } label: {
                                Label("Uncontact", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(person)
                            } label: {
                                Label("Contact", systemImage: "person.crop.circle.badge.checkmark")
                            }
                            .tint(.green)
                        }

                        Button {
                            addNotification(for: person)
                        } label: {
                            Label("Remind", systemImage: "bell")
                        }
                        .tint(.orange)
                    

                    }
                }
            }
                .navigationBarTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingScanner = true
                        } label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isShowingSort = true
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Anthony Cifre\nanthonybcifre@gmail.com", completion: handleScan)
                }
                .confirmationDialog("Sort by", isPresented: $isShowingSort, titleVisibility: .visible) {
                    Button("Name") {
                        prospects.sortBy = .name
                    }
                    Button("Most Recent") {
                        prospects.sortBy = .dateAdded
                    }
                }
        

        }
    }

    var filteredPeople: [Prospect] {
        var sortedPeople: [Prospect] {
            switch prospects.sortBy {
            case .name:
                return prospects.people.sorted { $0.name < $1.name }
            case .dateAdded:
                return prospects.people.sorted { $0.dateAdded > $1.dateAdded }
            }
        
        }

        switch filterType {
        case .none:
            return sortedPeople

        case .contacted:
            return sortedPeople.filter { $0.isContacted }
        case .uncontacted:
            return sortedPeople.filter { !$0.isContacted }
        }
    }

    var title: String {
        switch filterType {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)

        case .failure(let error):
            print("Scanning failed \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }






}

//#Preview {
//    ProspectsView()
//}
