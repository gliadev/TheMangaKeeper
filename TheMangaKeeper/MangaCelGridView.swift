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
                //.resizable()
                .scaledToFit()
                .frame(height: 120)
            Text(manga.title)
                .lineLimit(1)
                .font(.caption)
            Text(manga.titleJapanese ?? "")
                .lineLimit(1)
                .font(.caption2)
        }
        .padding(7)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 8))
            
    }
}

#Preview {
    MangaCelGridView(manga: .testManga)
        //.environmentObject(MangasViewModel.localTestMangas)
}
