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
//    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    MainView()
                        .listStyle(InsetListStyle())
                }
                else {
                    MainView()
                        .listStyle(SidebarListStyle())
                }
            }
            .accentColor(.purple)
//            .onAppear(perform: getGamerKey)
            
            
        }
    }
}


struct MainView: View {
    var body: some View {
        List(sortedPlatforms) { platform in
            NavigationLink(destination: PlatformView(platform: platform)) {
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
