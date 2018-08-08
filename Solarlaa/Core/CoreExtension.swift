//
//  CoreExtension.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func initGestureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func showLoading() {
        let vc = UIViewController()
        let activityIndicator = UIActivityIndicatorView(frame: vc.view.bounds)
        activityIndicator.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        activityIndicator.center = vc.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
        activityIndicator.tag = 100
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.addSubview(activityIndicator)
        vc.view.bringSubview(toFront: activityIndicator)
        present(vc, animated: false, completion: nil)
    }
    
    func hideLoading() {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if let activityIndicator = topController.view.viewWithTag(100) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
            }
            topController.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIView {
    func setRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setAllCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBorder(_ width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setBorder(_ width: CGFloat, withColor color: UIColor) {
        setBorder(width)
        layer.borderColor = color.cgColor
    }
    
    func dropShadow(color: CGColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 2) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
    
    func dropShadowDefault1(){
        dropShadow(color: UIColor.black.cgColor, opacity: 0.5, offSet: CGSize(width: 0, height: 0), radius: 2)
    }
    
    func dropShadowDefault1(_ offSet: CGSize){
        dropShadow(color: UIColor.black.cgColor, opacity: 0.5, offSet: offSet, radius: 2)
    }
    
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.zPosition = -1
        self.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackground(leftColor: UIColor, rightColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.zPosition = -1
        self.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackground(_ topLeftColor: UIColor,_ bottomRightColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ topLeftColor.cgColor, bottomRightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.zPosition = -1
        self.layer.addSublayer(gradientLayer)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill, checkEnable: Bool = true) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    if checkEnable {
                        self.isUserInteractionEnabled = false
                    }
                    return
            }
            if checkEnable {
                self.isUserInteractionEnabled = true
            }
            
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill, checkEnable: Bool = true) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode, checkEnable: checkEnable)
    }
}

extension UITextField {
    func registerKeyboardMoveUp(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deRegisterKeyboardMoveUp(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let navRoot = UIApplication.shared.keyWindow else { return }
        if let keyboardSizeEndUser = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboard = navRoot.convert(keyboardSizeEndUser, from: navRoot)
            let height = navRoot.frame.size.height
            var isHardwareKeyBoard = false
            if (keyboard.origin.y + keyboard.size.height) > height
            {
                isHardwareKeyBoard = true
            }
            var keyboardSize : CGSize!
            if isHardwareKeyBoard {
                keyboardSize = CGSize(width: keyboard.size.width, height: navRoot.frame.size.height - keyboard.origin.y)
            }
            else {
                keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
            }
            
            let pointOnScreen = (self.superview?.convert(self.frame.origin, to: nil))!
            let difHeight = (pointOnScreen.y + self.frame.size.height) - (navRoot.frame.size.height - keyboardSize.height)
            
            if isHardwareKeyBoard == false {
                if (navRoot.frame.origin.y + difHeight) > 0 {
                    navRoot.frame.origin.y = navRoot.frame.origin.y - difHeight
                }
            }
            
            //            if navRoot.frame.origin.y == 0{
            //                navRoot.frame.origin.y -= keyboardSizeEndUser.height
            //            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let navRoot = UIApplication.shared.keyWindow
        if navRoot?.frame.origin.y != 0{
            navRoot?.frame.origin.y = 0
        }
    }
    
}

extension UITextView {
    func setBorder(){
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3.0
    }
    
    func setEnabledMode(_ enable: Bool) {
        self.isUserInteractionEnabled = enable
        if enable {
            self.textColor = UIColor.darkText
        }
        else {
            self.textColor = UIColor.lightGray
        }
    }
    
    func registerKeyboardMoveUp(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deRegisterKeyboardMoveUp(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let navRoot = UIApplication.shared.keyWindow else { return }
        if let keyboardSizeEndUser = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboard = navRoot.convert(keyboardSizeEndUser, from: navRoot)
            let height = navRoot.frame.size.height
            var isHardwareKeyBoard = false
            if (keyboard.origin.y + keyboard.size.height) > height
            {
                isHardwareKeyBoard = true
            }
            var keyboardSize : CGSize!
            if isHardwareKeyBoard {
                keyboardSize = CGSize(width: keyboard.size.width, height: navRoot.frame.size.height - keyboard.origin.y)
            }
            else {
                keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
            }
            
            let pointOnScreen = (self.superview?.convert(self.frame.origin, to: nil))!
            let difHeight = (pointOnScreen.y + self.frame.size.height) - (navRoot.frame.size.height - keyboardSize.height)
            
            if isHardwareKeyBoard == false {
                if (navRoot.frame.origin.y + difHeight) > 0 {
                    navRoot.frame.origin.y = navRoot.frame.origin.y - difHeight
                }
            }
            
            //            if navRoot.frame.origin.y == 0{
            //                navRoot.frame.origin.y -= keyboardSizeEndUser.height
            //            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let navRoot = UIApplication.shared.keyWindow
        if navRoot?.frame.origin.y != 0{
            navRoot?.frame.origin.y = 0
        }
    }
    
}

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

