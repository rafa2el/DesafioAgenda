//
//  ContatosViewModel.swift
//  DesafioAgenda
//
//  Created by Rafael on 24/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContatoViewModel {
    
    var contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contatos: [Contato] = []
    let requestContatos: NSFetchRequest<Contato> = Contato.fetchRequest()
    
    init() {
        loadData()
    }
    
    func saveData() {
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contato: \(error) ")
        }
        loadData()
    }
    
    func loadData() {
        do
        {
          //  contatos = []
            contatos = try contexto.fetch(requestContatos)
            
        }
        catch
        {
            print("Erro recuperar contatos: \(error)")
        }
    }
}
