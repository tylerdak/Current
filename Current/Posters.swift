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
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    
    var collection: FetchedResults<Media>
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(collection, id: \.self) { media in
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
    
    @Binding var selectedItem: MediaType?
    @Namespace private var animationImg
    @Namespace private var animationTitle
    @Namespace private var animationButton
    var body: some View {
        Button(action: {
            withAnimation {
                if selectedItem == item {
                    selectedItem = nil
                }
                else {
                    selectedItem = item
                }
            }
            
        }) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(gradient: grayGrade, startPoint: .bottomLeading, endPoint: .topTrailing))
                .overlay(
                    ZStack {
                        if selectedItem == item {
                            VStack {
                                HStack {
                                    Image(uiImage: (getImage(from: item.portraitImgName) ?? UIImage(systemName: "xmark"))!)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .transition(.slide)
                                        .matchedGeometryEffect(id: "itemImage", in: animationImg)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .transition(.slide)
                                            .matchedGeometryEffect(id: "itemTitle", in: animationTitle)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Text(item.overview)
                                        .font(.body)
                                        .foregroundColor(.white)
                                    VStack {
                                        Spacer()
                                        Button(action: {
                                            let newMediaItem = Media(context: self.moc)
                                            
                                            newMediaItem.title = item.title
                                            newMediaItem.id = item.id
                                            newMediaItem.portraitImgName = item.portraitImgName
                                            newMediaItem.overview = item.overview
                                            
                                            try? self.moc.save()
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(maxHeight: 30)
                                                .foregroundColor(.white)
                                        }
                                        .transition(.slide)
                                        .matchedGeometryEffect(id: "addButton", in: animationButton)
                                    }
                                }
                            }
                            
                        }
                        else {
                            HStack {
                                Image(uiImage: (getImage(from: item.portraitImgName) ?? UIImage(systemName: "xmark"))!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .transition(.slide)
                                    .matchedGeometryEffect(id: "itemImage", in: animationImg)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .transition(.slide)
                                        .matchedGeometryEffect(id: "itemTitle", in: animationTitle)
                                    
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Button(action: {
                                        let newMediaItem = Media(context: self.moc)
                                        
                                        newMediaItem.title = item.title
                                        newMediaItem.id = item.id
                                        newMediaItem.portraitImgName = item.portraitImgName
                                        newMediaItem.overview = item.overview
                                        
                                        try? self.moc.save()
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(maxHeight: 30)
                                            .foregroundColor(.white)
                                    }
                                    .transition(.slide)
                                    .matchedGeometryEffect(id: "addButton", in: animationButton)
                                }
                            }
                        }
                    }
                    .padding()
                    .transition(.slide)
                    
                )
                .frame(height: selectedItem == item ? 300 : 150)
                .padding(.vertical, 5)
                .padding(.horizontal)
                
        }
    }
}

struct ListPreview: PreviewProvider {
    static var previews: some View {
        SearchWindow(platform: movieType)
    }
}
