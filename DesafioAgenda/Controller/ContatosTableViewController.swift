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
        cell.detailTextLabel?.text = prg[indexPath.row].endereco
        
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
        contatoVM.contatos[index].nome = ctt.nome
        contatoVM.contatos[index].empresa = ctt.empresa
        contatoVM.contatos[index].telefoneResidencial = ctt.telefoneResidencial
        contatoVM.contatos[index].celular = ctt.celular
        contatoVM.contatos[index].endereco = ctt.endereco
        contatoVM.contatos[index].email = ctt.email
        contatoVM.contatos[index].site = ctt.site
        contatoVM.contatos[index].imagens = ctt.imagens
        
        contatoVM.saveData()
        // tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
        
    }
}
