//
//  AlbumTableViewCell.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/3/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var artworkImageView =  UIImageView()
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    
    func configure(with album: AlbumAPI.AlbumResult){
        titleLabel.text = album.name
        artistLabel.text = album.artistName
        //TODO: NO FORCE UNWRAP
        if let url = URL(string: album.artworkUrl100) {
            artworkImageView.downloadImage(from: url)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewWithAutoLayout(artworkImageView)
        addSubviewWithAutoLayout(titleLabel)
        addSubviewWithAutoLayout(artistLabel)
        initConstraintsAndConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraintsAndConfigurations() {
        //artworkImageVew
        NSLayoutConstraint.activate([
            artworkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            artworkImageView.heightAnchor.constraint(equalToConstant: 64),
            artworkImageView.widthAnchor.constraint(equalTo: artworkImageView.heightAnchor),
            artworkImageView.topAnchor.constraint(equalTo: self.topAnchor),
            artworkImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        //titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        styleLabel(titleLabel)
      
        
        //artistLabel
        NSLayoutConstraint.activate([
            artistLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            artistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        styleLabel(artistLabel)
    }
    
    func styleLabel(_ label: UILabel) {
        label.numberOfLines = 1
        label.allowsDefaultTighteningForTruncation = true
        if let arial = UIFont(name: "ArialMT", size: 17) {
            label.font = arial
        }
    }
    
}

//TODO: movoe to extensions
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
