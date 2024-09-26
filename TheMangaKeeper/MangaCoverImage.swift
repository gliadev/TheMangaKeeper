//
//  MangaCoverImage.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 14/4/24.
//

import SwiftUI

struct MangaCoverImage: View {
    let manga: Manga
    
    var body: some View {
        AsyncImage(url: URL(string: manga.mainPictureFormateada)) { image in
            image
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(12)
                .shadow(radius: 3)
        } placeholder: {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    MangaCoverImage(manga: .testManga)
}
