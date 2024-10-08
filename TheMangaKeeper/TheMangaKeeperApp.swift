//
//  TheMangaKeeperApp.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//


import SwiftUI

@main
struct TheMangaKeeperApp: App {
    @StateObject var mangaVM = MangasViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    MangasTabBarPad()
                } else {
                    MangasTabBar()
                }
            }
            .environmentObject(mangaVM)
        }
    }
}

