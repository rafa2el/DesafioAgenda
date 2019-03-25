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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contatos = ContatoViewModel()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listar" {
            let next = segue.destination as! ContatosTableViewController
            next.contatoVM = contatos
        }
    }
}

