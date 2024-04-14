//
//  MangaCelGridView.swift
//  TheMangaKeeper
// 
//  Created by Adolfo on 29/2/24.
//

import SwiftUI

struct MangaCelGridView: View {
    @EnvironmentObject var MangasVM: MangasViewModel
    let manga: Manga
    
    var body: some View {
        VStack {
            MangaCoverImage(manga: manga)
            Text(manga.title)
            Text(manga.titleJapanese ?? "")
        }
            
    }
}

#Preview {
    MangaCelGridView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}
