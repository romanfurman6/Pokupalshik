//
//  CartTableViewCell.swift
//  Pokupalshik
//
//  Created by Roman Dmitrieivich on 11/14/16.
//  Copyright © 2016 Roman Dmitrieivich. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartNameLabel: UILabel!
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var countOfProduct: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
}
