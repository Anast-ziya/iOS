//
//  Post.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import Foundation

struct JSONData: Codable {
    let data: FirstData
}

struct  FirstData: Codable {
    let children: [Child]
}

struct Child: Codable {
    let data: RedditData
}

struct RedditData: Codable {
    let title: String
    let thumbnail: String
    let url: String
    let id: String
}
