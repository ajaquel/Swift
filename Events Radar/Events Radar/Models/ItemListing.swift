//
//  ItemListing.swift
//  Event List
//
//  Created by Alejandro on 4/25/22.
//

import Foundation
import CloudKit

struct ItemListing {
    
    var recordId: CKRecord.ID?
    let title: String
    let type: String
    let description: String
//    let date: Date
    let price: Decimal
    
    init(
        recordId: CKRecord.ID? = nil,
        title: String,
        type: String,
        description: String,
//        date: Date,
        price: Decimal
    ) {
        self.title = title
        self.type = type
        self.description = description
//        self.date = date
        self.price = price
        self.recordId = recordId
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "type": type,
            "description": description,
//            "date": date,
            "price": price
        ]
    }
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        
        guard let title = record.value(forKey: "title") as? String,
              let type = record.value(forKey: "type") as? String,
              let description = record.value(forKey: "description") as? String,
//              let date = record.value(forKey: "date") as? Date,
              let price = record.value(forKey: "price") as? Double else {
            return nil
        }
        
        return ItemListing(
            recordId: record.recordID,
            title: title,
            type: type,
            description: description,
//            date: date,
            price: Decimal(price)
        )
    }
    
}

