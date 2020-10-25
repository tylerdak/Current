//
//  Platforms.swift
//  Current
//
//  Created by Tyler Dakin on 9/6/20.
//

import Foundation

let platforms: [String : Platform] = ["movies":movieType, "shows":showType, "games":gameType, "books":bookType]
var sortedPlatforms: Array<Platform> {
    return Array<Platform>(platforms.values).sorted { (platform1, platform2) -> Bool in
        platform1.title < platform2.title
    }
}

struct Platform: Hashable, Identifiable {
    static func == (lhs: Platform, rhs: Platform) -> Bool {
        return lhs.title == rhs.title && lhs.id == rhs.id
    }
    
    let title: String
    let systemIcon: String
    let id: String
    let tags: [String]
    
    init(title: String, systemIcon: String, tags: [String]) {
        self.title = title
        self.id = title
        self.systemIcon = systemIcon
        self.tags = tags
    }
}

let movieType = Platform(title: "Movies", systemIcon: "film", tags: ["Watch Later", "Disliked", "Loved", "Watched", "All"])
let showType = Platform(title: "Shows", systemIcon: "tv", tags: ["Watch Later", "Disliked", "Loved", "Watching", "Finished", "Finish Later", "Abandoned", "All"])
let gameType = Platform(title: "Games", systemIcon: "gamecontroller", tags: ["Play Later", "Disliked", "Loved", "Playing", "Finished", "On the Shelf", "Abandoned", "All"])
let bookType = Platform(title: "Books", systemIcon: "book", tags: ["Read Later", "Disliked", "Loved", "Reading", "Finished", "On the Shelf", "Abandoned", "All"])

struct MediaType: Hashable, Identifiable {
    let title: String
    let portraitImgName: String
    let id: String
    let overview: String
    let userTags: [String]
    
    init(title: String, imgLoc: String, description: String, id: String) {
        self.title = title
        self.id = title + id
        self.portraitImgName = imgLoc
        self.userTags = [String]()
        
        self.overview = description
    }
}
