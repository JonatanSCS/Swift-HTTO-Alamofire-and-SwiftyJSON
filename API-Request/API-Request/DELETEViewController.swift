//
//  DELETEViewController.swift
//  API
//
//  Created by Jonatan Santa Cruz Soria on 15/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire



class DELETEViewController: UIViewController {
    
    
    @IBOutlet var actyvityIndicator: UIActivityIndicatorView!
    @IBOutlet var delete_ID_label: UILabel!
    
    
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func tshirtEliminada(){
        var alert = UIAlertController(title: "Elimindada", message: "Se eliminó la Tshirt", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    //Change to your IP Direction
    
    func alamoGET(){
        actyvityIndicator.startAnimating()
        
        Alamofire.request(.GET, "http://192.168.1.71:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
        //println(JSON)
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                    
                    if json.count >= 1{
                        let id = json[0]["_id"]
                        //println(id)
                        self.delete_ID_label.text = "\(id)"
            
                        Alamofire.request(.DELETE, "http://192.168.1.71:3000/tshirt/\(id)")
                            .responseJSON {(request, response, JSON, error) in
                                if error != nil {
                                    self.serverError()
                                    self.actyvityIndicator.stopAnimating()
                                }
                                self.tshirtEliminada()
                                self.actyvityIndicator.stopAnimating()
                        }
                    }
            
                    else {
                        if error != nil {
                            println("Error en el servidor")
                        println("No hay playeras que eliminar")
                        self.delete_ID_label.text = "No hay playeras que eliminar"
                            self.actyvityIndicator.stopAnimating()
                        }
                    }
                }
                else {
                    self.serverError()
                    self.actyvityIndicator.stopAnimating()
                }
        }
    }
    
    
    
    
    @IBAction func deleteButton(sender: AnyObject) {
        alamoGET()
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

