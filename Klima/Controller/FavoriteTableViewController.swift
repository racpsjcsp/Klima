//
//  FavoriteTableViewController.swift
//  Klima
//
//  Created by Rafael Plinio on 10/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var cidades: [String] = []
    var temperaturas: [String] = []
    var cellPressed = String()
    var ultimaCidade = String()    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myTableView.dataSource = self
        myTableView.delegate = self
        
        print("print lista favoritos")
        print(cidades)
    }
   

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cidades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteItemCell", for: indexPath)
        cell.textLabel?.text = cidades[indexPath.row]
        cell.detailTextLabel?.text = ("\(temperaturas[indexPath.row])°C")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    

}
