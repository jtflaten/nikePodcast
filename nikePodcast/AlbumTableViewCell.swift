//
//  AlbumTableViewCell.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/3/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func configure(with album: AlbumAPI.AlbumResult){
        titleLabel.text = album.name
        artistLabel.text = album.artistName
        //TODO: NO FORCE UNWRAP
        if let url = URL(string: album.artworkUrl100) {
            artworkImageView.downloadImage(from: url)
        }
    }
    
 
}

extension UIImageView {
    func downloadImage(from url: URL) {
         print("Download Started")
         getData(from: url) { data, response, error in
             guard let data = data, error == nil else { return }
             print(response?.suggestedFilename ?? url.lastPathComponent)
             print("Download Finished")
             DispatchQueue.main.async() { [weak self] in
                 guard let self = self else {return}
                 self.image = UIImage(data: data)
             }
         }
     }
     
     func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
         URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
     }
}
