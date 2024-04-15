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
    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(mangasVM.mangasFavorites) { manga in
                        NavigationLink(destination: MangasDetailView(manga: manga)) {
                            MangaCelGridView(manga: manga)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.all, 10)
            }
            .navigationTitle("Mi Coleccion")
            }
        }
    }


#Preview {
    MangasCollectionView()
        .environmentObject(MangasViewModel.localTestMangas)
}




