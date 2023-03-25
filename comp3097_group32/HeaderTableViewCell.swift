//
//  HeaderTableViewCell.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-03-23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    // custom header section for table
    var urgencyLabel: UILabel!
    var quantityLabel: UILabel!
    var productLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // setup header function
    func setup(header: Header){
        
        productLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        productLabel.textColor = .white
        
        quantityLabel = UILabel(frame: CGRect(x: 100, y: 0, width: 100, height: 40))
        quantityLabel.textColor = .white
        
        urgencyLabel = UILabel(frame: CGRect(x: 200, y: 0, width: 100, height: 40))
        urgencyLabel.textColor = .white
        
        contentView.addSubview(productLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(urgencyLabel)
        
        productLabel.text = header.col1
        quantityLabel.text = header.col2
        urgencyLabel.text = header.col3
    }

}
