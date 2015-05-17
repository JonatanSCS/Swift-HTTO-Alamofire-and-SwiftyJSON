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
    
    
    @IBOutlet var delete_ID_label: UILabel!
    
    
 func alamoGET(){
    Alamofire.request(.GET, "http://localhost:3000:3000/tshirts")
        .responseJSON {(request, response, JSON, error) in
                
          if let data = JSON as? NSArray {
            if data.count >= 2{
             if let tshirt = data[1] as? NSDictionary {
               if let id = tshirt["_id"] as? NSString {
                
                self.delete_ID_label.text = id as String
                
                Alamofire.request(.DELETE, "http://localhost:3000/tshirt/\(id)")
                  .responseJSON {(request, response, JSON, error) in
                    println("Proceso Completado")
                }
                }
                }
            }
            else {
              println("No hay suficientes playeras")
              self.delete_ID_label.text = "No hay suficientes playeras"
                        
            }
                    
            }
    }
    }

    
    
  
    @IBAction func deleteButton(sender: AnyObject) {
        alamoGET()
        
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
