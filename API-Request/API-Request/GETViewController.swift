//
//  GETViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire



class GETViewController: UIViewController {
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colourLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var modifiedLabel: UILabel!
    
    func alamoGET() {
        
        
        //For iOS device test change localhost:3000 to IP Direction
        Alamofire.request(.GET, "http://localhost:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                //println(JSON)
                let json = JSON(Tshirts!)
            if json.count >= 1{
                let id = json[0]["_id"].string
                    self.idLabel.text = id
                let model = json[0]["model"].string
                    self.modelLabel.text = model
                let style = json[0]["style"].string
                    self.styleLabel.text = style
                let size = json[0]["size"].string
                    self.sizeLabel.text = size
                let colour = json[0]["colour"].string
                    self.colourLabel.text = colour
                let price = json[0
                    ]["price"].string
                    self.priceLabel.text = price
                let summary = json[0]["summary"].string
                    self.summaryLabel.text = summary
                let modified = json[0]["summary"].string
                    self.modifiedLabel.text = modified
        }
        
        
        else {
            self.errorLabel.text = "No hay playeras"
            self.errorLabel.textColor = UIColor.blackColor()
                }
        }
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        alamoGET()
        
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
