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
    @State var selectedItem: MediaType? = nil
    var body: some View {
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
                        ListItemView(item: item, selectedItem: $selectedItem).environment(\.managedObjectContext, moc)
                    }
                }
            }
        }
    }
    
}

struct SearchWindow_Previews: PreviewProvider {
    static var previews: some View {
        SearchWindow(platform: movieType)
    }
}


