//
//  MainViewController.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate {
    func showHideSideMenu(_ isShow: Bool)
}

class MainViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var btnHamburger: UIBarButtonItem!
    
    // MARK: Properties
    var delegate: MainViewControllerDelegate?
    var isShowSideMenu: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didChooseMenuFromSideMenu(_:)), name: .didChooseMenuFromSideMenu, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    @objc func didChooseMenuFromSideMenu(_ notification: Notification) {
        let userInfo = notification.userInfo
        view.backgroundColor = userInfo?["data"] as? UIColor
        btnHamburgerTapped(btnHamburger)
    }
    
    // MARK: IBAction
    @IBAction func btnHamburgerTapped(_ sender: Any) {
        if delegate != nil {
            isShowSideMenu = !isShowSideMenu
            delegate?.showHideSideMenu(isShowSideMenu)
        }
    }
    
}
