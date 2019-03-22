//
//  VisualizarViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 21/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class VisualizarViewController: UIViewController {

    var owner : ContatosTableViewController?
    var index = 0
    
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
        lblNome.text = owner?.owner?.contatos[index].nome
        lblTelResidencial.text = owner?.owner?.contatos[index].telefoneResidencial
        lblCelular.text = owner?.owner?.contatos[index].celular
        lblEmpresa.text = owner?.owner?.contatos[index].empresa
        lblEmail.text = owner?.owner?.contatos[index].email
       
        
        let attributedString = NSMutableAttributedString(string: "Clique aqui!")
   
        attributedString.setAttributes([.link: owner?.owner?.contatos[index].site], range: NSMakeRange(7, 4))
        
        self.txtSite.attributedText = attributedString
        self.txtSite.isUserInteractionEnabled = true
        self.txtSite.isEditable = false
        
        // Set how links should appear: blue and underlined
        self.txtSite.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
