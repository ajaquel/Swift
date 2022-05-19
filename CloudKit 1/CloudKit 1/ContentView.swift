//
//  ContentView.swift
//  CloudKit 1
//
//  Created by Alejandro on 5/2/22.
// https://www.youtube.com/watch?v=tww2vbJjXpA
//

import SwiftUI
import CloudKit

class CloudKitUserBootcampViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                    
                case .available:
                    self?.isSignedInToiCloud = true
                    self?.error = CloudKitError.iCloudAccountSigned.rawValue
                    print("Available")
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFounnd.rawValue
                    print("iCloudAccountNotFounnd")
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                    print("iCloudAccountNotDetermined")
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                    print("iCloudAccountRestricted")
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.iCloudAccountTemporarilyUnavailable.rawValue
                    print("iCloudAccountTemporarilyUnavailable")
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                    print("iCloudAccountUnknown")
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountSigned
        case iCloudAccountNotFounnd
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountTemporarilyUnavailable
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnnedStatus, ReturnedError in
            DispatchQueue.main.async {
                if returnnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var vm = CloudKitUserBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("Is Signed In: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("Name: \(vm.userName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

