//
//  IdTableViewController.swift
//  API-Request
//
//  Created by Jonatan Santa Cruz Soria on 23/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire

class IdTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var array: Array <AnyObject> = []
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    func serverError(){
        var alert = UIAlertController(title: "Error", message: "No se puede hacer contacto con el servidor", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func sinPlayeras(){
        var alert = UIAlertController(title: "Error", message: "No hay playeras", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    func tableGetInfo(){
        
        activityIndicator.startAnimating()
        array = []
        Alamofire.request(.GET, "http://192.168.1.67:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                    var tshirts = json
                    var cuenta = 0
                    
                    for tshirt in tshirts {
                        var nuevoID = json[cuenta]["_id"].string
                        self.array.append(nuevoID!)
                        cuenta++
                    }
                    self.tableView.reloadData()
                    if self.array.count == 0 {
                        self.sinPlayeras()
                    }
                    self.activityIndicator.stopAnimating()
                }
                    
                else {
                    self.serverError()
                    self.activityIndicator.stopAnimating()
                }
        }
    }
    
    
    @IBAction func reloadData(sender: AnyObject) {
        tableGetInfo()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        tableGetInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idCell: String = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(idCell) as! UITableViewCell
        cell.textLabel!.text = self.array[indexPath.row] as? String

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
       

        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            array.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextScene = segue.destinationViewController as! GETViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){
            var nuevoID = self.array[indexPath.row] as? String
            nextScene.tableTshirt = nuevoID!
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
