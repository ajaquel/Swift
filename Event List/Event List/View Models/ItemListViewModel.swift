//
//  ItemListViewModel.swift
//  Event List
//
//  Created by Alejandro on 4/25/22.
//

import Foundation
import CloudKit

enum RecordType: String {
    case itemListing = "ItemListing"
}

class ItemListViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var items: [ItemViewModel] = []
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func deleteItem(_ recordId: CKRecord.ID) {
        
        database.delete(withRecordID: recordId) {  deleteRecordId, error in
            if let error = error {
                print(error)
            } else {
                self.populateItems()
            }
        }
    }
    
    func saveItem(title: String, price: Decimal) {
        
        let record = CKRecord(recordType: RecordType.itemListing.rawValue)
        let itemListing = ItemListing(title: title, price: price)
        record.setValuesForKeys(itemListing.toDictionary())
        
        // Saving Record in Database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let newRecord = newRecord {
                    if let itemListing = ItemListing.fromRecord(newRecord) {
                        DispatchQueue.main.async {
                            self.items.append(ItemViewModel(itemListing: itemListing))
                        }
                    }
                }
            }
        }
    }

    func populateItems() {
        
        var items: [ItemListing] = []
        
        let query = CKQuery(recordType: RecordType.itemListing.rawValue, predicate: NSPredicate(value: true))
        
        database.fetch(withQuery: query) { result in
            switch result {
                case .success(let result):
                    result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                            case .success(let record):
                                if let itemListing = ItemListing.fromRecord(record) {
                                    items.append(itemListing)
                                }
                            case .failure(let error):
                                print(error)
                        }
                    }
                
                    DispatchQueue.main.async {
                        self.items = items.map(ItemViewModel.init)
                    }

                case .failure(let error):
                    print(error)
            }
        }
    }
}

struct ItemViewModel {
        
    let itemListing: ItemListing
        
    var recordId: CKRecord.ID? {
        itemListing.recordId
    }
        
    var title:String {
        itemListing.title
    }
        
    var price: Decimal {
        itemListing.price
    }

}
