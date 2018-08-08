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
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage), name: .didChangeLanguage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChooseMenuFromSideMenu(_:)), name: .didChooseMenuFromSideMenu, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    @objc func didChooseMenuFromSideMenu(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        btnHamburgerTapped(btnHamburger)
    }
    
    @objc private func didChangeLanguage() {
        if Configurators.languages == .EN {
            print("EN")
            Configurators.languages = .TH
        }
        else {
            print("TH")
            Configurators.languages = .EN
        }
    }
    
    // MARK: IBAction
    @IBAction func btnHamburgerTapped(_ sender: Any) {
        didChangeLanguage()
        if delegate != nil {
            isShowSideMenu = !isShowSideMenu
            delegate?.showHideSideMenu(isShowSideMenu)
        }
    }
    
}
