//
//  PUTViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire

class PUTViewController: UIViewController, UITextFieldDelegate {
    
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

    func alamoPUT() {
        
        let parameters_put = ["model": modelText.text, "price": priceText.text, "style": styleText.text, "size": sizeText.text, "colour": colourText.text, "summary": summaryText.text]
        Alamofire.request(.PUT, "http://172.17.4.232:3000/tshirt/5553d5db3a3519790f000007", parameters:parameters_put, encoding: .JSON) .responseJSON {
            (request, response, JSON, error) in
            println(JSON)
        }
    }
    
    @IBAction func send_PUTbutton(sender: AnyObject) {
        alamoPUT()
        
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
