//
//  CurrentApp.swift
//  Shared
//
//  Created by Tyler Dakin on 10/10/20.
//


import Foundation

import SwiftUI

@main
struct CurrentApp: App {
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    MainView()
                        .listStyle(InsetListStyle())
                        .environment(\.managedObjectContext, context)
                }
                else {
                    MainView()
                        .listStyle(SidebarListStyle())
                        .environment(\.managedObjectContext, context)
                }
            }
            .accentColor(.purple)
//            .onAppear(perform: getGamerKey)
            
            
        }
    }
}


struct MainView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    var body: some View {
        List(sortedPlatforms) { platform in
            NavigationLink(destination: PlatformView(platform: platform).environment(\.managedObjectContext, self.moc)) {
                Label {
                    Text(platform.title)
                        .padding(.leading)
                } icon: {
                    Image(systemName: platform.systemIcon)
                        .foregroundColor(.accentColor)
                }
                .font(.title2)
                .padding(6)
            }
        }
        .navigationTitle("Current")
    }
}
