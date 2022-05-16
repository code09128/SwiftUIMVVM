//
//  SearchResponse.swift
//  SwiftUISearchMusicMVVM
//
//  Created by Dustin on 2022/3/21.
//

import Foundation

// MARK: - Main Object
struct SearchResponse: Codable{
    let resultCount:Int?
    let results: [SearchResult]?
}

// MARK: - Result Item
struct SearchResult:Codable{
    var trackId:Int?
    var trackName:String?
    var collectionName:String?
    var trackPrice: Double?
    var currency: String?
    var artworkUrl60: String?
}

// MARK: - Example Item
extension SearchResult{
    
    static var example:SearchResult{
        SearchResult(
            trackName: "Home",
            collectionName: "Joe Satriani",
            trackPrice: 1.29,
            currency: "USD",
            artworkUrl60: "https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/c4/c1/a2/c4c1a2ad-8777-20d8-a4ef-ecddabe0de1b/source/60x60bb.jpg"
        )
    }
}
