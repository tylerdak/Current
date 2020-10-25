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
    @NSManaged public var portraitImgName: String?
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var userTags: NSSet?
    
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
    
    public var wrappedUserTags: [Tag] {
        let set = userTags as? Set<Tag> ?? []
        
        return set.sorted {
            $0.wrappedTagName < $1.wrappedTagName
        }
    }

}

// MARK: Generated accessors for userTags
extension Media {

    @objc(addUserTagsObject:)
    @NSManaged public func addToUserTags(_ value: Tag)

    @objc(removeUserTagsObject:)
    @NSManaged public func removeFromUserTags(_ value: Tag)

    @objc(addUserTags:)
    @NSManaged public func addToUserTags(_ values: NSSet)

    @objc(removeUserTags:)
    @NSManaged public func removeFromUserTags(_ values: NSSet)

}

extension Media : Identifiable {

}
