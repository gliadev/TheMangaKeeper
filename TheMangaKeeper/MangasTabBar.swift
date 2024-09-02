//
//  MangasTabBar.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 3/1/24.
//å

import SwiftUI

struct MangasTabBar: View {
    
    var body: some View {
        TabView {
            MangasListView()
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
    MangasTabBar()
        .environmentObject(MangasViewModel())
    
}


// .onTag
