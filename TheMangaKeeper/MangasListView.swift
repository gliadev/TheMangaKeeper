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
                ForEach(mangasVM.mangas) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)) {
                        MangasCellView(manga: manga)
                            .onAppear {
                                // si hay mas cargalos
                                mangasVM.loadMoreMangaIfNeeded(manga: manga)
                            }
                        
                            .swipeActions(edge: .leading) {
                                Button {
                                    mangasVM.toogleMangaFavorite(mangaID: manga.id)
                                } label: {
                                    Label(manga.isFavorite ? "Eliminar de Colección" : "Añadir a colección", systemImage: manga.isFavorite ? "trash" : "star.fill")
                                }
                            }                        .tint(manga.isFavorite ? .red : .yellow)
                    }
                }
            }
            .navigationTitle("Lista de Mangas")
            .alert("App Alert", isPresented: $mangasVM.showAlert) {} message: {
                Text(mangasVM.errormenssage)
            }
        }
    }
}



#Preview {
    MangasListView()
        .environmentObject(MangasViewModel())
}
