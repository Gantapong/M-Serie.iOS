//
//  RegisterViewController.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var txtfFirstname: UITextField!
    @IBOutlet weak var txtfLastname: UITextField!
    @IBOutlet weak var txtfAddress: UITextField!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfCreatePassword: UITextField!
    @IBOutlet weak var txtfConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lbOr: UILabel!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
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
    func setupGUI() {
        lbOr.setAllCorners(lbOr.frame.size.height / 2)
    }
    
    // MARK: IBAction
    @IBAction func btnRegisterTapped(_ sender: Any) {
    
    }

    @IBAction func btnFacebookTapped(_ sender: Any) {
    
    }
    
    @IBAction func btnGoogleTapped(_ sender: Any) {
    
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
