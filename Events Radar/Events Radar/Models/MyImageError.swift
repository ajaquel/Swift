//
//  MyImageError.swift
//  Events Radar
//
//  Created by Alejandro on 5/6/22.
//

import SwiftUI
import CoreData

enum MyImageError: Error, LocalizedError {
    case readError
    case DecodingError
    case encodingError
    case saveError
    case saveImageError
    case readImageError
    
    var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("Could not load MyImage.json.", comment: "")
        case .DecodingError:
            return NSLocalizedString("Could not load Images list.", comment: "")
        case .encodingError:
            return NSLocalizedString("Could not save MyImage data", comment: "")
        case .saveError:
            return NSLocalizedString("Could not save MyImage.json file.", comment: "")
        case .saveImageError:
            return NSLocalizedString("Could not save image file.", comment: "")
        case .readImageError:
            return NSLocalizedString("Could not image.", comment: "")
        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: MyImageError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
