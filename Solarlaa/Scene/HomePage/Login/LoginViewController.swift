//
//  LoginViewController.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

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
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
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
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, picture.type(large), first_name, last_name, email"], tokenString: FBSDKAccessToken.current().tokenString, version: "", httpMethod: "POST").start { (connection, profile, error) in
                self.hideLoading()
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
                else {
                    if let profile = profile as? [String: Any] {
                        let data = (profile["picture"] as! [String: Any])["data"] as! [String: Any]
                        let url = (data["url"] as? String) ?? ""
                        let userDetail = User(token: FBSDKAccessToken.current().tokenString, userId: "", imageProfile: url, firstname: (profile["first_name"] as? String) ?? "", lastname: (profile["last_name"] as? String) ?? "", email: (profile["email"] as? String) ?? "", address: "")
                        CoreFunction.setUserDetail(userDetail: userDetail)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController")
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
            }
        }
        else {
            self.hideLoading()
        }
    }
    
    // MARK: IBAction
    @IBAction func btnLoginTapped(_ sender: Any) {
        
    }

    @IBAction func btnFacebookTapped(_ sender: Any) {
        showLoading()
        if FBSDKAccessToken.current() != nil {
            getFacebookProfile()
        }
        else {
            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error {
                    self.hideLoading()
                    print(error.localizedDescription)
                }
                else {
                    guard let result = result else { return }
                    if result.isCancelled {
                        self.hideLoading()
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
        showLoading()
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: Delegate
    // MARK: GoogleSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.hideLoading()
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let image = user.profile.imageURL(withDimension: 200)
            // ...
            let userDetail = User(token: idToken, userId: "", imageProfile: image?.absoluteString ?? "", firstname: givenName ?? "", lastname: familyName ?? "", email: email ?? "", address: "")
            CoreFunction.setUserDetail(userDetail: userDetail)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController")
            self.present(vc!, animated: true, completion: nil)
        }
    }

}
