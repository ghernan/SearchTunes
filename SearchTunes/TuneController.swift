//
//  ViewController.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/4/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TuneController: UIViewController {
    var tracks: [Track] =  []
    var filteredTracks: [Track] = []
    let trackManager = TuneManager()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.hidesWhenStopped = false
        configureSearchBar()
        configureActivityIndicator()
        getTunes()
    }
    
    func configureSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate  = self
    }
    func configureActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x:0, y:0, width: 80, height:80)
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        tableView.addSubview(activityIndicator)
        
    }
    
    func getTunes(withFilter filter: String = ""){
        
        
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.white
        trackManager.persistTunes(withFilter: filter,
                                  completionHandler: { (tracksFromServer) in
                                    var tracks: [Track] = self.trackManager.getCachedTracks(withFilter: filter)
                                    tracks.append(contentsOf: tracksFromServer)
                                    if filter.isEmpty{
                                        self.tracks = tracks
                                    }else{
                                        self.filteredTracks = tracks
                                    }
                                    self.tableView.reloadData()
                                    self.activityIndicator.stopAnimating()
                                    
                                },
                                  errorHandler: { (error) in
                                    print("DataTask Error: \(error.localizedDescription)\n")
                                })
    }
}

extension TuneController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        getTunes(withFilter: searchController.searchBar.text!)
    }
    

}

extension TuneController: UISearchBarDelegate{
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }

}
extension TuneController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty)!{
            return filteredTracks.count
        }
        
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell")! as! TrackCell
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty)!{
            cell.configureCell(WithTrack: filteredTracks[indexPath.row])
        }else{
            cell.configureCell(WithTrack: tracks[indexPath.row])
        }
        return cell
    }
}

