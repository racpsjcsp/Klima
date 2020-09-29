//
//  AlertTableViewController.swift
//  Klima
//
//  Created by Rafael Plinio on 20/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit
import SwiftSoup

class AlertTableViewController: UITableViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var cidades: [String] = []
    
    var alertas: [String] = []
    
    var estadoLista = [AlertaModel]()
    
    let cellName = "AlertCell"
    
    let headerEstados = ["Acre (AC)", "Alagoas (AL)", "Amapá (AP)",
                         "Amazonas (AM)", "Bahia (BA)", "Ceará (CE)", "Distrito Federal (DF)",
                         "Espírito Santo (ES)","Goiás (GO)", "Maranhão (MA)", "Mato Grosso (MT)",
                         "Mato Grosso do Sul (MS)", "Minas Gerais (MG)", "Pará (PA)",
                         "Paraíba (PB)", "Paraná (PR)", "Pernambuco (PE)", "Piauí (PI)",
                         "Rio de Janeiro (RJ)", "Rio Grande do Norte (RN)",
                         "Rio Grande do Sul (RS)", "Rondônia (RO)", "Roraima (RR)",
                         "Santa Catarina (SC)", "São Paulo (SP)", "Sergipe (SE)", "Tocantins (TO)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        raspagemAlerta()
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estadoLista[section].alerta.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        let text = estadoLista[indexPath.section].alerta[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .italicSystemFont(ofSize: 16)
        return cell
    }
   
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return estadoLista.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //comparando listas para decidir quais estados exibir baseando se tem alerta ou não
        for item in headerEstados {
            if item.lowercased().contains(estadoLista[section].estado.lowercased()) {
                return item
            }
        }
        return nil
    }
    

    
    //ir para tela de favoritos a partir da tela de alerta
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier != "viewFavoritesFromAlerts" {
            return false
        }
        return true
    }
    
    
    //MARK: - Raspagem Alertas
    
    func raspagemAlerta() {
        let alertaURL = "http://alert-as.inmet.gov.br/cv/"
        let url = URL(string: alertaURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, resp, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
            guard let htmlString = String(data: data, encoding: String.Encoding.utf8) else {
                print("Cant cast data into string")
                return
            }
            let html = htmlString
            
            self.raspagemEstados(divId: "estados_quadro2_barra_main1", estados: "estados_quadro2_nome_paises", html: html)
            self.raspagemEstados(divId: "estados_quadro2_barra_main2", estados: "estados_quadro2_nome_paises", html: html)
            self.raspagemEstados(divId: "estados_quadro2_barra_main3", estados: "estados_quadro2_nome_paises", html: html)
            
            DispatchQueue.main.async {
                self.estadoLista = self.estadoLista.sorted {
                    $0.estado < $1.estado
                }
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
        
    func raspagemEstados(divId: String, estados: String, html: String) {
        do {
            
            let doc: Element = try SwiftSoup.parse(html).getElementById(divId)!
            let div1: Elements = try doc.select("div")
            var estadosPossiveis: [String] = []
            
            for divEstado: Element in div1.array() {
                var estado = ""
                
                if let titulo: Element = try divEstado.getElementById(estados) {
                    estado = try titulo.attr("title")
                    if !estadosPossiveis.contains(estado) {
                        estadosPossiveis.append(estado)
                        var alertas: [String] = []
                        //raspagem das linhas cinza1
                        if let divLinha: Element = try divEstado.getElementById("estados_quadro2_barra_cinza1") {
                            let link: Elements = try divLinha.select("a[href]")
                            for i in link {
                                let atributo: Elements = try i.getElementsByAttribute("title")
                                for j in atributo {
                                    alertas.append(try j.attr("title"))
                                }
                            }
                        //raspagem das linhas cinza2
                        } else if let divLinha: Element = try divEstado.getElementById("estados_quadro2_barra_cinza2") {
                            let link: Elements = try divLinha.select("a[href]")
                            for i in link {
                                let atributo: Elements = try i.getElementsByAttribute("title")
                                for j in atributo {
                                    alertas.append(try j.attr("title"))
                                }
                            }
                        }
                        
                        let alerta = AlertaModel(estado: estado, alerta: alertas)
                        if estado != "" && alertas.count > 0 {
                            self.estadoLista.append(alerta)
                        }
                    }
                }
            }

        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("")
        }
    }
}

//MARK: - Extensions

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
