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
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageCam: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colourLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var modifiedLabel: UILabel!
    
    
    func sinImagen(){
        self.imageCam.image = UIImage(named: "Unknown.png")
        var alert = UIAlertController(title: "No se tomó fotografía", message: "No habrá imagen disponible", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func noExiste(){
        var alert = UIAlertController(title: "Error", message: "Ya no existe esta playera", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    var tableTshirt: Int = 0
    func alamoGET() {
        activityIndicator.startAnimating()
        //Change to your IP Direction
        Alamofire.request(.GET, "http://192.168.1.66:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                    
                
                    let id = json[self.tableTshirt]["_id"].string
                        self.idLabel.text = id
                        if id == nil {
                            self.noExiste()
                        }
                    let model = json[self.tableTshirt]["model"].string
                        self.modelLabel.text = model
                    let style = json[self.tableTshirt]["style"].string
                        self.styleLabel.text = style
                    let size = json[self.tableTshirt]["size"].string
                        self.sizeLabel.text = size
                    let colour = json[self.tableTshirt]["colour"].string
                        self.colourLabel.text = colour
                            if colour == "Red" {
                                self.colourLabel.textColor = UIColor.redColor()
                            }
                            else {
                                self.colourLabel.textColor = UIColor.blueColor()
                            }
                    let price = json[self.tableTshirt]["price"].string
                        self.priceLabel.text = price
                    let summary = json[self.tableTshirt]["summary"].string
                        self.summaryLabel.text = summary
                    let modified = json[self.tableTshirt]["modified"].string
                        self.modifiedLabel.text = modified
                    let image = json[self.tableTshirt]["images"].string
                
                    
                    
                    if image != nil {
                        let decodedData = NSData(base64EncodedString: image!, options: NSDataBase64DecodingOptions(rawValue: 0))
                        var decodedIamge = UIImage(data: decodedData!)
                            self.imageCam.image = decodedIamge
                        self.activityIndicator.stopAnimating()
                    }
                
                    else {
                        self.imageCam.image = UIImage(named: "Unknown.png")
                         self.activityIndicator.stopAnimating()
                      
                    }
                }
                
                else {
                    self.serverError()
                    self.activityIndicator.stopAnimating()

                }
        }
    }

    
    
    @IBAction func refresInfoView(sender: AnyObject) {
        alamoGET()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextScene = segue.destinationViewController as! EditViewController
            var getIDfromLabel = idLabel.text
            nextScene.getIDfromGet = getIDfromLabel!
        
    }
    
    
    override func viewDidLoad() {
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
