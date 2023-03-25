//
//  TaxViewController.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit

class TaxViewController: UIViewController {

    // tax page
    @IBOutlet weak var taxBox: UITextField!
    @IBOutlet weak var taxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // display tax
        taxBox.text = ""
        taxBox.placeholder = "Update Tax %"
    }
    
    // cancel and return to homepage
    @IBAction func onClickCancel(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // save, update and return to homepage
    @IBAction func onClickSave(_ sender: UIButton) {
        if taxBox.text == nil{
            return
        }else {
            if Double(taxBox.text!) != nil {
                let tax = Double(taxBox.text!)
                let newTax = String(format: "%.2f", tax!)
                
                taxLabel.text = newTax + "%"
            }
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
