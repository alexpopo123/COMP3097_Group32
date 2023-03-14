//
//  EditProductViewController.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit
import DropDown

class EditProductViewController: UIViewController {

    @IBOutlet weak var purchasedNoBtn: UIButton!
    @IBOutlet weak var purchasedYesBtn: UIButton!
    @IBOutlet weak var selectPurchaseDateBtn: UIButton!
    @IBOutlet weak var selectUrgencyBtn: UIButton!
    @IBOutlet weak var selectQuantityBtn: UIButton!
    @IBOutlet weak var priceBox: UITextField!
    @IBOutlet weak var selectGroupBtn: UIButton!
    @IBOutlet weak var productNameBox: UITextField!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceBox.text = ""
        priceBox.placeholder = "Enter price"
        productNameBox.text = ""
        productNameBox.placeholder = "Enter product name"
        selectPurchaseDateBtn.layer.cornerRadius = 5
        selectPurchaseDateBtn.layer.borderWidth = 1
        selectPurchaseDateBtn.layer.borderColor = UIColor.black.cgColor
        selectUrgencyBtn.layer.cornerRadius = 5
        selectUrgencyBtn.layer.borderWidth = 1
        selectUrgencyBtn.layer.borderColor = UIColor.black.cgColor
        selectQuantityBtn.layer.cornerRadius = 5
        selectQuantityBtn.layer.borderWidth = 1
        selectQuantityBtn.layer.borderColor = UIColor.black.cgColor
        selectGroupBtn.layer.cornerRadius = 5
        selectGroupBtn.layer.borderWidth = 1
        selectGroupBtn.layer.borderColor = UIColor.black.cgColor
        purchasedNoBtn.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        purchasedNoBtn.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        purchasedNoBtn.tintColor = .white
        purchasedYesBtn.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        purchasedYesBtn.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        purchasedYesBtn.tintColor = .white
    }
    @IBAction func onClickSelectProductGroupBtn(_ sender: UIButton) {
        dropDown.dataSource = ["Grocery", "Clothes", "Electronic"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onClickSelectQuantityBtn(_ sender: UIButton) {
        dropDown.dataSource = ["0", "1", "2"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onClickSelectUrgencyBtn(_ sender: UIButton) {
        dropDown.dataSource = ["High", "Medium", "Low"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    @IBAction func onClickSelectPurchaseDateButton(_ sender: UIButton) {
        dropDown.dataSource = ["2023/2/26", "2023/2/27", "2023/2/28"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
     @IBAction func btnSelectPurchased(_ sender: UIButton) {
         if sender == purchasedYesBtn{
             purchasedYesBtn.isSelected = true
             purchasedNoBtn.isSelected = false
         }else {
             purchasedYesBtn.isSelected = false
             purchasedNoBtn.isSelected = true
         }
     }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
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
