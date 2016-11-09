//
//  ProductsTableViewCell.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/7/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productLogoImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
