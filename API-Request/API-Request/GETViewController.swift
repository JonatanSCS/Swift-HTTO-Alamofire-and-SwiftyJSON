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
        Alamofire.request(.GET, "http://localhost:3000/tshirt/5553d5db3a3519790f000007")
            .responseJSON {(request, response, JSON, error) in
                //println(JSON)
                
                if let data = JSON as? NSDictionary {
                    if let tshirt = data["tshirt"] as? NSDictionary {
                        var id = tshirt["_id"] as? String
                            self.idLabel.text = id
                        var model = tshirt["model"] as? String
                            self.modelLabel.text = model
                        var style = tshirt["style"] as? String
                            self.styleLabel.text = style
                        var size = tshirt["size"] as? String
                            self.styleLabel.text = size
                        var colour = tshirt["colour"] as? String
                            self.colourLabel.text = colour
                        var price = tshirt["price"] as? String
                            self.priceLabel.text = price
                        var summary = tshirt["summary"] as? String
                            self.summaryLabel.text = summary
                        var modified = tshirt["modified"] as? String
                            self.modifiedLabel.text = modified
                    }
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
