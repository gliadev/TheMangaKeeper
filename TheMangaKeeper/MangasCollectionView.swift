//
//  MangasFavorites.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 6/1/24.


import SwiftUI

struct MangasCollectionView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)){
                        MangasCellView(manga: manga)
                    }
                }
            }
            .navigationTitle("Mi Coleccion")
            .bold()
        }
    }
}
    

    #Preview {
        MangasCollectionView(manga: .testManga)
            .environmentObject(MangasViewModel.localTestMangas)
    }

        /*
        NavigationStack {
            //ScrollView {
                //LazyVGrid(columns: gridItems,spacing: 20) {
                    ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
                        NavigationLink(destination: MangasDetailView(manga: manga)){
                            MangasCellView(manga: manga)
                        }
                    }
                }
            }
            .navigationTitle("Mi Coleccion")
            .bold()
        }
    }
}
*/


