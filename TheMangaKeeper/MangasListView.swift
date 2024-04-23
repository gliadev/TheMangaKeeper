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
                    }
                }
                .navigationTitle("Lista de Mangas")
            }
        }           }
}


#Preview {
    MangasListView()
        .environmentObject(MangasViewModel.localTestMangas)
}
