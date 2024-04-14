//
//  MangasFavorites.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 6/1/24.
// en el viemodel

import SwiftUI

struct MangasCollectionView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var showDeleteConfirmation = false
    let itemFix = GridItem(.fixed(100), spacing: 20, alignment: .center)
    let itemFlexible = GridItem(.flexible())
    //let manga: Manga
    
     
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: [itemFlexible, itemFlexible, itemFlexible]) {
                    ForEach(mangasVM.mangasFavorites) {
                        manga in
                        MangaCelGridView(manga: manga)
                    }
                }
            }
            .navigationTitle("Mi Coleccion")
            .bold()
        }
    }
}


#Preview {
    MangasCollectionView()
        .environmentObject(MangasViewModel.localTestMangas)
}



