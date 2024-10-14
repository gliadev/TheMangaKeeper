//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//  Created by Adolfo on 10/3/24.


import SwiftUI

struct MangasListView16_2: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var mangaSelected: Manga.ID?
    
    
    var body: some View {
            NavigationSplitView {
                SearchBarView()
                List(selection: $mangaSelected) {
                    ForEach(mangasVM.mangas) { manga in
                        MangasCellView(manga: manga)
                            .onAppear {
                                mangasVM.loadMoreMangaIfNeeded(manga: manga)
                            }
                    }
                }
                .navigationTitle("Mangas")
                .navigationSplitViewColumnWidth(400)
            } detail: {
                        if let mangaSelected,
                           let manga = mangasVM.getMangaByID(id: mangaSelected) {
                            MangasDetailView(manga: manga)
                        } else if let firstManga = mangasVM.mangas.first {
                            MangasDetailView(manga: firstManga)
                                .onAppear {
                                    mangaSelected = firstManga.id
                                }
                        } else {
                            Text("No hay mangas disponibles.")
                        }
                    }
                    .onAppear {
                        if mangaSelected == nil, let firstManga = mangasVM.mangas.first {
                            mangaSelected = firstManga.id
                        }
                    }
                }
            }


#Preview {
    MangasListView16_2()
        .environmentObject(MangasViewModel())
}
