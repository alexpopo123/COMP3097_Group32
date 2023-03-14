//
//  DetailViewController.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    var product:Product! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = product.name
        groupLabel.text = product.group
        unitPriceLabel.text = String(product.unitPrice)
        createDateLabel.text = product.createDate
        quantityLabel.text = String(product.quantity)
        let amount = product.unitPrice * Double(product.quantity)
        priceLabel.text = String(amount)
        urgencyLabel.text = product.urgency
        purchaseDateLabel.text = product.purchaseDate
        taxLabel.text = "13.00"
        if product.purchaseDate == "" {
            purchaseLabel.text = "Unpurchased"
        } else {
            purchaseLabel.text = "Purchased"
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickDelete(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
