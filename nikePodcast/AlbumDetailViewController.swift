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
   
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var album: AlbumAPI.AlbumResult!
    
    override func viewDidLoad() {
        configure()
    }
    public static func create(album: AlbumAPI.AlbumResult) -> AlbumDetailViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "AlbumDetailViewController") as! AlbumDetailViewController
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
    
    
    
    
}
