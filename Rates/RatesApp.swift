//
//  RatesApp.swift
//  Rates
//
//  Created by Alicia Windsor on 04/08/2021.
//

import SwiftUI

@main
struct RatesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
