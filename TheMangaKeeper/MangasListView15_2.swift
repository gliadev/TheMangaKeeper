//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//  Created by Adolfo on 10/3/24.


import SwiftUI

struct MangasListView15_2: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var timer: Timer?
    @State var mangaSelected: Manga.ID?
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView()
                List (selection: $mangaSelected){
                    ForEach(mangasVM.mangas) { manga in
                        NavigationLink(destination: MangasDetailView(manga: manga)) {
                            MangasCellView(manga: manga)
                                .onAppear {
                                    mangasVM.loadMoreMangaIfNeeded(manga: manga)
                                }
                        }
                    }
                }
            }
                .listStyle(.plain)
                .navigationTitle("Listado de Mangas")
                .navigationBarTitleDisplayMode(.inline)
           
            if let first = mangasVM.mangas.first {
                MangasDetailView(manga: first)
            }
        }
    }
}


#Preview {
    MangasListView15_2()
        .environmentObject(MangasViewModel.localTestMangas)
}
