//
//  MangaDetailCoverImage.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 9/5/24.
//

import SwiftUI

struct MangaDetailCoverImage: View {
    let manga: Manga
    
    
    var body: some View {
        AsyncImage(url: URL(string: manga.mainPictureFormateada)) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(radius: 15)
                .frame(width: 300, height: 450)
                .padding(.horizontal)
            
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .frame(width: 300, height: 450)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)
        }
    }
}

#Preview {
    MangaDetailCoverImage(manga: .testManga)
}
