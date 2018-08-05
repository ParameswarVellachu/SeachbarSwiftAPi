//
//  ViewController.swift
//  SeachbarSwiftAPi
//
//  Created by Veera Reddy on 8/4/18.
//  Copyright © 2018 Parameswar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var models = [UserInfo]()
//    var models = [Model]()
    var filteredModels = [UserInfo]()


    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.call_WebService()
        self.tableView.tableHeaderView = UIView()
        setupSearchController()
    }
    
    //MARK:- WEB SERVICE
    func call_WebService() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
//                print(jsonResponse) //Response result

                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                print(jsonArray)
                
                
                for dic in jsonArray{
                    self.models.append(UserInfo(dic)) // adding now value in Model array
                }
                print(self.models[0].userId) // 1211
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView Delegate & DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let model: UserInfo
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredModels[indexPath.row]
        } else {
            model = models[indexPath.row]
        }
        cell.textLabel!.text = "\(model.id)"
        cell.detailTextLabel!.text = model.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredModels.count
        }
        
        return models.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Searchbar

    func setupSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = "Search by movie name or genre"
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self;
        
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel")
//    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredModels = models.filter({( model : UserInfo) -> Bool in
            return model.title.lowercased().contains(searchText.lowercased()) || "\(model.id)".lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
   
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
//        filtered = (headerItemSetEntityset?.entities)!
        self.tableView.reloadData()
        
        
    }
}

