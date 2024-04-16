//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//  Created by Adolfo on 10/3/24.


import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var timer: Timer?
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView()
                List {
                    ForEach(mangasVM.mangas) { manga in
                        NavigationLink(destination: MangasDetailView(manga: manga)) {
                            MangasCellView(manga: manga)
                                .onAppear {
                                    mangasVM.loadMoreMangaIfNeeded(manga: manga)
                                }
                        }
                        //                        .swipeActions(edge: .leading) {
                        //                            Button {
                        //                                mangasVM.toogleMangaFavorite(mangaID: manga.id)
                        //                            } label: {
                        //                                Label(manga.isFavorite ? "Eliminar de Colección" : "Añadir a colección", systemImage: manga.isFavorite ? "trash" : "heart.fill")
                        //                            }
                        //                            .tint(manga.isFavorite ? .red : .yellow)
                        //                        }
                    }
                }
                .navigationTitle("Lista de Mangas")
            }
        }           }
}


#Preview {
    MangasListView()
        .environmentObject(MangasViewModel())
}
