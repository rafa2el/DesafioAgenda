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
            let contato = Contato(context: contexto)

            if (contatos.count == 0) {
                
                contato.nome = "Rafael Pacheco"
                contato.endereco = "Angelo tozim 1399"
                contato.telefoneResidencial = "(41) 3289-6913"
                contato.celular = "(41 )99667-3801"
                contato.site = URL(string: "https://www.google.com.br")!
                
                var imagens:[Data] = []
                contato.imagens?.imagem?.append(imagens[0])
                //contato.imagens?.imagem?.append(imagens[0])
                do {
                    try contexto.save()
                } catch  {
                    print("Erro ao salvar o contexto: \(error) ")
                }
                contatos = []
                contatos = try contexto.fetch(requisição)
                
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

