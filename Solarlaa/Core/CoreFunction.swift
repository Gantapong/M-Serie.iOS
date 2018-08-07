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
    
    class func setUserDetail(userDetail: User){
        UserSingleton.shared.user.token = userDetail.token
        UserSingleton.shared.user.userId = userDetail.userId
        UserSingleton.shared.user.imageProfile = userDetail.imageProfile
        UserSingleton.shared.user.firstname = userDetail.firstname
        UserSingleton.shared.user.lastname = userDetail.lastname
        UserSingleton.shared.user.email = userDetail.email
        UserSingleton.shared.user.address = userDetail.address
        UserSingleton.shared.updateToUserDefault()
    }
    
    class func signOut(){
        UserSingleton.shared.user.token = nil
        UserSingleton.shared.user.userId = nil
        UserSingleton.shared.user.imageProfile = nil
        UserSingleton.shared.user.firstname = nil
        UserSingleton.shared.user.lastname = nil
        UserSingleton.shared.user.email = nil
        UserSingleton.shared.user.address = nil
        UserSingleton.shared.updateToUserDefault()
    }
}
