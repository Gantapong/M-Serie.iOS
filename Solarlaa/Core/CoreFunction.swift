//
//  CoreFunction.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

class CoreFunction {
    
    class func isCameraAuthorized() -> Bool {
        var authorized = false
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            authorized = true
        default :
            break
        }
        return authorized
    }
    
    class func isPhotoLibraryAuthorized() -> Bool {
        var authorized = false
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            authorized = true
        default :
            break
        }
        return authorized
    }
    
    class func isLogin() -> Bool {
        if UserDefaults.standard.object(forKey: "USER_ID") != nil {
            return true
        }
        return false
    }
    
    class func setUserDetail(userDetail: [String: Any]){
        UserSingleton.shared.user.userId = userDetail["USER_ID"] as? String ?? ""
        UserSingleton.shared.user.imageProfile = userDetail["CID"] as? String ?? ""
        UserSingleton.shared.user.firstname = userDetail["PROFILE_IMG"] as? String ?? ""
        UserSingleton.shared.user.lastname = userDetail["NAME"] as? String ?? ""
        UserSingleton.shared.user.email = userDetail["POINT"] as? String ?? ""
        UserSingleton.shared.user.address = userDetail["TELNO"] as? String ?? ""
        UserSingleton.shared.updateToUserDefault()
    }
    
    class func signOut(){
        UserSingleton.shared.user.userId = nil
        UserSingleton.shared.user.imageProfile = nil
        UserSingleton.shared.user.firstname = nil
        UserSingleton.shared.user.lastname = nil
        UserSingleton.shared.user.email = nil
        UserSingleton.shared.user.address = nil
        UserSingleton.shared.updateToUserDefault()
    }
}
