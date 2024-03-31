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
    //let manga: Manga
    
     
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangasFavorites) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)){
                        MangasCellView(manga: manga)
                    }
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
                            mangasVM.toogleMangaFavorite(mangaID: manga.id)
                        } label: {
                            Label("Eliminar de Colección", systemImage: "trash")
                        }
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
        .environmentObject(MangasViewModel())
}

/*
 NavigationStack {
 //ScrollView {
 //LazyVGrid(columns: gridItems,spacing: 20) {
 ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
 NavigationLink(destination: MangasDetailView(manga: manga)){
 MangasCellView(manga: manga)
 }
 }
 }
 }
 .navigationTitle("Mi Coleccion")
 .bold()
 }
 }
 }
 */



