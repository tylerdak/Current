//
// Posters.swift
// Current
//
// Created by Tyler Dakin on 9/6/20.
//

import SwiftUI


struct HorizontalCollectionView: View {
    let title: String
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    var mediaGroup: [Media]
    
//    var collection: FetchedResults<Media>
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(mediaGroup, id: \.self) { media in
                        PosterView(imgLink: media.wrappedImgLink)
                    }
                }
                .frame(height: 200, alignment: .leading)
            }
        }
    }
}

struct PosterView: View {
    let imgLink: String
    var body: some View {
        VStack {
            Image(uiImage: (getImage(from: imgLink) ?? UIImage(systemName: "xmark"))!)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding(.all)
        .frame(maxWidth: 300)
    }
}

struct ListItemView: View {
    let item: MediaType
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(LinearGradient(gradient: grayGrade, startPoint: .bottomLeading, endPoint: .topTrailing))
            .overlay(
                ZStack {
                    
                    HStack {
                        Image(uiImage: (getImage(from: item.portraitImgName) ?? UIImage(systemName: "xmark"))!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                        }
                        Spacer()
                    }
                }
                .padding()
                
            )
            .frame(height: 150)
            .padding(.vertical, 5)
            .padding(.horizontal)
    }
}


struct ListPreview: PreviewProvider {
    static var previews: some View {
        SearchWindow(platform: movieType)
    }
}
