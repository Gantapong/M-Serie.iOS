//
//  MyProfileViewController.swift
//  Solarlaa
//
//  Created by GISC on 4/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = Configurators.messageTH.tryAgain
        // Do any additional setup after loading the view.
        setupGUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    private func setupGUI() {
        addHamburger()
    }

}
