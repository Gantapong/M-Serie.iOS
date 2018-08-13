//
//  SideMenuTableViewController.swift
//  Solarlaa
//
//  Created by GISC on 6/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

enum SideMenu {
    case myProfile
    case manageDevice
    case monitoring
    case summaryEnergyUsage
    case sSeries
    case notification
    case setting
    case help
    case logout
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
        var userInfo = [String: SideMenu]()
        if let cell = tableView.cellForRow(at: indexPath) {
            switch cell {
            case myProfile:
                userInfo["menu"] = .myProfile
            case manageDevice:
                userInfo["menu"] = .manageDevice
            case monitoring:
                userInfo["menu"] = .monitoring
            case summaryEnergyUsage:
                userInfo["menu"] = .summaryEnergyUsage
            case sSeries:
                userInfo["menu"] = .sSeries
            case notification:
                userInfo["menu"] = .notification
            case setting:
                userInfo["menu"] = .setting
            case help:
                userInfo["menu"] = .help
            case logout:
                userInfo["menu"] = .logout
            default:
                break
            }
            NotificationCenter.default.post(name: .didChooseMenuFromSideMenu, object: nil, userInfo: userInfo)
        }
    }

}
