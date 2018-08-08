//
//  FirstPageViewController.swift
//  Solarlaa
//
//  Created by GISC on 9/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    func checkUser() {
        if FBSDKAccessToken.current() != nil || GIDSignIn.sharedInstance().hasAuthInKeychain() {
            UserSingleton.shared.updateFromUserDefault()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController")
            self.navigationController?.setViewControllers([vc!], animated: false)
        }
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
            self.navigationController?.setViewControllers([vc!], animated: false)
        }
    }
}
