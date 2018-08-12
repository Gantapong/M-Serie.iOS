//
//  UITextField+UITextView.swift
//  Solarlaa
//
//  Created by GISC on 12/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation
import UIKit

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
