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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listar" {
            let next = segue.destination as! ContatosTableViewController
            next.owner = self
            
        }
    }
    

}

