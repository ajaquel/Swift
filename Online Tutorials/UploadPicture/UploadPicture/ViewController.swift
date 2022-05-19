//
//  ViewController.swift
//  UploadPicture
//
//  Created by Alejandro on 6/10/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit
import Parse


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var uploadPreviewImage: UIImageView!
    
    

    @IBAction func uploadImageFromSource(sender: AnyObject) {
        
            // Select picture from library
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Display selected picture into preview
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        uploadPreviewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        uploadImageText.titleLabel?.text = "Change"
    }

    
    
    @IBAction func uploadButton(sender: AnyObject) {
        var imageText = uploadMessage.text
        
        if uploadPreviewImage.image == nil {
            //image is not included alert user
            println("Image not uploaded")
        }else {
            
            var posts = PFObject(className: "Posts")
            posts["imageText"] = imageText
            posts["uploader"] = PFUser.currentUser()
            posts.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    /**success saving, Now save image.***/
                    
                    //create an image data
                    var imageData = UIImagePNGRepresentation(self.uploadPreviewImage.image)
                    //create a parse file to store in cloud
                    var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData)
                    posts["imageFile"] = parseImageFile
                    
                    posts.saveInBackgroundWithBlock({
                        (success: Bool, error: NSError?) -> Void in
                        
                        if error == nil {
                            //take user home
                            println("data uploaded")
                            self.performSegueWithIdentifier("goHomeFromUpload", sender: self)
                            
                        }else {
                            
                            println(error)
                        }
                        
                        
                    })
                    
                    
                }else {
                    println(error)
                    
                }
                
            })
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

