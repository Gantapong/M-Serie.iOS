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

    // MARK: IBOutlet
    @IBOutlet weak var myProfile: UITableViewCell!
    @IBOutlet weak var manageDevice: UITableViewCell!
    @IBOutlet weak var monitoring: UITableViewCell!
    @IBOutlet weak var summaryEnergyUsage: UITableViewCell!
    @IBOutlet weak var sSeries: UITableViewCell!
    @IBOutlet weak var notification: UITableViewCell!
    @IBOutlet weak var setting: UITableViewCell!
    @IBOutlet weak var help: UITableViewCell!
    @IBOutlet weak var logout: UITableViewCell!
    
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
        if tableView.cellForRow(at: indexPath) == logout {
            NotificationCenter.default.post(name: .didChooseMenuFromSideMenu, object: nil, userInfo: [:])
        }
    }

}
