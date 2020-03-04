//
//  ViewController.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/3/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    var albums: [AlbumAPI.AlbumResult] = []
    let albumClient = AlbumAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumClient.fetchAlbums() { result in
            switch result {
            case .success(let response):
                self.albums = response.feed.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
          let searchResult = albums[indexPath.row]
          cell.configure(with: searchResult)
          return cell
      }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumDetailViewController.create(album: albums[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

