//
//  MangasTabBar.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 3/1/24.
//

import SwiftUI

struct MangasTabBar: View {
    let manga: Manga
    
    var body: some View {
        TabView {
            MangasListView(manga: .testManga)
                .tabItem {
                    Label("Mangas", systemImage: "list.dash")
                }
            MangasCollectionView(manga: .testManga)
                .tabItem {
                    Label("Mi Coleccion", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MangasTabBar(manga: .testManga)
        .environmentObject(MangasViewModel())
        
}
