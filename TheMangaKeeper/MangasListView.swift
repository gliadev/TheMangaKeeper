//
//  ContentView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
// color celda

import SwiftUI
  
struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangas) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)) {
                        MangasCellView(manga: manga)
                    }
                    .swipeActions(edge: .leading){
                        Button {
                            mangasVM.toogleMangaFavorite(manga: manga)
                        } label: {
                            Label(manga.isFavorite ? "Eliminar favorito" : "Añadir Favorito", systemImage: manga.isFavorite ?  "star" : "star.fill")
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
    MangasListView()
        .environmentObject(MangasViewModel())
}
