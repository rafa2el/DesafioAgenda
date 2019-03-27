//
//  ViewController.swift
//  DesafioAgenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import UIKit


class ViewController: UIViewController {

    
    var contatos: ContatoViewModel!
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contatos = ContatoViewModel()
        
        if contatos.contatos.count == 0 {
            let contato = Contato(context: contexto)
            contato.nome = "Rafael Pacheco"
            contato.endereco = "Angelo tozim"
            let numero = Int32(849)
            contato.numero = numero
            contato.cep = "81490-030"
            contato.email = "rafael.mees@outlook.com"
            contato.telefoneResidencial = "41 3289-6913"
            contato.celular = "41 99667-3801"
            contato.empresa = "Bradesco"
            
            let urlstring = "https://www.google.com.br"
            contato.site = (NSURL(string: urlstring.replacingOccurrences(of: "\\", with: "/"))! as URL)
            
            contatos.contatos.append(contato)
            contatos.saveData()
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listar" {
            let next = segue.destination as! ContatosTableViewController
            next.contatoVM = contatos
        }
    }
}

