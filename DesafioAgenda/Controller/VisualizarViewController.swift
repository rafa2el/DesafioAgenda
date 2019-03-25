//
//  VisualizarViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 21/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class VisualizarViewController: UIViewController {
    
    var index = 0
    var contatoVM: ContatoViewModel!
    var owner : ContatosTableViewController?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var imgContato: UIImageView!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblEndereco: UILabel!
    
    @IBOutlet weak var lblEmpresa: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCelular: UILabel!
    @IBOutlet weak var lblTelResidencial: UILabel!
    
    
    @IBOutlet weak var btSite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgContato.layer.borderWidth = 0.1
        imgContato.layer.masksToBounds = false
        imgContato.layer.borderColor = UIColor.black.cgColor
        imgContato.layer.cornerRadius = imgContato.frame.height / 2
        imgContato.clipsToBounds = true
        visualizarContatos()
    }
    
    private func visualizarContatos(){
       
        let contato = contatoVM.contatos[index]
        
        for im in contato.imagens!{
            let imagem = im as! Foto
            imgContato.image = UIImage(data: imagem.imagem!)
            break
        }
 
        lblNome.text = contato.nome
        lblEndereco.text = contato.endereco
        lblTelResidencial.text = contato.telefoneResidencial
        lblCelular.text = contato.celular
        lblEmpresa.text = contato.empresa
        lblEmail.text = contato.email
       
        btSite.setTitle( contato.site?.absoluteString, for: UIControl.State.normal)
        

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let next = segue.destination as! EditContatoViewController
            next.editContato = contatoVM.contatos[index]
            next.index = index
            next.owner = owner
           // next.contatoVM = contatoVM
        }else if segue.identifier == "webView"{
            let next = segue.destination as! WebViewController
             next.site = contatoVM.contatos[index].site
          //  next.site = URL(string: "www.cade.com.br")
        }
    }
}
