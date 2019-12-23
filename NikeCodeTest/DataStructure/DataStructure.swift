//
//  DataStructure.swift
//  NikeCodeTest
//
//  Created by KIRILL CHUMAK on 12/18/19.
//  Copyright © 2019 Kirill Chumak. All rights reserved.
//


// MARK: - AlbumData
struct AlbumData: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let artistName, releaseDate, name: String
    let copyright: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

struct Genre: Decodable {
    let name: String
}

