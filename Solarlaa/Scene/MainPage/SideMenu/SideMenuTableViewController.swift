//
//  SideMenuTableViewController.swift
//  Solarlaa
//
//  Created by GISC on 6/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

protocol SideMenuTableViewControllerDelegate {
    func didChooseMenu()
}

class SideMenuTableViewController: UITableViewController {

    // MARK: Properties
    var delegate: SideMenuTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage), name: .didChangeLanguage, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    @objc private func didChangeLanguage() {
        if Configurators.languages == .EN {
            
        }
        else {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            let userInfo = ["data": UIColor.red]
            NotificationCenter.default.post(name: .didChooseMenuFromSideMenu, object: nil, userInfo: userInfo)
        }
    }

}
