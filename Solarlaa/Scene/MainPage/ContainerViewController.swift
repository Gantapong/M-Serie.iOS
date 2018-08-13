//
//  ContainerViewController.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ContainerViewController: UIViewController {

    // MARK: IBOulet
    @IBOutlet weak var viewSideMenu: UIView!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    @IBOutlet weak var viewMainWidth: NSLayoutConstraint!
    @IBOutlet weak var viewCancelTouch: UIView!
    
    // MARK: Properties
    var mainPageNavigationController: MainPageNavigationController?
    var sideMenuViewController: SideMenuViewController?
    var isSideMenuShow: Bool = false
    var translationInSideMenu: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewMainWidth.constant = UIScreen.main.bounds.width
        NotificationCenter.default.addObserver(self, selector: #selector(didHamburgerTapped), name: .hamburgerTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapLogout), name: .didTapLogout, object: nil)
        setupGUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewSideMenu.isHidden = false
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
    
    @objc func didHamburgerTapped() {
        showHideSideMenu(!isSideMenuShow)
    }
    
    @objc func didTapLogout() {
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomePageViewController")
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    @objc private func viewCancelTouchTapped() {
        showHideSideMenu(false)
    }
    
    // MARK: IBAction
    @IBAction func screenEdgePanGestureToOpen(_ sender: UIScreenEdgePanGestureRecognizer) {
        if !isSideMenuShow {
            if sender.state == .began || sender.state == .changed {
                let locationX = sender.location(in: view).x
                var newLeading = -sideMenuWidth.constant + locationX
                if newLeading > 0 {
                    newLeading = 0
                }
                else if newLeading < -sideMenuWidth.constant {
                    newLeading = -sideMenuWidth.constant
                }
                sideMenuLeading.constant = newLeading
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
            }
            else if sender.state == .ended {
                let velocityX = sender.velocity(in: view).x
                if abs(velocityX) > 1500 {
                    if velocityX > 0 {
                        showHideSideMenu(true)
                    }
                    else {
                        showHideSideMenu(false)
                    }
                }
                else {
                    if sideMenuLeading.constant >= -sideMenuWidth.constant / 2 {
                        showHideSideMenu(true)
                    }
                    else {
                        showHideSideMenu(false)
                    }
                }
            }
        }
    }
    
    @IBAction func panGestureToClose(_ sender: UIPanGestureRecognizer) {
        if isSideMenuShow {
            let locationX = sender.location(in: view).x
            if locationX <= sideMenuWidth.constant {
                if sender.state == .began || sender.state == .changed {
                    if translationInSideMenu == nil {
                        translationInSideMenu = sender.translation(in: view).x
                    }
                    let translationX = sender.translation(in: view).x
                    var newLeading = translationX - translationInSideMenu!
                    if newLeading > 0 {
                        newLeading = 0
                    }
                    else if newLeading < -sideMenuWidth.constant {
                        newLeading = -sideMenuWidth.constant
                    }
                    sideMenuLeading.constant = newLeading
                    UIView.animate(withDuration: 0.1) {
                        self.view.layoutIfNeeded()
                    }
                }
                else if sender.state == .ended {
                    let velocityX = sender.velocity(in: view).x
                    if abs(velocityX) > 1500 {
                        if velocityX > 0 {
                            showHideSideMenu(true)
                        }
                        else {
                            showHideSideMenu(false)
                        }
                    }
                    else {
                        if sideMenuLeading.constant >= -sideMenuWidth.constant / 2 {
                            showHideSideMenu(true)
                        }
                        else {
                            showHideSideMenu(false)
                        }
                    }
                    translationInSideMenu = nil
                }
            }
        }
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SideMenuViewController" {
            sideMenuViewController = segue.destination as? SideMenuViewController
        }
        else if segue.identifier == "MainPageNavigationController" {
            mainPageNavigationController = segue.destination as? MainPageNavigationController
        }
    }
}
