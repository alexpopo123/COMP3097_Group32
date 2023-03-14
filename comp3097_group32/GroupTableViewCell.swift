//
//  GroupTableViewCell.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    func update(with product: String) {
        groupLabel.text = product
    }

}
