//
//  EditContatoViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 19/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class EditContatoViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    
    var owner : ContatosTableViewController?
    //var contatoVM: ContatoViewModel!
    var editContato: Contato?
    var index = 0
    @IBOutlet weak var img_view: UIImageView!
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var nomeSobrenome: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var telResidencial: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var empresa: UITextField!
    @IBOutlet weak var site: UITextField!
   
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var cep: UITextField!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //altera o componente de imagem para ficar um circulo
        img_view.layer.borderWidth = 0.1
        img_view.layer.masksToBounds = false
        img_view.layer.borderColor = UIColor.black.cgColor
        img_view.layer.cornerRadius = img_view.frame.height / 2
        img_view.clipsToBounds = true

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if editContato != nil {
            self.nomeSobrenome.text = editContato?.nome
            self.endereco.text = editContato?.endereco
            self.telResidencial.text = editContato?.telefoneResidencial
            self.celular.text = editContato?.celular
            self.email.text = editContato?.email
            self.empresa.text = editContato?.empresa
            self.site.text = editContato?.site?.absoluteString
            let numero : Int32 = (editContato?.numero)!
            self.numero.text = String(numero)
            self.cep.text = editContato?.cep
            
            
            for im in editContato!.imagens!{
                let imagem = im as! Foto
                img_view.image = UIImage(data: imagem.imagem!)
            }
            
        }
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_save(_ sender: Any) {
        
        
        if (editContato != nil) {
            self.title = "Editar Contato"
            editContato?.nome = self.nomeSobrenome.text
            editContato?.endereco  = self.endereco.text
            editContato?.telefoneResidencial = self.telResidencial.text
            editContato?.celular =  self.celular.text
            editContato?.email = self.email.text
            editContato?.empresa = self.empresa.text
            if self.numero.text != ""{
                let numero : Int32 = Int32(self.numero!.text!)!
                editContato?.numero = numero
            }

            editContato?.cep = self.cep.text
                
            let urlstring = self.site.text
            editContato?.site = (NSURL(string: urlstring!.replacingOccurrences(of: "\\", with: "/"))! as URL)
            
            owner?.editContato(editContato!, index)
             self.navigationController?.popViewController(animated: true)
        } else {
            
            let contato = Contato(context: contexto)
            let foto = Foto(context: contexto)
            
            contato.nome = nomeSobrenome.text
            contato.endereco = endereco.text
            contato.telefoneResidencial = telResidencial.text
            contato.celular = celular.text
            contato.email = email.text
            contato.empresa = empresa.text
            
            if self.numero.text != ""{
               let numero : Int32 = Int32(self.numero!.text!)!
               contato.numero = numero
            }
            contato.cep = self.cep.text
            
            let imagem = (img_view?.image)
            if imagem != nil {
                
                foto.imagem = imagem!.pngData()
                contato.addToImagens(foto)
            }
            
            let urlstring = self.site.text
            
            contato.site = (NSURL(string: urlstring!)! as URL)
            
            owner?.addContato(contato)
        }
        
       
    }
    
    @IBAction func btn_pick(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img_view.image = image
        } else{
            print("Erro ao abrir")
        }
        dismiss(animated: true, completion: nil)
        
    }
    

}
