//
//  Media+CoreDataProperties.swift
//  Current
//
//  Created by Tyler Dakin on 10/25/20.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var id: String?
    @NSManaged public var overview: String?
    @NSManaged public var portraitImgName: String?
    @NSManaged public var title: String?
    @NSManaged public var userTags: Set<String>?
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedOverview: String {
        overview ?? "Description not found."
    }
    
    public var wrappedImgLink: String {
        portraitImgName ?? "No URL Found"
    }
    
    public var wrappedID: String {
        id ?? "INVALID-ID"
    }
    
    public var wrappedUserTags: Set<String> {
        guard let set = userTags else { return [] }
        
        return set
    }

}

extension Media : Identifiable {

}
