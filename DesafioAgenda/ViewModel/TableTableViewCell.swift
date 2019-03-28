//
//  TableTableViewCell.swift
//  DesafioAgenda
//
//  Created by ALUNO on 27/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit

class TableTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblNome: UILabel!
    
    @IBOutlet weak var imgTable: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
