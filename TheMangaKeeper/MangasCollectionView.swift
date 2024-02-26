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
        List {
                    ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
                        MangasCellView(manga: manga)
                    }
                  //  .navigationTitle("Favorites Mangas")
                }
            }
        }

#Preview {
    MangasCollectionView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}



