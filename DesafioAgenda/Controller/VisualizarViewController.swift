//
//  VisualizarViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 21/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class VisualizarViewController: UIViewController {

    var contato : Contato?
    var index = 0
    var owner : ContatosTableViewController?

    @IBOutlet weak var imgContato: UIImageView!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblEndereco: UILabel!
    
    @IBOutlet weak var lblEmpresa: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCelular: UILabel!
    @IBOutlet weak var lblTelResidencial: UILabel!
    
    @IBOutlet weak var txtSite: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgContato.layer.borderWidth = 0.1
        imgContato.layer.masksToBounds = false
        imgContato.layer.borderColor = UIColor.black.cgColor
        imgContato.layer.cornerRadius = imgContato.frame.height / 2
        imgContato.clipsToBounds = true
        visualizar()
    }
    
    private func visualizar(){
   
        for im in contato!.imagens!{
            let imagem = im as! Foto
            imgContato.image = UIImage(data: imagem.imagem!)
            break
        }
 
        lblNome.text = contato?.nome
        lblEndereco.text = contato!.endereco
        lblTelResidencial.text = contato!.telefoneResidencial
        lblCelular.text = self.contato!.celular
        lblEmpresa.text = self.contato!.empresa
        lblEmail.text = self.contato!.email
       
        
        let attributedString = NSMutableAttributedString(string: "Clique aqui!")
   
        attributedString.setAttributes([.link: self.contato!.site], range: NSMakeRange(7, 4))
        
        self.txtSite.attributedText = attributedString
        self.txtSite.isUserInteractionEnabled = true
        self.txtSite.isEditable = false
        
        // Set how links should appear: blue and underlined
        self.txtSite.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let next = segue.destination as! EditContatoViewController
            next.editContato = contato
            next.index = index
            next.owner = owner
        }
    }
}
