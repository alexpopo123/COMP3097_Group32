//
//  ProductTableViewCell.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    func update(with product: Product) {
        productLabel.text = product.name
        groupLabel.text = product.group
        quantityLabel.text = String(product.quantity)
        urgencyLabel.text = product.urgency
    }
}
