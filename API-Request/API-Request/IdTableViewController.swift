//
//  IdTableViewController.swift
//  API-Request
//
//  Created by Jonatan Santa Cruz Soria on 23/05/15.
//  Copyright (c) 2015 Jonatan Santa Cruz Soria. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class IdTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var array: Array <AnyObject> = []
    var arrayCoreID: Array <String> = []
    var arrayCoreModel: Array <String> = []
    var arrayCoreStyle: Array <String> = []
    var arrayCoreSize: Array <String> = []
    var arrayCoreColour: Array <String> = []
    var arrayCorePrice: Array <String> = []
    var arrayCoreSummary: Array <String> = []
    
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
        Alamofire.request(.GET, "http://192.168.1.66:3000/tshirts")
            .responseJSON {(request, response, Tshirts, error) in
                var appDel:AppDelegate = {UIApplication.sharedApplication().delegate as! AppDelegate}()
                var context:NSManagedObjectContext = appDel.managedObjectContext!
                var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Tshirt", inManagedObjectContext: context) as! NSManagedObject
                if Tshirts != nil {
                    let json = JSON(Tshirts!)
                    var tshirts = json
                    var cuenta = 0
                    for tshirt in tshirts {
                        var nuevoID = json[cuenta]["_id"].string
                        var nuevoModel = json[cuenta]["model"].string
                        var nuevoStyle = json[cuenta]["style"].string
                        var nuevoSize = json[cuenta]["size"].string
                        var nuevoColour = json[cuenta]["colour"].string
                        var nuevoPrice = json[cuenta]["price"].string
                        var nuevoSummary = json[cuenta]["summary"].string
                        
                        self.array.append(nuevoID!)
                        var buscar = find(self.arrayCoreID, nuevoID!)
    
                        if buscar == nil {
                            newUser.setValue(nuevoID, forKey: "id")
                            newUser.setValue(nuevoModel, forKey: "model")
                            newUser.setValue(nuevoStyle, forKey: "style")
                            newUser.setValue(nuevoSize, forKey: "size")
                            newUser.setValue(nuevoColour, forKey: "colour")
                            newUser.setValue(nuevoPrice, forKey: "price")
                            newUser.setValue(nuevoSummary, forKey: "summary")
                            context.save(nil)
                            
                            self.arrayCoreID.append(nuevoID!)
                            self.arrayCoreModel.append(nuevoModel!)
                            self.arrayCoreStyle.append(nuevoStyle!)
                            self.arrayCoreSize.append(nuevoSize!)
                            self.arrayCoreColour.append(nuevoColour!)
                            self.arrayCorePrice.append(nuevoPrice!)
                            self.arrayCoreSummary.append(nuevoSummary!)
                        }
                            
                        else {
                            println("Ya existe")
                        }

                        cuenta++
                    }
                    self.tableView.reloadData()
                    if self.array.count == 0 {
                        self.sinPlayeras()
                    }
                    self.activityIndicator.stopAnimating()
                }
                    
                else {
                    var request = NSFetchRequest(entityName: "Tshirt")
                    request.returnsObjectsAsFaults = false
                    var results:NSArray = context.executeFetchRequest(request, error: nil)!
                    for res in results {
                        var requestID: AnyObject? = res.valueForKey("id")
                        if requestID == nil {
                            
                        }
                        else {
                            var requestIDnotnil = res.valueForKey("id") as! String
                            self.array.append(requestIDnotnil)
                        }
                        self.tableView.reloadData()
                    }

                    //self.serverError()
                    self.activityIndicator.stopAnimating()
                }
        }
    }
    func reloadCoreData(){

        arrayCoreID = []
        arrayCoreModel = []
        arrayCoreStyle = []
        arrayCoreSize = []
        arrayCoreColour = []
        arrayCorePrice = []
        arrayCoreSummary = []


        var appDel:AppDelegate = {UIApplication.sharedApplication().delegate as! AppDelegate}()
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Tshirt")
        request.returnsObjectsAsFaults = false
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        for res in results {
            var requestID: AnyObject? = res.valueForKey("id")
            if requestID == nil {
                //
            }
            else {
                var requestID = res.valueForKey("id") as! String
                var requestModel = res.valueForKey("model") as! String
                var requestStyle = res.valueForKey("style") as! String
                var requestSize = res.valueForKey("size") as! String
                var requestColour = res.valueForKey("colour") as! String
                var requestPrice = res.valueForKey("price") as! String
                var requestSummary = res.valueForKey("summary") as! String
                
                self.arrayCoreID.append(requestID)
                self.arrayCoreModel.append(requestModel)
                self.arrayCoreStyle.append(requestStyle)
                self.arrayCoreSize.append(requestSize)
                self.arrayCoreColour.append(requestColour)
                self.arrayCorePrice.append(requestPrice)
                self.arrayCoreSummary.append(requestSummary)
                
            }
        }
    }
    
    @IBAction func reloadData(sender: AnyObject) {
        tableGetInfo()
        reloadCoreData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        tableGetInfo()
        reloadCoreData()
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
            var nuevoID = self.arrayCoreID[indexPath.row]
            var nuevoModel = self.arrayCoreModel[indexPath.row]
            var nuevoStyle = self.arrayCoreStyle[indexPath.row]
            var nuevoSize = self.arrayCoreSize[indexPath.row]
            var nuevoColour = self.arrayCoreColour[indexPath.row]
            var nuevoPrice = self.arrayCorePrice[indexPath.row]
            var nuevoSummary = self.arrayCoreSummary[indexPath.row]
            
            nextScene.tableTshirt = nuevoID
            nextScene.tableModel = nuevoModel
            nextScene.tableStyle = nuevoStyle
            nextScene.tableSize = nuevoSize
            nextScene.tableColour = nuevoColour
            nextScene.tablePrice = nuevoPrice
            nextScene.tableSummary = nuevoSummary

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
