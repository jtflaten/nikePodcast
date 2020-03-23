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
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var album: AlbumResult?
    
    override func viewDidLoad() {
        initSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        styleLabels()
    }
    
    public static func create(album: AlbumResult) -> AlbumDetailViewController{
        let vc = AlbumDetailViewController()
        vc.view.backgroundColor = .white
        vc.album = album
        return vc
    }
    
    func configure() {
        guard let album = album else {
            presentDefaultAlertView(title: "Error", message: "There was an error gettig the data", dismissalMessage: "OK")
            self.navigationController?.popViewController(animated: true)
            return
        }
        artistLabel.text = album.artistName
        albumLabel.text = album.name
        genreLabel.text = buildGenreString(with: album.genres)
        releaseDateLabel.text = album.releaseDate
        copyrightLabel.text = album.copyright
        if let url = URL(string: album.artworkUrl100) {
            albumImageView.downloadImage(from: url)
        }
    }
    
    func buildGenreString(with genres : [Genre]) -> String {
        var string = ""
        for (index, genre) in genres.enumerated() {
            string.append(genre.name)
            if index != (genres.count - 1) {
                string.append(", ")
            }
        }
        return string
    }
    
    fileprivate func setUpLabel(_ label: UILabel, underneath viewAvove: UIView, textStyle: UIFont.TextStyle = .body) {
        self.contentView.addSubviewWithAutoLayout(label)
        label.numberOfLines = 0
        addLabelStandardConstraints(view: label, viewAbove: viewAvove)
        label.textAlignment = .center
        label.font = label.getScaledFont(forFont: "ArialMT", textStyle: textStyle)
    }
    
    private func styleLabels() {
        setUpLabel(artistLabel, underneath: albumImageView)
        setUpLabel(albumLabel, underneath: artistLabel)
        setUpLabel(genreLabel, underneath: albumLabel)
        setUpLabel(releaseDateLabel, underneath: genreLabel)
        setUpLabel(copyrightLabel, underneath: releaseDateLabel, textStyle: .caption1)
    }
    
    func initSubviews(){
        
        self.view.addSubviewWithAutoLayout(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        
        self.scrollView.addSubviewWithAutoLayout(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        self.contentView.addSubviewWithAutoLayout(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            albumImageView.heightAnchor.constraint(equalToConstant: 240),
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor)
        ])
        
        styleLabels()
        setUpBuyButton()
    }
    
    func addLabelStandardConstraints(view: UIView, viewAbove: UIView){
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: viewAbove.bottomAnchor, constant: 12)
        ])
    }
    
    func setUpBuyButton() {
        self.contentView.addSubviewWithAutoLayout(buyButton)
        NSLayoutConstraint.activate([
            buyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buyButton.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buyButton.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buyButton.topAnchor.constraint(greaterThanOrEqualTo: copyrightLabel.bottomAnchor, constant: 20),
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        buyButton.roundAllCorners()
        buyButton.backgroundColor = .blue
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.setTitle("See in Apple Music", for: .normal)
        buyButton.addTarget(self, action: #selector(handleBuyButtonTap), for: .touchUpInside)
    }
     @objc func handleBuyButtonTap() {
    /* NOTE TO REVIEWER: for this method, I would be seeking some outside help from a senior/peer:
         I've run into an issue where the simulator can not open the album in the Music app or the iTunes
         store, because these apps are not on the Simulator, and even safari on the simulator does not consistently open
         the link. But when run on a device, the behavior is as expected, it does attempt to open in the iTunes Store.*/
        guard let album = album else {
            presentDefaultAlertView(title: "Error", message: "There was an error gettig the data", dismissalMessage: "OK")
            self.navigationController?.popViewController(animated: true)
            return
        }
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




