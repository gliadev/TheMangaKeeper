//
//  MangasTabBar.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 3/1/24.
//å

import SwiftUI

struct MangasTabBar: View {
    //@State var selectedTab = 0
    
    var body: some View {
        TabView() {
            MangasListView16_2()
            //MangasListView()
                .tabItem {
                    Label("Mangas", systemImage: "list.dash")
                }
                .tag(0)
            MangasCollectionView()
                .tabItem {
                    Label("Mi Coleccion", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MangasTabBar()
        .environmentObject(MangasViewModel.localTestMangas)
    
}


// .onTag
