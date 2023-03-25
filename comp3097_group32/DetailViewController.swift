//
//  DetailViewController.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit

class DetailViewController: UIViewController {

    // product detail page
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    
    // connect to core data
    let context = (UIApplication.shared.delegate as! AppDelegate).presistanceContainer.viewContext
    var product:Product! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display product information
        nameLabel.text = product.name
        groupLabel.text = product.group
        unitPriceLabel.text = String(product.unitPrice)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        createDateLabel.text = dateFormatter.string(from: product.createdDate!)
        quantityLabel.text = String(product.quantity)
        let amount = product.unitPrice * Double(product.quantity)
        priceLabel.text = String(amount)
        urgencyLabel.text = product.urgency
        if product.purchasedDate == nil {
            purchaseDateLabel.text = ""
        } else {
            purchaseDateLabel.text = dateFormatter.string(from: product.purchasedDate!)
        }
        taxLabel.text = "13.00"
        
    }
    
    // delete product and return to homepage
    @IBAction func onClickDelete(_ sender: UIButton) {
        self.deleteItem(product: product)
        //navigationController?.popViewController(animated: true)
    }
    
    // delete item
    func deleteItem(product:Product){
        context.delete(product)
        do {
            try context.save()
        } catch {
            
        }
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
