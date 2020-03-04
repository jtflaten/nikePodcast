//
//  AlbumDetailViewController.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/3/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailViewController: UIViewController {
   
    
    var albumImageView = UIImageView()
    var artistLabel = UILabel()
    var albumLabel = UILabel()
    var genreLabel = UILabel()
    var releaseDateLabel = UILabel()
    var copyrightLabel = UILabel()
    var buyButton = UIButton()
    
    var album: AlbumAPI.AlbumResult!
    
    override func viewDidLoad() {
        initSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    public static func create(album: AlbumAPI.AlbumResult) -> AlbumDetailViewController{
        let vc = AlbumDetailViewController()
        vc.view.backgroundColor = .white
        vc.album = album
        return vc
    }
    
    func configure() {
        artistLabel.text = album.artistName
        albumLabel.text = album.name
        genreLabel.text = buildGenreString(with: album.genres)
        releaseDateLabel.text = album.releaseDate
        copyrightLabel.text = album.copyright
        if let url = URL(string: album.artworkUrl100) {
            albumImageView.downloadImage(from: url)
        }
    }
    
    func buildGenreString(with genres : [AlbumAPI.Genre]) -> String {
        var string = ""
        for (index, genre) in genres.enumerated() {
            string.append(genre.name)
            if index != (genres.count - 1) {
                string.append(", ")
            }
        }
        return string
    }
    
    fileprivate func addSubviewWithAutoLayout(_ vw: UIView) {
        vw.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vw)
    }
    
    func initSubviews(){
        albumImageView = UIImageView()
        addSubviewWithAutoLayout(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            albumImageView.heightAnchor.constraint(equalToConstant: 240),
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor)
        ])
        
        
        addSubviewWithAutoLayout(artistLabel)
        artistLabel.numberOfLines = 0
        addLabelStandardConstraints(view: artistLabel, viewAbove: albumImageView)
        
        
        addSubviewWithAutoLayout(albumLabel)
        albumLabel.numberOfLines = 0
        addLabelStandardConstraints(view: albumLabel, viewAbove: artistLabel)
        
        
        addSubviewWithAutoLayout(genreLabel)
        genreLabel.numberOfLines = 0
        addLabelStandardConstraints(view: genreLabel, viewAbove: albumLabel)
        
        
        addSubviewWithAutoLayout(releaseDateLabel)
        releaseDateLabel.numberOfLines = 0
        addLabelStandardConstraints(view: releaseDateLabel, viewAbove: genreLabel)
        
        
        addSubviewWithAutoLayout(copyrightLabel)
        copyrightLabel.numberOfLines = 0
        addLabelStandardConstraints(view: copyrightLabel, viewAbove: releaseDateLabel)
        
        addSubviewWithAutoLayout(buyButton)
        NSLayoutConstraint.activate([
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buyButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buyButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        buyButton.roundAllCorners()
        buyButton.backgroundColor = .blue
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.setTitle("See in Apple Music", for: .normal)
        buyButton.addTarget(self, action: #selector(handleBuyButtonTap), for: .touchUpInside)
    }
    
    func addLabelStandardConstraints(view: UIView, viewAbove: UIView){
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: 12)
        ])
    }
    
    
     @objc func handleBuyButtonTap() {
//        TODO: fix consistent simulator issues
        let buyString = album.url.replacingOccurrences(of: "https", with: "itms")
        guard let httpsUrl = URL(string: album.url) else {
            presentDefaultAlertView(title: "Error", message: "there was an error find the album in the Music store", dismissalMessage: nil)
            return
        }
        guard let itmsUrl = URL(string: buyString) else {
            presentDefaultAlertView(title: "Error", message: "There was an error reading the url", dismissalMessage: nil)
            return
        }
        
        if UIApplication.shared.canOpenURL(itmsUrl) {
            UIApplication.shared.open(itmsUrl, options: [:], completionHandler: nil)
        } else {
            if UIApplication.shared.canOpenURL(httpsUrl) {
                UIApplication.shared.open(httpsUrl, options: [:], completionHandler: nil)
            } else {
                presentDefaultAlertView(title: "No Apple Music", message: "it appears you do not have apple music on this phone", dismissalMessage: nil)
            }
        }
   
        
    }
    
    
    
}
