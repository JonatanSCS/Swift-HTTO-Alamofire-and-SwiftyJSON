//
//  PUTViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire

class EditiewController: UIViewController, UITextFieldDelegate{
   
    //TextField
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var putErrorLabel: UILabel!
    @IBOutlet var modelText: UITextField!
    @IBOutlet var styleText: UITextField!
    @IBOutlet var summaryText: UITextField!
    @IBOutlet var priceLabelStepper: UILabel!
    
    //SizeButtons
    @IBOutlet var smallButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var largeButton: UIButton!
    
    //ColourButtons
    @IBOutlet var redButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    
    @IBOutlet var stepperUI: UIStepper!
    
    
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
    
    
    
    
    @IBAction func priceStepper(sender: UIStepper) {
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

    func sinPlayeras(){
        var alert = UIAlertController(title: "Error", message: "Ya no hay playeras en la base de datos", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        self.putErrorLabel.text = "No hay playeras"
        self.putErrorLabel.textColor = UIColor.blackColor()
    }
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    var getIDfromGet: String = ""
    func alamoPUT() {
        activityIndicator.startAnimating()
        //Change to your IP Direction
        Alamofire.request(.GET, "http://192.168.1.71:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                    if json.count >= 1 {
                        let id = json[0]["_id"]
                        //println(id)
                        let parameters_put = [
                            "model": self.modelText.text,
                            "price": self.priceLabelStepper.text,
                            "style": self.styleText.text,
                            "size":  self.sizeValue,
                            "colour": self.colourValue,
                            "summary": self.summaryText.text ]
        
                        Alamofire.request(.PUT, "http://192.168.1.71:3000/tshirt/\(self.getIDfromGet)", parameters:parameters_put, encoding: .JSON) .responseJSON {
                            (request, response, JSON, error) in
                                self.activityIndicator.stopAnimating()
                           
                        }
                    }

                    else {
                        self.sinPlayeras()
                        self.activityIndicator.stopAnimating()
                        
                    }
                }
                    
                    
                else {
                    self.serverError()
                    self.activityIndicator.stopAnimating()
                }
        }
    }
    
    
    
    
    @IBAction func deleteTshirt(sender: AnyObject) {
        
        Alamofire.request(.DELETE, "http://192.168.1.71:3000/tshirt/\(getIDfromGet)")
            .responseJSON {(request, response, JSON, error) in
        }
        dismissViewController()
        
    }
    
    
    
    @IBAction func send_PUTbutton(sender: AnyObject) {
        alamoPUT()
        dismissViewController()
        
    }
    
    func dismissViewController() {
        navigationController?.popToRootViewControllerAnimated(true)
        
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadInputViews()
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
