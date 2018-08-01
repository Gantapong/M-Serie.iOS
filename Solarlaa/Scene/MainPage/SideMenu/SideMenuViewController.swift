//
//  SideMenuViewController.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var viewUpper: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var arrMenu: Array<[String: Any]> = []
    
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
        arrMenu.append(["title": "Red", "color": UIColor.red])
        arrMenu.append(["title": "Green", "color": UIColor.green])
        arrMenu.append(["title": "Blue", "color": UIColor.blue])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    // MARK: Delegate
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.viewContent.setAllCorners(5)
        cell.lbTitle.text = arrMenu[indexPath.row]["title"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userInfo = ["data": arrMenu[indexPath.row]["color"] as! UIColor]
        NotificationCenter.default.post(name: .didChooseMenuFromSideMenu, object: nil, userInfo: userInfo)
    }

}
