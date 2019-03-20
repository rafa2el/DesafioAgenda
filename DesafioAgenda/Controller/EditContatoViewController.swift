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
    var editContato: Contato?
    
    @IBOutlet weak var img_view: UIImageView!
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var nomeSobrenome: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var telResidencial: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var empresa: UITextField!
    @IBOutlet weak var site: UITextField!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //altera o componente de imagem para ficar um circulo
        img_view.layer.borderWidth = 1
        img_view.layer.masksToBounds = false
        img_view.layer.borderColor = UIColor.black.cgColor
        img_view.layer.cornerRadius = img_view.frame.height / 2
        img_view.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if editContato != nil {
            nomeSobrenome.text = editContato?.nome
        }
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_save(_ sender: Any) {
        //let data = (img_view?.image)!.pngData()
        
        
        let contato = Contato(context: contexto)
        contato.nome = nomeSobrenome.text
        contato.telefoneResidencial = telResidencial.text
        contato.celular = celular.text
        contato.email = email.text
        contato.empresa = empresa.text
        //contato.site = site
        
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        owner?.tableView.reloadData()
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
