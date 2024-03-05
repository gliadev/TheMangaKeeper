//
//  ContentView.swift lo pasamos MangasListView
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//

import SwiftUI
  
struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    //let manga: Manga
    
    var body: some View {
        NavigationStack {
                    List {
                        ForEach(mangasVM.mangas.indices, id: \.self) { index in
                            let manga = mangasVM.mangas[index]
                            NavigationLink(destination: MangasDetailView(manga: manga)) {
                                MangasCellView(manga: manga)
                                    .onAppear {
                                        // si hay mas cargalos
                                        if index == mangasVM.mangas.count - 1 {
                                            Task {
                                                await mangasVM.loadMoreMangas()
                                            }
                                        }
                                    }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    mangasVM.toogleMangaFavorite(mangaID: manga.id)
                                } label: {
                                    Label(manga.isFavorite ? "Eliminar de Colección" : "Añadir a colección", systemImage: manga.isFavorite ? "trash" : "star.fill")
                                }
                                .tint(manga.isFavorite ? .red : .yellow)
                            }
                        }
                    }
                    .navigationTitle("Lista de Mangas")
                }
            }
        }

                                                       

#Preview {
    MangasListView()
        .environmentObject(MangasViewModel.localTestMangas)
}
