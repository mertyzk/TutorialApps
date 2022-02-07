//
//  ViewController.swift
//  SearchBarTableView
//
//  Created by Macbook Air on 6.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var countries = [String]()
    var searchResultCountries = [String]()
    
    var searchStatus = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = ["Turkey","France","Germany","Egypt","Greece","Italy","Spain","England","Norway","Sweden"]
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchStatus{
            return searchResultCountries.count
        }else{
            return countries.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ulkelerHucre", for: indexPath)

        if searchStatus{
            cell.textLabel?.text = searchResultCountries[indexPath.row]
            
        }else{
            cell.textLabel?.text = countries[indexPath.row]
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        if searchStatus{
            print("Selected country: \(searchResultCountries[indexPath.row])")
            
        }else{
            print("Selected country: \(countries[indexPath.row])")
        }
    }
    
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search result: \(searchText)")
        
        if searchText == "" {
            searchStatus = false
        }else{
            searchStatus = true
            
            searchResultCountries = countries.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        
        tableView.reloadData()
        
    }
    
}
