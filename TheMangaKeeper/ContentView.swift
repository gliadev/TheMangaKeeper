//
//  ContentView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mangasVM = MangasViewModel()
    //let manga: Manga
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangas) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)) {
                        MangasCellView(manga: manga)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            mangasVM.deleteManga(manga: manga)
                            print("Borrar \(manga)")
                        } label: {
                            Label("Borrar", systemImage: "trash")
                        }
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
            .padding()
            .navigationTitle("Mangas List")
        }
    }
}
                                                       

#Preview {
    ContentView()
}
