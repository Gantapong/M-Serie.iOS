//
//  ContainerViewController.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, MainViewControllerDelegate {

    // MARK: IBAction
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    @IBOutlet weak var viewCancelTouch: UIView!
    
    // MARK: Properties
    var mainViewController: MainViewController?
    var sideMenuViewController: SideMenuViewController?
    var isSideMenuShow: Bool = false
    
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
        viewCancelTouch.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewCancelTouchTapped))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        viewCancelTouch.addGestureRecognizer(tap)
    }
    
    @objc private func viewCancelTouchTapped() {
        showHideSideMenu(false)
        mainViewController?.isShowSideMenu = false
    }
    
    // MARK: Delegate
    // MARK: MainViewControllerDelegate
    func showHideSideMenu(_ isShow: Bool) {
        isSideMenuShow = isShow
        if isShow {
            sideMenuLeading.constant = 0
        }
        else {
            sideMenuLeading.constant = -sideMenuWidth.constant
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
            if self.isSideMenuShow {
                self.viewCancelTouch.isHidden = false
            }
            else {
                self.viewCancelTouch.isHidden = true
            }
        }
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SideMenuViewController" {
            sideMenuViewController = segue.destination as? SideMenuViewController
        }
        else if segue.identifier == "MainViewController" {
            if let navVC = segue.destination as? UINavigationController {
                mainViewController = navVC.viewControllers.first as? MainViewController
                mainViewController?.delegate = self
            }
            
        }
    }
}
