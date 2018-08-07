//
//  SideMenuViewController.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var viewUpper: UIView!
    @IBOutlet weak var imgViewProfile: CustomImageViewProfile!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbId: UILabel!
    
    // MARK: Properties
    var arrMenu: Array<[String: Any]> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage), name: .didChangeLanguage, object: nil)
        setupGUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    private func setupGUI() {
        imgViewProfile.downloadedFrom(link: UserSingleton.shared.user.imageProfile ?? "")
        lbName.text = "\(UserSingleton.shared.user.firstname ?? "") \(UserSingleton.shared.user.lastname ?? "")"
    }
    
    @objc private func didChangeLanguage() {
        if Configurators.languages == .EN {
            
        }
        else {
            
        }
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
