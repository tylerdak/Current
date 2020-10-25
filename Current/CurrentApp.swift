//
//  CurrentApp.swift
//  Shared
//
//  Created by Tyler Dakin on 10/10/20.
//


import Foundation

import CoreData
import SwiftUI

@main
struct CurrentApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Media.entity(), sortDescriptors: []) var mediaGroup: FetchedResults<Media>
    
    let persistanceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    MainView()
                        .listStyle(InsetListStyle())
                        .environment(\.managedObjectContext, persistanceController.container.viewContext)
                }
                else {
                    MainView()
                        .listStyle(SidebarListStyle())
                        .environment(\.managedObjectContext, persistanceController.container.viewContext)
                }
            }
            .accentColor(.purple)
            .onChange(of: scenePhase) { phase in
                switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                
                case .background:
                    print("background")
                    try? persistanceController.container.viewContext.save()
                default:
                    print("uh oh")
                }
                
            }
//            .onAppear(perform: getGamerKey)
            
            
        }
    }
//    
//    var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Current")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
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
