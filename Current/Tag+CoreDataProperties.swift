//
//  Tag+CoreDataProperties.swift
//  Current
//
//  Created by Tyler Dakin on 10/25/20.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tagName: String?
    @NSManaged public var media: NSSet?
    
    public var wrappedTagName: String {
        tagName ?? "TagNotFound"
    }
    
    public var wrappedMediaArray: [Media] {
        let set = media as? Set<Media> ?? []
        
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }

}

// MARK: Generated accessors for media
extension Tag {

    @objc(addMediaObject:)
    @NSManaged public func addToMedia(_ value: Media)

    @objc(removeMediaObject:)
    @NSManaged public func removeFromMedia(_ value: Media)

    @objc(addMedia:)
    @NSManaged public func addToMedia(_ values: NSSet)

    @objc(removeMedia:)
    @NSManaged public func removeFromMedia(_ values: NSSet)

}

extension Tag : Identifiable {

}
