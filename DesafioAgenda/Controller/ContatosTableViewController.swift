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

    var owner: ViewController?
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
        //navigationItem.rightBarButtonItems?.append(editButtonItem)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return owner!.contatos.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contatos", for: indexPath)
        let prg = owner?.contatos
       
        cell.textLabel?.text = prg![indexPath.row].nome
        cell.detailTextLabel?.text = prg![indexPath.row].endereco
        
       
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contato = owner?.contatos[indexPath.row]
            contexto.delete(contato!)
           
            do {
                try contexto.save()
            } catch  {
                print("Erro ao salvar o contexto: \(error) ")
            }

            owner?.contatos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visualizar" {
            let next = segue.destination as! VisualizarViewController
            let index = tableView.indexPathForSelectedRow?.row
            next.contato = owner?.contatos[index!]
            next.index = index!
            next.owner = self
        }else if segue.identifier == "cad"{
            let next = segue.destination as! EditContatoViewController
            next.editContato = nil
            next.owner = self
        }
    }
    
    func addContato(_ contato : Contato) {
        
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        loadData()
        tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func editContato(_ ctt : Contato, _ indexx: Int) {
        let index = tableView.indexPathForSelectedRow?.row
        owner?.contatos[index!].nome = ctt.nome
        owner?.contatos[index!].telefoneResidencial = ctt.telefoneResidencial
        owner?.contatos[index!].celular = ctt.celular
        owner?.contatos[index!].endereco = ctt.endereco
        owner?.contatos[index!].email = ctt.email
        owner?.contatos[index!].site = ctt.site
        owner?.contatos[index!].imagens = ctt.imagens
        
        do {
            try contexto.save()
        } catch  {
            print("Erro ao editar contexto: \(error) ")
        }
        loadData()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func loadData(){
        let requisição: NSFetchRequest<Contato> = Contato.fetchRequest()
        do {
            owner!.contatos = try contexto.fetch(requisição)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
        
    }
    
}
