//
//  CustomImageViewProfile.swift
//  Solarlaa
//
//  Created by GISC on 4/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

@objc protocol CustomImageViewProfileDelegate: class {
    @objc optional func customImageViewDidFinish(_ image: UIImage?, videoUrl: NSURL?)
    @objc optional func customImageViewDeleteImage(_ imageView: CustomImageViewProfile)
    @objc optional func customImageViewCurrentImageView(_ imageView: CustomImageViewProfile)
    @objc optional func customImageViewErrorMessage(_ message: String)
    @objc optional func customImageViewPreviewImage()
}

class CustomImageViewProfile: UIImageView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    weak var delegate: CustomImageViewProfileDelegate?
    weak var mainPage: UIViewController!
    
    private var _isImageSet: Bool! = false
    override var image: UIImage?{
        get{
            if _isImageSet == true {
                return super.image
            }
            else {
                return nil
            }
        }
        set{
            if(newValue == nil){
                self._isImageSet = false
                super.image = UIImage(named: "blank_image")
            }
            else{
                self._isImageSet = true
                super.image = newValue
            }
        }
    }
    
    // MARK: Method
    func getIsImageSet() -> Bool{
        return self._isImageSet
    }
    
    func addImageClick(_ mainPage: UIViewController){
        initGUI()
        self.mainPage = mainPage
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:self, action:#selector(addImage))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    func initGUI(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        //        self.backgroundColor = UIColor.lightGray
        super.image = UIImage(named: "blank_image")
    }
    
    @objc func addImage() {
        var message: Any
        if Configurators.languages == .EN {
            message = Configurators.messageEN()
        }
        else {
            message = Configurators.messageTH()
        }
        
        let imagePicker = UIImagePickerController()
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraActionButton = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    OperationQueue.main.addOperation {
                        if granted {
                            imagePicker.allowsEditing = false
                            imagePicker.delegate = self
                            imagePicker.sourceType = .camera
                            imagePicker.modalPresentationStyle = .overFullScreen
                            imagePicker.cameraCaptureMode = .photo
                            self.mainPage.present(imagePicker, animated: true, completion: nil)
                        }
                    }
                }
            }
            else {
                if CoreFunction.isCameraAuthorized() {
                    imagePicker.allowsEditing = false
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera
                    imagePicker.modalPresentationStyle = .overFullScreen
                    imagePicker.cameraCaptureMode = .photo
                    self.mainPage.present(imagePicker, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Camera", message: "Enable camera", preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (alert) -> Void in
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                        }
                    }))
                    self.mainPage.present(alert, animated: true, completion: nil)
                }
            }
        }
        let photoActionButton = UIAlertAction(title: "Photo Library", style: .default) { action -> Void in
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization({ (status) in
                    OperationQueue.main.addOperation {
                        if status == .authorized {
                            imagePicker.allowsEditing = false
                            imagePicker.delegate = self
                            imagePicker.sourceType = .photoLibrary
                            imagePicker.modalPresentationStyle = .overFullScreen
                            self.mainPage.present(imagePicker, animated: true, completion: {
                                UIApplication.shared.statusBarStyle = .default
                            })
                        }
                    }
                })
            }
            else {
                if CoreFunction.isPhotoLibraryAuthorized() {
                    imagePicker.allowsEditing = false
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.modalPresentationStyle = .overFullScreen
                    self.mainPage.present(imagePicker, animated: true, completion: {
                        UIApplication.shared.statusBarStyle = .default
                    })
                }
                else {
                    let alert = UIAlertController(title: "Photo", message: "Enable photo", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (alert) -> Void in
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                        }
                    }))
                    self.mainPage.present(alert, animated: true, completion: nil)
                }
            }
        }
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        let deleteActionButton = UIAlertAction(title: "Delete", style: .destructive) { action -> Void in
            self.delegate?.customImageViewDeleteImage?(self)
        }
        actionSheetController.addAction(cameraActionButton)
        actionSheetController.addAction(photoActionButton)
//        if self._isImageSet {
//            actionSheetController.addAction(deleteActionButton)
//        }
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.popoverPresentationController?.sourceView = self
        actionSheetController.popoverPresentationController?.sourceRect = CGRect(x: self.frame.size.width/2, y: self.frame.size.height/2, width: 0, height: 0)
        self.mainPage.view.endEditing(true)
        self.mainPage.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: ImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        UIApplication.shared.statusBarStyle = .lightContent
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            var chosenImage = UIImage()
            chosenImage = image
            self.contentMode = .scaleAspectFill
            self.image = chosenImage
            self.mainPage.dismiss(animated:true, completion:{
                self.delegate?.customImageViewDidFinish?(chosenImage, videoUrl: nil)
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        UIApplication.shared.statusBarStyle = .lightContent
        self.mainPage.dismiss(animated: true, completion: nil)
    }
}
