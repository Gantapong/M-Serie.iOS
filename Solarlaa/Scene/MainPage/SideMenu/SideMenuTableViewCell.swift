//
//  SideMenuTableViewCell.swift
//  Solarlaa
//
//  Created by GISC on 1/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    // MARK: IBOutet
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupGUI() {
        viewContent.setAllCorners(5)
    }
}
