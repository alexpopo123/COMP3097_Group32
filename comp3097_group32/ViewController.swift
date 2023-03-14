//
//  ViewController.swift
//  comp3097_group32
//
//  Created by Tech on 2023-02-23.
//

import UIKit
import DropDown

struct Product {
    let name: String
    let group: String
    let quantity: Int
    let urgency: String
    let unitPrice: Double
    let createDate: String
    let purchaseDate: String
}

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var afterTaxLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var percentageBtn: UIButton!
    @IBOutlet weak var selectUrgencyBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectGroupBtn: UIButton!
    @IBOutlet weak var roundBtnAdd: UIButton!
    @IBOutlet weak var roundBtnGroup: UIButton!
    
    let searchController = UISearchController()
    let data: [Product] = [
        Product(name: "Apple", group: "Grocery", quantity: 2, urgency: "High", unitPrice: 1.05, createDate: "2023/2/23", purchaseDate: ""),
        Product(name: "T-shirt", group: "Clothes", quantity: 3, urgency: "Medium", unitPrice: 9.99, createDate: "2023/2/23", purchaseDate: "2023/2/24"),
        Product(name: "Orange", group: "Grocery", quantity: 1, urgency: "Low", unitPrice: 2.6, createDate: "2023/2/28", purchaseDate: ""),
        Product(name: "Jeans", group: "Clothes", quantity: 5, urgency: "Medium", unitPrice: 49.99, createDate: "2023/3/9", purchaseDate: "2023/3/28"),
        Product(name: "Laptop", group: "Electronic", quantity: 1, urgency: "High", unitPrice: 1111.05, createDate: "2023/3/23", purchaseDate: ""),
        Product(name: "Garlic", group: "Grocery", quantity: 1, urgency: "Low", unitPrice: 0.99, createDate: "2023/3/6", purchaseDate: "")
    ]
    
    var filteredData = [Product]()
    
    let dropDown = DropDown()
    let groupDropdown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
        tableView.dataSource = self
        selectUrgencyBtn.layer.cornerRadius = 5
        selectUrgencyBtn.layer.borderWidth = 1
        selectUrgencyBtn.layer.borderColor = UIColor.black.cgColor
        selectGroupBtn.layer.cornerRadius = 5
        selectGroupBtn.layer.borderWidth = 1
        selectGroupBtn.layer.borderColor = UIColor.black.cgColor
        percentageBtn.layer.cornerRadius = 5
        percentageBtn.layer.borderWidth = 1
        percentageBtn.layer.borderColor = UIColor.black.cgColor
        
        roundBtnAdd.layer.cornerRadius = roundBtnAdd.frame.width / 2
        roundBtnAdd.layer.masksToBounds = true
        
        roundBtnGroup.layer.cornerRadius = roundBtnGroup.frame.width / 2
        roundBtnGroup.layer.masksToBounds = true
        
        var total = 0.0
        var tax = 0.13
        for product in data {
            total += Double(product.quantity) * product.unitPrice
        }
        func initSearchController(){
            searchController.loadViewIfNeeded()
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.returnKeyType = UIReturnKeyType.done
            definesPresentationContext = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.placeholder = "Enter product name"
            searchController.searchBar.scopeButtonTitles = ["All", "Purchased", "Unpurchased"]
            searchController.searchBar.delegate = self
        }
        costLabel.text = String(format:"%.2f", total)
        taxLabel.text = String(format:"%.2f", total * tax)
        afterTaxLabel.text = String(format:"%.2f", total * (1 + tax))
    }

    @IBAction func onClickPurchased(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func onClickSelectGroup(_ sender: UIButton) {
        groupDropdown.dataSource = ["Grocery", "Clothes", "Electronic"]
        groupDropdown.anchorView = sender
        groupDropdown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        groupDropdown.show()
        groupDropdown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onClickSelectUrgency(_ sender: UIButton) {
        dropDown.dataSource = ["High", "Medium", "Low"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x:0, y:sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = {
            [weak self] (index:Int, item:String) in guard let _ = self else {return}
            sender.setTitle(item, for: .normal)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        filteredData = data.filter{
            item in
            let scopeMatch = (scopeButton == "All")
                    // || if (item.purchaseDate == "") {scopeButton = "Unpurchased"})
            if(searchController.searchBar.text != "") {
                let searchTextMatch = item.name.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive){
            return filteredData.count
        }
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product: Product!
        if(searchController.isActive) {
            product = filteredData[indexPath.row]
        }else {
            product = data[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.update(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dest = segue.destination as! DetailViewController
            dest.product = data[indexPath!.row]
        }
        
        
    }
    
}



