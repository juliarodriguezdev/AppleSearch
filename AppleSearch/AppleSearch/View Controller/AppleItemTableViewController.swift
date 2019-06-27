//
//  AppleItemTableViewController.swift
//  AppleSearch
//
//  Created by Julia Rodriguez on 6/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class AppleItemTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // source of truth
    var appleItems: [AppleItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* AppleItemController.fetchAppleItemFor(term: "Nickelback") { (appleItemsFromCompletion) in
            if let unwrappedAppleItems = appleItemsFromCompletion {
                self.appleItems = unwrappedAppleItems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } */
      }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return appleItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appleItemCell", for: indexPath) as? AppleItemTableViewCell else { return UITableViewCell()}

        // Configure the cell...
        let appleItem = appleItems[indexPath.row]
        
        cell.trackLabel.text = appleItem.track
        cell.artistLabel.text = appleItem.artist
        cell.albumLabel.text = appleItem.album

        AppleItemController.fetchImageFor(appleItem: appleItem) { (image) in
            DispatchQueue.main.async {
                cell.itemImageView.image = image
            }
        }
        return cell
    }
}

extension AppleItemTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        AppleItemController.fetchAppleItemFor(term: searchTerm) { (appleItemsFromCompletion) in
            if let unwrappedAppleItems = appleItemsFromCompletion {
                self.appleItems = unwrappedAppleItems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
}
