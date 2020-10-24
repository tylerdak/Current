//
//  CurrentApp.swift
//  Current
//
//  Created by Tyler Dakin on 10/24/20.
//

import SwiftUI

@main
struct CurrentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
