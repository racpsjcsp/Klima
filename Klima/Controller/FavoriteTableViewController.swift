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
    var cellPressed: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
    }


    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cidades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteItemCell", for: indexPath)
        cell.textLabel?.text = cidades[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        cellPressed = cell.textLabel!.text!
        performSegue(withIdentifier: "unwindFavorite", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       print("print dentro do prepare")
       let vc = segue.destination as! WeatherViewController
       vc.cidade_favorita = cellPressed
    }
    
    
    @IBAction func addCidadePressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Adicionar Nova Cidade", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Adicionar Item", style: .default) { (action) in
            //add cidade na lista depois que o usuario clicar em ADD
            self.cidades.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Adicionar uma nova cidade"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
        
}


//unwind para a VC desejada com a cidade 
extension WeatherViewController {
    @IBAction func unwindToWeatherViewController(segue: UIStoryboardSegue) {
        weatherManager.fetchWeather(cityName: cidade_favorita)
    }
}
