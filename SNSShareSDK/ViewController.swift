//
//  ViewController.swift
//  SNSShareSDK
//
//  Created by SwiftiCode on 3/7/20.
//  Copyright © 2020 SwiftiCode. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookShare

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SharingDelegate {
    
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        photoImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    // MARK: FB Share Delegate
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        
        print("ok")
        
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        
        print("Error")
        
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: IB Action
    @IBAction func pickPhoto(_ sender: UITapGestureRecognizer) {
        
        let myPhoto = UIImagePickerController()
        myPhoto.sourceType = .photoLibrary
        myPhoto.delegate = self
        
        present(myPhoto, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sharePhoto(_ sender: UIBarButtonItem) {
        
        print("start sharing")
        
        // prepare for FB share
        let fbPhoto = SharePhoto()
        fbPhoto.image = photoImageView.image
        fbPhoto.isUserGenerated = true
        
        // FB Content
        let content = SharePhotoContent()
        content.photos = [fbPhoto]
        
        // FB Dialog
        let dialog = ShareDialog(fromViewController: self, content: content, delegate: self)
        dialog.mode = .native
        if dialog.canShow {
            dialog.show()
        } else {
            print("error show dialog")
        }
        
        
    }
    
    
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        
        let myPhotoTaker = UIImagePickerController()
        myPhotoTaker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            myPhotoTaker.sourceType = .camera
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                
                myPhotoTaker.cameraDevice = .rear
            
            } else {
                
                myPhotoTaker.cameraDevice = .front
            }
            
        } else {
            
            myPhotoTaker.sourceType = .photoLibrary
        }
        
        present(myPhotoTaker, animated: true, completion: nil)
    }
    
}

