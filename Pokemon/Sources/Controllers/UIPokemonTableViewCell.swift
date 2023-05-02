//
//  UIPokemonTableViewCell.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 19.04.2023.
//

import UIKit

class UIPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UISprite!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
