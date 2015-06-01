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
    //TextFields
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageCamPicker: UIImageView!
    @IBOutlet var modelText: UITextField!
    @IBOutlet var styleText: UITextField!
    @IBOutlet var summaryText: UITextField!
    @IBOutlet var priceLabelStepper: UILabel!
    
    //SizeButtons
    @IBOutlet var smallButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var largeButton: UIButton!
    
    //ColorButtons
    @IBOutlet var redButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    
    
    var colourValue = "Red"
    @IBAction func redAction(sender: AnyObject) {
        redButton.setTitle("Selected", forState: UIControlState.Normal)
        blueButton.setTitle("", forState: UIControlState.Normal)
        colourValue = "Red"
        
    }
    
    @IBAction func blueAction(sender: AnyObject) {
        redButton.setTitle("", forState: UIControlState.Normal)
        blueButton.setTitle("Selected", forState: UIControlState.Normal)
        colourValue = "Blue"
    }
    
    
    var sizeValue: String = "Small"
    @IBAction func smallAction(sender: AnyObject) {
        largeButton.tintColor = UIColor.lightGrayColor()
        mediumButton.tintColor = UIColor.lightGrayColor()
        smallButton.tintColor = UIColor.blueColor()
        sizeValue = "Small"
    }
    
    @IBAction func mediumAction(sender: AnyObject) {
        largeButton.tintColor = UIColor.lightGrayColor()
        mediumButton.tintColor = UIColor.blueColor()
        smallButton.tintColor = UIColor.lightGrayColor()
        sizeValue = "Medium"
    }
    
    @IBAction func largeAction(sender: AnyObject) {
        largeButton.tintColor = UIColor.blueColor()
        mediumButton.tintColor = UIColor.lightGrayColor()
        smallButton.tintColor = UIColor.lightGrayColor()
        sizeValue = "Large"
    }
   
    
    
    
    @IBAction func stepperPrice(sender: UIStepper) {
        if sender.value < 11{
            self.priceLabelStepper.text = sender.value.description
        }
            
        else {
            sender.value = 10
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        modelText.resignFirstResponder()
        styleText.resignFirstResponder()
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
    
    func alamoPOST(){
        
        var parameter = [
            "model": modelText.text,
            "price": "$ " + priceLabelStepper.text! + "0",
            "style": styleText.text,
            "size": sizeValue,
            "colour": colourValue,
            "summary": summaryText.text]

        
        if imageCamPicker.image == nil {
            activityIndicator.startAnimating()
             //Change to your IP Direction
            Alamofire.request(.POST, "http://192.168.1.71:3000/tshirt", parameters: parameter, encoding: .JSON).responseJSON{
                (request, response, JSON, error) in
                    self.sinImagen()
                    self.activityIndicator.stopAnimating()
                
                if error != nil {
                    self.serverError()
                    self.activityIndicator.stopAnimating()
                }
            }

        }
        
            
        else {
            activityIndicator.startAnimating()
            imageCamPicker.reloadInputViews()
            
            var image = imageCamPicker.image!
            var imageData = UIImagePNGRepresentation(image)
            let base64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            parameter["images"] = base64
             //Change to your IP Direction
            Alamofire.request(.POST, "http://192.168.1.71:3000/tshirt", parameters: parameter, encoding: .JSON).responseJSON{
                (request, response, JSON, error) in
                self.activityIndicator.stopAnimating()

                if error != nil {
                    self.serverError()
                    self.activityIndicator.stopAnimating()
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
