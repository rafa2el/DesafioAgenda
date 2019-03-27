//
//  VisualizarViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 21/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class VisualizarViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    var index = 0
    var contatoVM: ContatoViewModel!
    var owner : ContatosTableViewController?
    var addFoto = false
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imgContato: UIImageView!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblEndereco: UILabel!
    
    @IBOutlet weak var lblEmpresa: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCelular: UILabel!
    @IBOutlet weak var lblTelResidencial: UILabel!
    @IBOutlet weak var lblNumero: UILabel!
    @IBOutlet weak var lblCep: UILabel!
    
    
    @IBOutlet weak var btSite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgContato.layer.borderWidth = 0.1
        imgContato.layer.masksToBounds = false
        imgContato.layer.borderColor = UIColor.black.cgColor
        imgContato.layer.cornerRadius = imgContato.frame.height / 2
        imgContato.clipsToBounds = true
      //  visualizarContatos()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if addFoto == false{
            visualizarContatos()
        }
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
        let numero : Int32 = (contato.numero)
        
        lblNumero.text = String(numero)
        lblCep.text = contato.cep
       
        btSite.setTitle( contato.site?.absoluteString, for: UIControl.State.normal)
        

    }
    
    
    @IBAction func AddFotos(_ sender: Any) {
        addFoto = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgContato.image = image
        } else{
            print("Erro ao abrir")
        }
        dismiss(animated: true, completion: nil)
        
        //let imagem = (img_view?.image)
        //if imagem != nil {
            
         //   foto.imagem = imagem!.pngData()
          //  contato.addToImagens(foto)
        //}
        
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
        }else if segue.identifier == "fotos"{
            let next = segue.destination as! CollectionViewController
            next.editContato = contatoVM.contatos[index]
        }else if segue.identifier == "map"{
            let next = segue.destination as! MapViewController
            next.editContato = contatoVM.contatos[index]
        }
    }
}
