//
//  POSTViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire

class POSTViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    //Picker
    var pickerArray = ["SWAG", "Geek", "Qué usas?"]
    var pickerRowNumber = 0
    
    @IBOutlet var pickerStyleView: UIPickerView!
    
  
    
    @IBOutlet var scrollView: UIScrollView!
    
    //ModelButton
    
    @IBOutlet var firstModel: UIButton!
    @IBOutlet var secondModel: UIButton!
    @IBOutlet var thirdModel: UIButton!
    
    
    //TextFields
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageCamPicker: UIImageView!
    @IBOutlet var summaryText: UITextField!
    @IBOutlet var priceLabelStepper: UILabel!
    
    //SizeButtons
    @IBOutlet var smallButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var largeButton: UIButton!
    
    //ColorButtons
    @IBOutlet var redButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    
    @IBOutlet var stepperChange: UIStepper!
    
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
    
    
    
    
    
    
    
    var modelValue = "2013"
    
    @IBAction func firstAction(sender: AnyObject) {
        modelValue = "2013"
        firstModel.tintColor = UIColor.blueColor()
        secondModel.tintColor = UIColor.lightGrayColor()
        thirdModel.tintColor = UIColor.lightGrayColor()
        
    }
    
    
    @IBAction func secondValue(sender: AnyObject) {
        modelValue = "2014"
        firstModel.tintColor = UIColor.lightGrayColor()
        secondModel.tintColor = UIColor.blueColor()
        thirdModel.tintColor = UIColor.lightGrayColor()
    }
    
    
    @IBAction func thirdAction(sender: AnyObject) {
        modelValue = "2015"
        firstModel.tintColor = UIColor.lightGrayColor()
        secondModel.tintColor = UIColor.lightGrayColor()
        thirdModel.tintColor = UIColor.blueColor()
    }

    
    
    
    
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
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
            "model": modelValue,
            "price": "$ " + priceLabelStepper.text! + "0",
            "style": pickerArray[pickerRowNumber],
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
  
    
    func cleanParameters(){
        firstModel.tintColor = UIColor.blueColor()
        secondModel.tintColor = UIColor.blueColor()
        thirdModel.tintColor = UIColor.blueColor()
        smallButton.tintColor = UIColor.blueColor()
        mediumButton.tintColor = UIColor.blueColor()
        largeButton.tintColor = UIColor.blueColor()
        redButton.setTitle("Selected", forState: UIControlState.Normal)
        blueButton.setTitle("", forState: UIControlState.Normal)
        stepperChange.value = 0
        summaryText.text = ""
        
    }

    
    @IBAction func postButton(sender: AnyObject) {
        alamoPOST()
        cleanParameters()
        
    }
 

    
    var imagePicker: UIImagePickerController!
    @IBAction func TomarFoto(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion:nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageCamPicker.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerArray[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRowNumber = row
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerStyleView.dataSource = self
        pickerStyleView.delegate = self
   
        
        scrollView.contentSize = CGSizeMake(0,1000);
        // Do any additional setup after loading the view.
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
