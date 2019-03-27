//
//  ContatosTableViewController.swift
//  DesafioAgenda
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class ContatosTableViewController: UITableViewController {

    var contatoVM: ContatoViewModel!
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    lazy var atualizar:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        refresControl.addTarget(self, action: #selector(ContatosTableViewController.atualizarDados(_:)), for: .valueChanged)
        refresControl.tintColor = UIColor.blue
        return refresControl
    }()
    
    
    @objc func atualizarDados(_ refresControl: UIRefreshControl){
        self.tableView.reloadData()
        refresControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.atualizar)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        contatoVM.loadData()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contatoVM.contatos.count
    }
    
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contatos", for: indexPath)
        let prg = contatoVM.contatos
       
        cell.textLabel?.text = prg[indexPath.row].nome
    
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contato = contatoVM.contatos[indexPath.row]
           contexto.delete(contato)
            contatoVM.saveData()
            //contatoVM.contatos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visualizar" {
            let next = segue.destination as! VisualizarViewController
            let index = tableView.indexPathForSelectedRow?.row
            next.index = index!
            next.contatoVM = contatoVM
            next.owner = self
            
        }else if segue.identifier == "cad"{
            let next = segue.destination as! EditContatoViewController
            next.editContato = nil
            next.owner = self
        }
    }
    
    func addContato(_ contato : Contato) {
        contatoVM.contatos.append(contato)
        contatoVM.saveData()
        let cell = IndexPath(row: contatoVM.contatos.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [cell], with: .bottom)
        tableView.endUpdates()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func editContato(_ ctt : Contato, _ index: Int) {
        //let index = tableView.indexPathForSelectedRow?.row
        
        //ctt.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        
        let contato: Contato = contatoVM.contatos[index]
        contato.setValue(ctt.nome, forKeyPath: "nome")
        contato.setValue(ctt.empresa, forKeyPath: "empresa")
        contato.setValue(ctt.telefoneResidencial, forKeyPath: "telefoneResidencial")
        contato.setValue(ctt.celular, forKeyPath: "celular")
        contato.setValue(ctt.endereco, forKeyPath: "endereco")
        contato.setValue(ctt.email, forKeyPath: "email")
        contato.setValue(ctt.site, forKeyPath: "site")
        contato.setValue(ctt.imagens, forKeyPath: "imagens")
        contato.setValue(ctt.cep, forKeyPath: "cep")
        contato.setValue(ctt.numero, forKeyPath: "numero")
        
        contatoVM.saveData()
        tableView.reloadData()
       // self.navigationController?.popViewController(animated: true)
        
    }
    
    func addFoto(_ fotoData : Data, _ index: Int) {
       let contato = contatoVM.contatos[index]
        let foto = Foto(context: contexto)
        foto.imagem = fotoData
        contato.addToImagens(foto)
        contatoVM.saveData()
        tableView.reloadData()
        
    }
}
