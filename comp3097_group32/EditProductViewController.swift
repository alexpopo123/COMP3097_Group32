//
//  EditProductViewController.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-02-24.
//

import UIKit
import DropDown

class EditProductViewController: UIViewController {

    // add/edit product page elements
    @IBOutlet weak var selectUrgencyBtn: UIButton!
    @IBOutlet weak var quantityBox: UITextField!
    @IBOutlet weak var priceBox: UITextField!
    @IBOutlet weak var selectGroupBtn: UIButton!
    @IBOutlet weak var selectDate: UIDatePicker!
    @IBOutlet weak var productNameBox: UITextField!
    
    // connect to core data
    let context = (UIApplication.shared.delegate as! AppDelegate).presistanceContainer.viewContext
    
    // create dropdown
    let dropDown = DropDown()
    let groupDropDown = DropDown()
    let urgencyDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // price
        priceBox.text = ""
        priceBox.placeholder = "Enter price"
        
        // product
        productNameBox.text = ""
        productNameBox.placeholder = "Enter product name"
        
        // quantity
        quantityBox.text = ""
        quantityBox.placeholder = "Enter quantity"
        
        // urgency
        selectUrgencyBtn.layer.cornerRadius = 5
        selectUrgencyBtn.layer.borderWidth = 1
        selectUrgencyBtn.layer.borderColor = UIColor.black.cgColor
        
        // group
        selectGroupBtn.layer.cornerRadius = 5
        selectGroupBtn.layer.borderWidth = 1
        selectGroupBtn.layer.borderColor = UIColor.black.cgColor
        
        // datepicker
        // to be coded
        
    }
    
    // group dropdown
    @IBAction func onClickSelectProductGroupBtn(_ sender: UIButton) {
        groupDropDown.dataSource = ["Grocery", "Clothes", "Electronic"]
        groupDropDown.anchorView = sender
        groupDropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        groupDropDown.show()
        groupDropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    // return selected group
    func getGroup() -> String? {
        return groupDropDown.selectedItem
    }
    
    // urgency dropdown
    @IBAction func onClickSelectUrgencyBtn(_ sender: UIButton) {
        urgencyDropDown.dataSource = ["High", "Medium", "Low"]
        urgencyDropDown.anchorView = sender
        urgencyDropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        urgencyDropDown.show()
        urgencyDropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    // return selected urgency
    func getUrgency() -> String? {
        return urgencyDropDown.selectedItem
    }
    
    func isDouble(s:String) -> Bool {
        return !(s.isEmpty) && s.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    // cancel and return to homepage
    @IBAction func onClickCancel(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // save and return to homepage
    @IBAction func onClickSave(_ sender: UIButton) {
        let groupName = getGroup()
        let u = getUrgency()
        let pName = productNameBox.text
        let q = quantityBox.text!
        let p = priceBox.text!
        let date = selectDate.date
        if (groupName == nil || u == nil || pName == nil || isDouble(s: p) || Int32(q) == nil) {
            // add alert warning later
            return
        } else {
            self.createItem(name: pName!, group: groupName!, quantity: Int32(q)!, price: Double(p)!, urgency: u!, pDate: date)
        }
    }
    
    // function to create item
    func createItem(name:String, group:String, quantity:Int32, price:Double, urgency:String, pDate:Date? = nil){
        let newItem = Product(context: context)
        newItem.name = name
        newItem.group = group
        newItem.unitPrice = price
        newItem.quantity = quantity
        newItem.urgency = urgency
        newItem.createdDate = Date()
        newItem.purchasedDate = pDate
        do {
            try context.save()
        } catch {
            
        }
    }
    
    // function to update item
    func updateItem(item:Product, newName:String, newGroup:String, newQuantity:Int32, newPrice:Double, newUrgency:String, purchasedDate:Date){
        item.name = newName
        item.group = newGroup
        item.quantity = newQuantity
        item.urgency = newUrgency
        item.unitPrice = newPrice
        item.purchasedDate = purchasedDate
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
