//
//  MyImage.swift
//  Events Radar
//
//  Created by Alejandro on 5/6/22.
//

import Foundation
import UIKit

struct MyImage: Identifiable, Codable {
    var id = UUID()
    var name: String
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo")!
        }
    }
}
