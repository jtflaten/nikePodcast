//
//  MockAPI.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/4/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import Foundation
@testable import ShoeGaze


class MockAPI: AlbumAPI {
        let fisrt = AlbumResult( id : "1493581254",
                                 artistName : "Various Artists",
                                 name : "Birds of Prey: The Album",
                                 artworkUrl100 : "https://is5-ssl.mzstatic.com/image/thumb/Music123/v4/50/e7/00/50e7001e-71d8-b7f4-9daf-4ad866bf7158/075679834485.jpg/200x200bb.png",
                                 genres :[Genre(name: "Soundtrack"), Genre(name: "Music")],
                                 copyright : "℗ 2020 Atlantic Recording Corporation and Warner Bros. Entertainment Inc.",
                                 releaseDate : "2020-02-07",
                                 url : "https://music.apple.com/us/album/birds-of-prey-the-album/1493581254?app=music")
        let second = AlbumResult ( id : "1491557690",
                                   artistName : "J.I the Prince of N.Y",
                                   name : "Hood Life Krisis Vol. 1",
                                   artworkUrl100 : "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/c0/07/85/c00785dd-08eb-2538-21e2-baeb00293e93/13160.jpg/200x200bb.png",
                                   genres : [Genre(name: "Hip-Hop/Rap"), Genre(name: "Music")],
                                   copyright : "℗ 2019 G*STARR ENT.",
                                   releaseDate : "2019-10-11",
                                   url : "https://music.apple.com/us/album/hood-life-krisis-vol-1/1491557690?app=music")
        let third = AlbumResult( id : "1484936940",
                                 artistName : "Kanye West",
                                 name : "JESUS IS KING",
                                 artworkUrl100 : "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/21/fd/d3/21fdd3d4-0c00-53ef-3903-d0569c49a812/19UMGIM89397.rgb.jpg/200x200bb.png",
                                 genres : [Genre(name: "Hip-Hop/Rap"), Genre(name: "Music")],
                                 copyright : "℗ 2019 Getting Out Our Dreams II, LLC Distributed By Def Jam,  A Division of UMG Recordings, Inc.",
                                 releaseDate : "2019-10-25",
                                 url : "https://music.apple.com/us/album/jesus-is-king/1484936940?app=music")
    
    override func fetchAlbums(completion: @escaping (Result<Response, APIError>) -> Void) {
        let shortlistt = [fisrt,second,third]
        let resp = Response(feed: Feed(results: shortlistt))
        completion(.success(resp))
    }
}
