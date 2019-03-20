//
//  ViewController.swift
//  DesafioAgenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData
import UIKit


class ViewController: UIViewController {

    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contatos:[Contato] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requisição: NSFetchRequest<Contato> = Contato.fetchRequest()
        
        do {
            contatos = try contexto.fetch(requisição)
            
            if (contatos.count == 0) {
                let contato = Contato(context: contexto)
                contato.nome = "Flobervalda Antares Montanha"
                contato.endereco = "Angelo tozim 1399"
                do {
                    try contexto.save()
                } catch  {
                    print("Erro ao salvar o contexto: \(error) ")
                }
                
            }
            
            
            print(contatos)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listar" {
            let next = segue.destination as! ContatosTableViewController
            next.owner = self
            
        }
    }
    

}

