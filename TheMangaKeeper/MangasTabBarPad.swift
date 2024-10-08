//
//  MangasTabBar.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 3/1/24.
//å

import SwiftUI

struct MangasTabBarPad: View {
    
    var body: some View {
        TabView() {
            MangasListView16_2()
                .tabItem {
                    Label("Mangas", systemImage: "list.dash")
                }
            MangasCollectionView()
                .tabItem {
                    Label("Mi Coleccion", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MangasTabBarPad()
        .environmentObject(MangasViewModel.localTestMangas)
    
}


