//
//  UIViewController+UIView.swift
//  Solarlaa
//
//  Created by GISC on 12/8/2561 BE.
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
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.tag = 100
        if let rootView = UIApplication.shared.keyWindow?.rootViewController {
            rootView.view.addSubview(view)
            rootView.view.bringSubview(toFront: view)
        }
    }
    
    func hideLoading() {
        if let rootView = UIApplication.shared.keyWindow?.rootViewController {
            for view in rootView.view.subviews {
                if view.tag == 100 {
                    view.removeFromSuperview()
                }
            }
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
