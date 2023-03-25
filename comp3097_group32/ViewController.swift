//
//  ViewController.swift
//  comp3097_group32
//
//  Created by Tech on 2023-02-23.
//

import UIKit
import DropDown

struct Header {
    let col1: String
    let col2: String
    let col3: String
}

let heightOfHeader: CGFloat = 44

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // homepage element
    @IBOutlet weak var afterTaxLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var percentageBtn: UIButton!
    @IBOutlet weak var selectUrgencyBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectGroupBtn: UIButton!
    @IBOutlet weak var roundBtnAdd: UIButton!
    @IBOutlet weak var roundBtnGroup: UIButton!
    
    // connect to core data
    let context = (UIApplication.shared.delegate as! AppDelegate).presistanceContainer.viewContext
    
    // list of model entity Item
    private var products = [Product]()
    
    // table search bar
    let searchController = UISearchController()
    
    // list of filter data -- currently empty
    var filteredData = [Product]()
    
    // dropdown
    let dropDown = DropDown()
    
    // group dropdown
    let groupDropdown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // call to funtion to get all items from core data
        getAllItems()
        
        // call to function that initialize search bar
        initSearchController()
        
        // table view config
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "headerCell")
        
        // rounded buttons
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
        
        // cost
        var total = 0.0
        
        // tax
        var tax = 0.13
        
        // calculate total cost
        for product in products {
            total += Double(product.quantity) * product.unitPrice
        }
        
        // function to initialize search bar
        func initSearchController(){
            searchController.loadViewIfNeeded()
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.returnKeyType = UIReturnKeyType.done
            definesPresentationContext = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.showsScopeBar = true
            searchController.searchBar.placeholder = "Enter product name"
            searchController.searchBar.scopeButtonTitles = ["All", "Purchased", "Unpurchased"]
            searchController.searchBar.delegate = self
        }
        
        // format and display cost, tax, and total cost
        costLabel.text = String(format:"%.2f", total)
        taxLabel.text = String(format:"%.2f", total * tax)
        afterTaxLabel.text = String(format:"%.2f", total * (1 + tax))
    }
    
    // create dropdown for group
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
    
    // create dropdown for urgency
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
    
    // update table as you type in search bar
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    // filter table - not working...
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        filteredData = products.filter{
            item in
            let scopeMatch = (scopeButton == "All") //||
            //if (item.purchaseDate == "") {scopeButton = "Unpurchased"})
            if(searchController.searchBar.text != "") {
                let searchTextMatch = item.name?.lowercased().contains(searchText.lowercased())
                return scopeMatch && (searchTextMatch != nil)
            } else {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }
    
    // to get items from core data
    func getAllItems(){
        do {
            products = try context.fetch(Product.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // error
        }
    }


}


// display table view
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive){
            return filteredData.count
        }
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product: Product!
        if(searchController.isActive) {
            product = filteredData[indexPath.row]
        }else {
            product = products[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.update(with: product)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightOfHeader
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Header"
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell") as! HeaderTableViewCell
        let headerView = UIView()
        
        let headerCell = HeaderTableViewCell(style: .default, reuseIdentifier: "headerCell")
        let header = Header(col1: "Product", col2: "Quantity", col3: "Urgency")
        headerCell.setup(header: header)
        return headerCell.contentView
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // go to product detail page
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dest = segue.destination as! DetailViewController
            dest.product = products[indexPath!.row]
        }
        
        
    }
    
}



