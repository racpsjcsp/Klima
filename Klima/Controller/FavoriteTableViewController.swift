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
    
    var defaults = UserDefaults.standard
    var textField = UITextField()    
    var cidade: [String] = []
    var cidades: [String] = []
    var temperaturas: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if let cidadesDefaults = defaults.array(forKey: "ListaFavoritos") as? [String] {
            cidades = cidadesDefaults
        }
        self.tableView.reloadData()
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
        defaults.set(cell.textLabel!.text!, forKey: "CidadeFavoritaClicada")
        
        performSegue(withIdentifier: "unwindFavorite", sender: cell)
    }    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //deletar items da lista com gesture
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            cidades.remove(at: indexPath.row) //remover a cell selecionada
            
            //passando self.cidades para atualizar e remover o item da cell do UserDefaults
            defaults.set(cidades, forKey: "ListaFavoritos")
            print(defaults.array(forKey: "ListaFavoritos") ?? [])
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
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
                
                self.defaults.set(self.cidades, forKey: "ListaFavoritos")
                
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

//MARK: - Extensions

//unwind para a VC desejada com a cidade através do botão exit pra voltar pra tela anterior passando dados
extension WeatherViewController {
    @IBAction func unwindToWeatherViewController(segue: UIStoryboardSegue) {
        weatherManager.fetchWeather(cityName: defaults.string(forKey: "CidadeFavoritaClicada") ?? "")
    }
}
