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
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        cell.imageView?.layer.borderWidth = 0.1
        cell.imageView?.layer.masksToBounds = false
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)! / 4
        cell.imageView?.clipsToBounds = true
        
     
       // for imagem in (prg![indexPath.row].imagens?.imagem)! {
           // foto = imagem
      //  }
        
      //  let imagem: UIImage = UIImage(data: foto!,scale:1.0)!
       // cell.imageView?.image = imagem
        
       
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
            next.owner = self
            next.index = index!
        }else if segue.identifier == "cad"{
            let next = segue.destination as! EditContatoViewController
            next.editContato = nil
            next.owner = self
        }
    }
    
    func addContato(_ contato : Contato) {
        
        var cont = Contato(context: contexto)
        cont = contato
    
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        self.tableView.reloadData()

    }
    
    func editContato(_ contato : Contato) {
        let index = tableView.indexPathForSelectedRow?.row
        //TODO falta fazer o editar
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
