//
//  CloudKitCrud.swift
//  CloudKit 1
//
//  Created by Alejandro on 5/3/22.
//

import SwiftUI
import CloudKit

struct FruitModel: Hashable {
    let name: String
    let imageURL: URL?
    let record: CKRecord
}

class CloudKitCrudViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var fruits: [FruitModel] = []
    
    init() {
        fetchItems()
    }
    
    func addButtonPressed() {
        guard !text.isEmpty else { return }
        addItem(name: text)
    }
    
    private func addItem(name: String) {
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = name
        
        guard let image = UIImage(named: "therock"),
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("therock.jpeg"),
        let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newFruit["image"] = asset
            saveItem(record: newFruit)
        } catch let error {
            print(error)
        }
        
        
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            if returnedRecord != nil {
                print("Record: \(String(describing: returnedRecord))")
            } else {
                print("Error: \(String(describing: returnedError))")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.text = ""
                self?.fetchItems()
                print("Item Saved!")
            }
        }
    }
    
    
    func fetchItems() {
        
        let predicate = NSPredicate(value: true)
//        let predicate = NSPredicate(format: "name = %@", argumentArray: ["Apple"]) //Filter for the Query
        let query = CKQuery(recordType: "Fruits", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)] //Sorting the Query
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 100 //Records displayed in the List (Max=100)
        
        var returnedItems: [FruitModel] = []
        
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let name = record["name"] as? String else {return }
                let imageAsset = record["image"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                print("Record: ", record)
                returnedItems.append(FruitModel(name: name, imageURL: imageURL, record: record))
//                record.creationDate
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Results?: \(returnedResult)")
            DispatchQueue.main.async {
                self?.fruits = returnedItems
            }
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func updateItem(fruit: FruitModel) {
        let record = fruit.record
        record["name"] = "New Name"
        saveItem(record: record)
        print("Item '\(fruit.name)' Updated!")
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = fruits[index]
        let record = fruit.record
        print("Item '\(fruit.name)' Deleted!")
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self.fruits.remove(at: index)
            }
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
                    ForEach(vm.fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name)
                            if let url = fruit.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .onTapGesture {
                            vm.updateItem(fruit: fruit)
                        }
                    }
                    .onDelete(perform: vm.deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        vm.fetchItems()
                        print("List Refreshed!")
                    }
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
