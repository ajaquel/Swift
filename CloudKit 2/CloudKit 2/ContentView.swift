//
//  CloudKitCrud.swift
//  CloudKit 1
//
//  Created by Alejandro on 5/3/22.
//

import SwiftUI
import CloudKit

class CloudKitCrudViewModel: ObservableObject {
    
    @Published var text: String = ""
    
    func addButtonPressed() {
        guard !text.isEmpty else { return }
        addItem(name: text)
    }
    
    private func addItem(name: String) {
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = name
        saveItem(record: newFruit)
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
        }
    }
}
struct CloudKitCrud: View {
    
    @StateObject private var vm = CloudKitCrudViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                textField
                addButton
                
                List {
                    Text("Hi")
                
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CloudKitCrud_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCrud()
    }
}

extension CloudKitCrud {
    
    private var header: some View {
        Text("CloudKit CRUD")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Add Something Here...", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View {
        Button {
            vm.addButtonPressed()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
}
