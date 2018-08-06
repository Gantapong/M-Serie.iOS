//
//  LoginViewController.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbOr: UILabel!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    private func setupGUI() {
        lbOr.setAllCorners(lbOr.frame.size.height / 2)
    }
    
    private func getFacebookProfile() {
        
    }
    
    // MARK: IBAction
    @IBAction func btnLoginTapped(_ sender: Any) {
    
    }

    @IBAction func btnFacebookTapped(_ sender: Any) {
        if FBSDKAccessToken.current() != nil {
            getFacebookProfile()
        }
        else {
            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    guard let result = result else { return }
                    if result.isCancelled {
                        print("Cancelled")
                    }
                    else {
                        self.getFacebookProfile()
                    }
                }
            }
        }
    }
    
    @IBAction func btnGoogleTapped(_ sender: Any) {
        
    }

}
