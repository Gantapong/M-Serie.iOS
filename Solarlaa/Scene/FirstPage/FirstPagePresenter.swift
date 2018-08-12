//
//  FirstPagePresenter.swift
//  Solarlaa
//
//  Created by GISC on 12/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import GoogleSignIn

class FirstPagePresenter {
    
    var firstPageView: FirstPageView?
    
    init(firstPageView: FirstPageView?) {
        self.firstPageView = firstPageView
    }
    
    func checkIsLogin() {
        if FBSDKAccessToken.current() != nil || GIDSignIn.sharedInstance().hasAuthInKeychain() {
            UserSingleton.shared.updateFromUserDefault()
            firstPageView?.checkIsLogin(true)
        }
        else {
            firstPageView?.checkIsLogin(false)
        }
    }
}
