//
//  SearchWindow.swift
//  Current
//
//  Created by Tyler Dakin on 10/24/20.
//

import SwiftUI

struct SearchWindow: View {
    let platform: Platform
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    
    @State private var query = ""
    @State var searchResults: [MediaType] = []
    @State var selectedItem: Media? = nil
    @State var showingTagPicks = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: 25)
                            .padding(3)
                            .scaledToFit()
                    }
                    
                    TextField("Search " + platform.title, text: $query)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    print("hello?")
                                    query = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.secondary)
                                    
                                }
                            }
                        )
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(Color.gray.opacity(0.4))
                            
                        )
                    Button(action: {
                        searchResults = []
                        dataGrab(platform: platform, query: query)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: 25)
                            .padding(3)
                            .foregroundColor(.accentColor)
                    }
                    .keyboardShortcut(.return)
                }
                .padding()
                
                if (searchResults.isEmpty) {
                    Spacer()
                    Text("Type your query in the search bar and tap the search icon, then you might get something useful here. 😃")
                    Spacer()
                }
                else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(searchResults) { item in
                            NavigationLink(destination: PopupView(platform: platform, showingQuestion: $showingTagPicks, selectedItem: item)) {
                                ListItemView(item: item).environment(\.managedObjectContext, moc)
                            }
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
}

struct SearchWindow_Previews: PreviewProvider {
    static var previews: some View {
        SearchWindow(platform: movieType)
    }
}

struct PopupView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    
    let platform: Platform
    @Binding var showingQuestion: Bool
    var selectedItem: MediaType
    var body: some View {
        VStack {
            ListItemView(item: selectedItem)
            List {
                ForEach(platform.tags, id: \.self) { tag in
                    Button(action: {
                        var newMediaItem = Media(context: self.moc)
                        
                        newMediaItem.id = selectedItem.id
                        newMediaItem.title = selectedItem.title
                        newMediaItem.portraitImgName = selectedItem.portraitImgName
                        newMediaItem.overview = selectedItem.overview
                        print(newMediaItem.managedObjectContext ?? "Unknown")
                        
                        let newtag = Tag(context: self.moc)
                        newtag.tagName = tag
                        newMediaItem.addToUserTags(newtag)
                        
                        try? self.moc.save()
                    }) {
                        Text(tag)
                    }
                }
            }
            HStack {
                Text("what?")
            }
        }
    }
}



