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
    
    //tableTshir get its value from IdTableViewController
    
    var tableTshirt: Int = 0
    
    func alamoGET() {
        
        //For iOS device test change localhost:3000 to IP Direction
        Alamofire.request(.GET, "http://localhost:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                //println(JSON)
                let json = JSON(Tshirts!)
                
                let id = json[self.tableTshirt]["_id"].string
                    self.idLabel.text = id
                let model = json[self.tableTshirt]["model"].string
                    self.modelLabel.text = model
                let style = json[self.tableTshirt]["style"].string
                    self.styleLabel.text = style
                let size = json[self.tableTshirt]["size"].string
                    self.sizeLabel.text = size
                let colour = json[self.tableTshirt]["colour"].string
                    self.colourLabel.text = colour
                let price = json[self.tableTshirt]["price"].string
                    self.priceLabel.text = price
                let summary = json[self.tableTshirt]["summary"].string
                    self.summaryLabel.text = summary
                let modified = json[self.tableTshirt]["summary"].string
                    self.modifiedLabel.text = modified
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        alamoGET()
        println(tableTshirt)
        
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
