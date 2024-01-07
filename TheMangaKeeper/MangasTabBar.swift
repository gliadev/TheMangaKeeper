//
//  MangasTabBar.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 3/1/24.
//

import SwiftUI

struct MangasTabBar: View {
    @ObservedObject var MangasVM = MangasViewModel()
     
    
    var body: some View {
        TabView {
            ContentView(mangasVM: MangasViewModel())
                .tabItem {
                    Label("Mangas", systemImage: "list.dash")
                }
            ContentView(mangasVM: MangasViewModel())
                .tabItem {
                    Label("TOP10", systemImage: "trophy.fill")
                }
            MangasFavorites()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MangasTabBar()
}
