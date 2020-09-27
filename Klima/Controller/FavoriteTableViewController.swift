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
    @IBOutlet weak var backButton: UINavigationItem!
    
    var textField = UITextField()
    
    var cidades: [String] = []
    var temperaturas: [String] = []
    var cellPressed: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        print("print no didLoad: \(cidades)")
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
      
        let vc = segue.destination as! WeatherViewController
        vc.cidade_favorita = cellPressed
        
        //para não adicionar string vazia no array
        if !vc.cidade.contains(cellPressed) {
            vc.cidade.append(textField.text!)
        }
    }
    
    
    
    
    
    @IBAction func addCidadePressed(_ sender: UIBarButtonItem) {
        //cria o alerta
        let alert = UIAlertController(title: "Adicionar Nova Cidade", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in }
            //adiciona a ação de cancelar no alerta
            alert.addAction(cancelAction)
                
        let action = UIAlertAction(title: "Adicionar Cidade", style: .default) { (action) in
            //add cidade na lista depois que o usuario clicar em ADD e não está na lista ainda
            if !self.cidades.contains(self.textField.text!) {
                self.cidades.append(self.textField.text!)
                self.tableView.reloadData()
            }
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Cidade"
            self.textField = alertTextField
        }
        //adiciona a ação no alerta
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }        
}


//unwind para a VC desejada com a cidade 
extension WeatherViewController {
    @IBAction func unwindToWeatherViewController(segue: UIStoryboardSegue) {
        weatherManager.fetchWeather(cityName: cidade_favorita)
        print("print da unwindo qdo volta \(cidade_favorita)")
    }
}
