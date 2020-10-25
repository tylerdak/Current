//
//  ContentView.swift
//  Current
//
//  Created by Tyler Dakin on 9/6/20.
//

import Foundation
import SwiftUI

struct PlatformView: View {
    let platform: Platform
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    @FetchRequest(entity: Tag.entity(), sortDescriptors: []) var tagGroup: FetchedResults<Tag>
    
    @State private var showingError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingSearch = false
    @State private var searchResults: [Media] = []
    var body: some View {
        List {
            ForEach(platform.tags, id: \.self) { tag in
                HorizontalCollectionView(title: tag, mediaGroup: mediaGroup.filter({ (media) -> Bool in
                    media.wrappedUserTags.contains { (tagObject) -> Bool in
                        tagObject.wrappedTagName == tag
                    }
                }))
            }
        }
        .padding(.top, 5)
        .navigationTitle(platform.title)
        .navigationBarItems(trailing:
            Button(action: {
                showingSearch.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaleEffect(CGFloat(1.2))
            })
        )
        
        // Search Window
        .sheet(isPresented: $showingSearch, onDismiss: {
            searchResults = []
        }) {
            SearchWindow(platform: platform).environment(\.managedObjectContext, self.moc)
        }
        
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView(platform: movieType)
    }
}
//
//struct PosterView_Preview: PreviewProvider {
//    static var previews: some View {
//        PosterView(media: movies[0])
//    }
//}
