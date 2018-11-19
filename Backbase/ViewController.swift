//
//  ViewController.swift
//  Backbase
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import UIKit
class ViewController: UIViewController, UISearchBarDelegate {
    
    var tableView: UITableView = UITableView()
    
    //preprocessed the data into two array of struct. One to store all values and another to store the intermediate filtered value.
    //This is more efficient because the filtered data only stores the filtered list rather than copy the entire data set
    //this filtered data model is necessary in order to store the index of the cell which stores the location of the lat/lon coordintes to disply in the detail view
    //the filtered data is originally empty in order to avoid duplicating the entire list
    var model: [Location] = []
    var filteredTableData: [Location] = []
    var valueToPass = ""
    var isFiltered = false
    let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isFiltered = false
            filteredTableData = []
        }
        else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
            isFiltered = true
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    func filterTableView(ind:Int,text:String) {
        filteredTableData = model.filter({ (mod) -> Bool in
            return mod.name.lowercased().hasPrefix(text.lowercased())
        })
    }
    
    func searchBarSetup() {
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initializeInterfaceElements()
        self.autolayoutInterfaceElements()
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                model = try decoder.decode([Location].self, from: data).sorted(by: { $0.name < $1.name })
            } catch {
                print(error)
            }
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
        self.searchBarSetup()
    }
    
    func initializeInterfaceElements() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    func autolayoutInterfaceElements() {
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == true {
            return self.filteredTableData.count
        }
        else {
            return self.model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currentLocation: Location? = nil
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "personCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "personCell")
        }
        if isFiltered == true {
            currentLocation  = self.filteredTableData[indexPath.row]
        }
        else {
            currentLocation = self.model[indexPath.row]
        }
        cell!.textLabel?.text = (currentLocation?.name)! + ", " + (currentLocation?.country)!
        
        cell!.accessoryType = .disclosureIndicator
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        
        let detailVC: DetailViewController = DetailViewController()
        if isFiltered == true {
            let currentLocation:Location = self.filteredTableData[indexPath.row]
            detailVC.lat = currentLocation.coord.lat
            detailVC.lon = currentLocation.coord.lon
            detailVC.city = currentLocation.name
            detailVC.country = currentLocation.country
        }
        else  {
            let currentLocation:Location = self.model[indexPath.row]
            detailVC.lat = currentLocation.coord.lat
            detailVC.lon = currentLocation.coord.lon
            detailVC.city = currentLocation.name
            detailVC.country = currentLocation.country
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}



