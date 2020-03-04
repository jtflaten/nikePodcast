//
//  Models.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import Foundation

struct Response : Decodable {
    let feed: Feed
}

struct Feed : Decodable {
    let results: [AlbumResult]
}

struct AlbumResult : Decodable {
    let id: String
    let artistName: String
    let name: String
    let artworkUrl100: String
    let genres: [Genre]
    let copyright: String
    let releaseDate: String
    let url: String
}

struct Genre: Decodable {
    let name: String
}
