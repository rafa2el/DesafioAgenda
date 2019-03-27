//
//  CollectionViewController.swift
//  DesafioAgenda
//
//  Created by ALUNO on 25/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

//https://www.ioscreator.com/tutorials/custom-collection-view-cell-ios-tutorial

class CollectionViewController: UICollectionViewController {
    let myImage = UIImage(named: "Apple_Swift_Logo")
    var owner : ContatosTableViewController?

    var editContato: Contato?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (editContato?.imagens?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        for im in editContato!.imagens!{
            let imagem = im as! Foto
            cell.imgView.image = UIImage(data: imagem.imagem!)
        }
        
        return cell
    }
    
}
