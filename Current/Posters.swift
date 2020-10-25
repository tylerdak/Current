//
// Posters.swift
// Current
//
// Created by Tyler Dakin on 9/6/20.
//

import SwiftUI


struct HorizontalCollectionView: View {
    let title: String
    var collection: [MediaType]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(collection, id: \.self) { media in
                        PosterView(media: media)
                    }
                }
                .frame(height: 200, alignment: .leading)
            }
        }
    }
}

struct PosterView: View {
    let media: MediaType
    var body: some View {
        VStack {
            Image(media.portraitImgName)
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
    @Binding var selectedItem: MediaType?
    @Namespace private var animation
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
                                        .matchedGeometryEffect(id: "itemImage", in: animation)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Text(item.description)
                                        .font(.body)
                                        .foregroundColor(.white)
                                    VStack {
                                        Spacer()
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(maxHeight: 30)
                                            .foregroundColor(.white)
                                            .matchedGeometryEffect(id: "addButton", in: animation)
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
                                    .matchedGeometryEffect(id: "itemImage", in: animation)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "itemTitle", in: animation)
                                    
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(maxHeight: 30)
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "addButton", in: animation)
                                }
                            }
                        }
                    }
                    .padding()
                    .drawingGroup()
                    
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
