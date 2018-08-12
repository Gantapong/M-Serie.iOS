//
//  FirstPageViewController.swift
//  Solarlaa
//
//  Created by GISC on 9/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController, FirstPageView {

    // MARK: Properties
    var presenter: FirstPagePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter = FirstPagePresenter(firstPageView: self)
        presenter?.checkIsLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    func checkIsLogin(_ isLogin: Bool) {
        if isLogin {
            performSegue(withIdentifier: "MainPage", sender: nil)
        }
        else {
            performSegue(withIdentifier: "HomePage", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainPage" {
            let vc = segue.destination
            navigationController?.setViewControllers([vc], animated: false)
        }
        else if segue.identifier == "HomePage" {
            let vc = segue.destination
            navigationController?.setViewControllers([vc], animated: false)
        }
    }
}
