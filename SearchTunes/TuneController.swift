//
//  ViewController.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/4/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TuneController: UIViewController {
    var selectedTrack: Track?
    var tracks: [Track] =  []    
    var cachedFlag:Bool = true
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
    
    func getTunes(){
        let filter: String = searchController.searchBar.text!
        print("updating")
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.white
        trackManager.persistTunes(withFilter: filter,
                                  completionHandler: { (tracksFromServer) in
                                    var tracks: [Track] = self.trackManager.getCachedTracks(withFilter: filter)
                                    let filteredTracksFromServer = tracksFromServer.filter { !tracks.contains($0)}
                                    tracks.append(contentsOf: filteredTracksFromServer)
                                    if filter.isEmpty{
                                        
                                        self.tracks = tracks
                                    }else{
                                        self.filteredTracks = tracks
                                    }
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        self.activityIndicator.stopAnimating()
                                    }
                                    
                                    
                                },
                                  errorHandler: { (error) in
                                    print("DataTask Error: \(error.localizedDescription)\n")
                                })
    }
}


extension TuneController: UISearchBarDelegate{
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
        cachedFlag = true
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cachedFlag = false
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getTunes), object: nil)
        self.perform(#selector(getTunes), with: nil, afterDelay: 1.5)
    }

}
extension TuneController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let track = cachedFlag ? tracks[index] : filteredTracks[index]
        selectedTrack = track
        performSegue(withIdentifier: "toDetailVC", sender: self)
    
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! TuneDetailsController
        detailVC.track = selectedTrack
    }
    
}

extension TuneController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty)! && !cachedFlag{
            return filteredTracks.count
        }
        
        
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reusableIdentifier)! as! TrackCell
        let index = indexPath.row
        let track = (searchController.isActive && !(searchController.searchBar.text?.isEmpty)!) ? filteredTracks[index] : tracks[index]
        cell.configureCell(WithTrack: track)
        return cell
    }
    
}

