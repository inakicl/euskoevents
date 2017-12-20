//
//  TableViewController.swift
//  euskoevents
//
//  Created by iñaki on 19/12/17.
//  Copyright © 2017 iñaki. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {

    // Objeto de SwiftyJSON
  var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // REF: Desactivar verificación de HTTPS: https://stackoverflow.com/a/30732693/5136913
        let url = "http://opendata.euskadi.eus/contenidos/ds_eventos/eventos_turisticos/opendata/agenda.json"
        
        // No podemos usar .responseJSON(), porque no es un JSON válido
        Alamofire.request(url, method: .get).validate().responseString { response in
            switch response.result {
            case .success(let value):
                
                // Arreglamos los desperfectos
                var temp = value.dropFirst(13) // jsonCallback(
                temp = temp.dropLast(2) // );
                
                // La codificación de caractéres tampoco es válida, debería ser .utf8
                if let dataFromString = temp.data(using: .isoLatin1, allowLossyConversion: false) {
                    
                    // Convertir el String en JSON con SwiftyJSON
                    self.json = try! JSON(data: dataFromString)
                    
                    // Pedir la recarga de la tabla
                    self.tableView.reloadData()
                    //print(self.json ?? 1)
                }
                
            case .failure(let error):
                print(error)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Si no hay datos, no hay filas
        return json?.array?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCelda", for: indexPath) as! TableViewCell
        
        //cell.textLabel?.text = json?[indexPath.row]["documentName"].string
        cell.label.text = json?[indexPath.row]["documentName"].string
        cell.backgroundColor = UIColor.gray
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
