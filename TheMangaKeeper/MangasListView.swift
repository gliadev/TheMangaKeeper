//
//  ContentView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
// color celda

import SwiftUI
  
struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangas) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)) {
                        MangasCellView(manga: manga)
                    }
                    //.foregroundStyle(.secondary)
                    .swipeActions(edge: .leading){
                        Button {
                            mangasVM.toogleMangaFavorite(manga: manga)
                        } label: {
                            Label(manga.isFavorite ? "Eliminar Coleccion" : "Añadir Coleccion", systemImage: manga.isFavorite ?  "trash" : "star.fill")
                        }
                        .tint(manga.isFavorite ? .red : .yellow)
                    }
                }
            }
            //.padding()
            .navigationTitle("Mangas List")
        }
    }
}
                                                       

#Preview {
    MangasListView(manga: .testManga)
        .environmentObject(MangasViewModel())
}
