//
//  AlertaModel.swift
//  Klima
//
//  Created by Rafael Plinio on 22/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation

struct AlertaModel {
    let estado: String
    let alerta: [String]
    
    init(estado: String, alerta: [String]) {
        self.estado = estado
        self.alerta = alerta
    }
}

