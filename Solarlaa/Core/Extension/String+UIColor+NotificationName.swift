//
//  String+UIColor+NotificationName.swift
//  Solarlaa
//
//  Created by GISC on 12/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var numberValue:NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
    
    func isValidNotNull() -> Bool {
        if self == nil || self == "" { return false }
        else { return true }
    }
}

extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    
    class func hex(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension Notification.Name {
    static let didChooseMenuFromSideMenu = Notification.Name("didChooseMenuFromSideMenu")
    static let didTapLogout = Notification.Name("didTapLogout")
    static let didChangeLanguage = Notification.Name("didChangeLanguage")
}
