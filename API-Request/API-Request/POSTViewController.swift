//
//  POSTViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire

class POSTViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet var imageCamPicker: UIImageView!
    @IBOutlet var modelText: UITextField!
    @IBOutlet var styleText: UITextField!
    @IBOutlet var sizeText: UITextField!
    @IBOutlet var colourText: UITextField!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var summaryText: UITextField!
  
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        modelText.resignFirstResponder()
        styleText.resignFirstResponder()
        sizeText.resignFirstResponder()
        colourText.resignFirstResponder()
        priceText.resignFirstResponder()
        summaryText.resignFirstResponder()
        
        return true
    }
    func sinImagen(){
        var alert = UIAlertController(title: "No se tomó fotografía", message: "No habrá imagen disponible", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    //Change to your IP Direction
    
    func alamoPOST(){
        var parameter = [
            "model": modelText.text,
            "price": styleText.text,
            "style": sizeText.text,
            "size": colourText.text,
            "colour": colourText.text,
            "summary": summaryText.text]

        if imageCamPicker.image == nil {
            
            Alamofire.request(.POST, "http://192.168.1.71:3000/tshirt", parameters: parameter, encoding: .JSON).responseJSON{
                (request, response, JSON, error) in
                self.sinImagen()
                
                if error != nil {
                   self.serverError()
                }
            }

        }
        else {
            imageCamPicker.reloadInputViews()
            var image = imageCamPicker.image!
            var imageData = UIImagePNGRepresentation(image)
            let base64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            parameter["images"] = base64
        
            Alamofire.request(.POST, "http://192.168.1.71:3000/tshirt", parameters: parameter, encoding: .JSON).responseJSON{
                (request, response, JSON, error) in
                if error != nil {
                    self.serverError()
                }
            }
        }
    }
  
    @IBAction func postButton(sender: AnyObject) {
        alamoPOST()
    }
    
    var imagePicker: UIImagePickerController!
    
    @IBAction func TomarFoto(sender: AnyObject) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion:nil)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageCamPicker.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
