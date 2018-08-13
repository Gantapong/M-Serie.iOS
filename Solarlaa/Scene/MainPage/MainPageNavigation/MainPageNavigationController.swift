//
//  MainPageNavigationController.swift
//  Solarlaa
//
//  Created by GISC on 13/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class MainPageNavigationController: UINavigationController {

    // MARK: Properties
    var myProfileViewController: MyProfileViewController?
    var manageDeviceViewController: ManageDeviceViewController?
    var monitoringViewController: MonitoringViewController?
    var summaryEnergyUsageViewController: SummaryEnergyUsageViewController?
    var sSeriesViewController: SSeriesViewController?
    var notificationViewController: NotificationViewController?
    var settingViewController: SettingViewController?
    var helpViewController: HelpViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didChooseMenuFromSideMenu(_:)), name: .didChooseMenuFromSideMenu, object: nil)
        setRootViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    private func setRootViewController() {
        let storyboard = UIStoryboard(name: "MyProfile", bundle: nil)
        myProfileViewController = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as? MyProfileViewController
        setViewControllers([myProfileViewController!], animated: true)
    }
    
    @objc func didChooseMenuFromSideMenu(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let menu = userInfo["menu"] as? SideMenu {
            
            if menu == .logout {
                NotificationCenter.default.post(name: .didTapLogout, object: nil, userInfo: nil)
            }
            else {
                rootToMenu(menu)
            }
        }
        hamburgerTapped()
    }
    
    func rootToMenu(_ menu: SideMenu) {
        var vc: UIViewController?
        switch menu {
        case .myProfile:
            if myProfileViewController == nil {
                let storyboard = UIStoryboard(name: "MyProfile", bundle: nil)
                myProfileViewController = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as? MyProfileViewController
            }
            vc = myProfileViewController
        case .manageDevice:
            if manageDeviceViewController == nil {
                let storyboard = UIStoryboard(name: "ManageDevice", bundle: nil)
                manageDeviceViewController = storyboard.instantiateViewController(withIdentifier: "ManageDeviceViewController") as? ManageDeviceViewController
            }
            vc = manageDeviceViewController
        case .monitoring:
            if monitoringViewController == nil {
                let storyboard = UIStoryboard(name: "Monitoring", bundle: nil)
                monitoringViewController = storyboard.instantiateViewController(withIdentifier: "MonitoringViewController") as? MonitoringViewController
            }
            vc = monitoringViewController
        case .summaryEnergyUsage:
            if summaryEnergyUsageViewController == nil {
                let storyboard = UIStoryboard(name: "SummaryEnergyUsage", bundle: nil)
                summaryEnergyUsageViewController = storyboard.instantiateViewController(withIdentifier: "SummaryEnergyUsageViewController") as? SummaryEnergyUsageViewController
            }
            vc = summaryEnergyUsageViewController
        case .sSeries:
            if sSeriesViewController == nil {
                let storyboard = UIStoryboard(name: "SSeries", bundle: nil)
                sSeriesViewController = storyboard.instantiateViewController(withIdentifier: "SSeriesViewController") as? SSeriesViewController
            }
            vc = sSeriesViewController
        case .notification:
            if notificationViewController == nil {
                let storyboard = UIStoryboard(name: "Notification", bundle: nil)
                notificationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
            }
            vc = notificationViewController
        case .setting:
            if settingViewController == nil {
                let storyboard = UIStoryboard(name: "Setting", bundle: nil)
                settingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
            }
            vc = settingViewController
        case .help:
            if helpViewController == nil {
                let storyboard = UIStoryboard(name: "Help", bundle: nil)
                helpViewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
            }
            vc = helpViewController
        default:
            break
        }
        if let vc = vc {
            setViewControllers([vc], animated: false)
        }
    }

}
