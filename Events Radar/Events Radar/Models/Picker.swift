//
//  Picker.swift
//  Events Radar
//
//  Created by Alejandro on 5/6/22.
//

import SwiftUI
import AVFoundation

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable
        case restricted
        case denied
        
        var errorDescription: String? {
            switch self {
            case.unavailable:
                return NSLocalizedString("Camera unavailable on this device", comment: "")
            case.restricted:
                return NSLocalizedString("Camera restricted on this device", comment: "")
            case.denied:
                return NSLocalizedString("Camera denied on this device. Please check Settings > Privacy > Camera options.", comment: "")
            }
        }
    }
    
    
    
    static func checkPermissions()throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .denied:
                throw PickerError.denied
            case .restricted:
                throw PickerError.restricted
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }
    
    struct CameraErrorType {
        let error: Picker.PickerError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
    
}


