//
//  Contatos.swift
//  DesafioAgenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Contatos {
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contatos:[Contato] = []
    
    init(){
        
        let requisição: NSFetchRequest<Contato> = Contato.fetchRequest()
        do {
            contatos = try contexto.fetch(requisição)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
        
        let contato: Contato = Contato()
        contato.nome = "Rafael Pacheco"
        contato.endereco = "Angelo Tozim 1399"
        contatos.append(contato)
    }
    
}

