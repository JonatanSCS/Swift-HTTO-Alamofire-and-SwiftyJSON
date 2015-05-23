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
    
    
    //For iOS device test change localhost:3000 to IP Direction
    
    func alamoGET(){
    
        Alamofire.request(.GET, "http://localhost:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
        //println(JSON)
        let json = JSON(Tshirts!)
        
        if json.count >= 1{
            
            let id = json[0]["_id"]
            println(id)
            self.delete_ID_label.text = "\(id)"
            
            Alamofire.request(.DELETE, "http://localhost:3000/tshirt/\(id)")
                .responseJSON {(request, response, JSON, error) in
            
                    println("Proceso Completado")
                    
            }
        }
            
        else {
            println("No hay playeras que eliminar")
            self.delete_ID_label.text = "No hay playeras que eliminar"
                
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
    

