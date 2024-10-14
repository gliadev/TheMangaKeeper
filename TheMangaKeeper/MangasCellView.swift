//
//  MangasCellViewSecond.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 10/3/24.
//

import SwiftUI

struct MangasCellView: View {
    var manga: Manga
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
               .cornerRadius(12)
            HStack(spacing: 16) {
                MangaCoverImage(manga: manga)
                VStack(alignment: .leading, spacing: 8) {
                    Text(manga.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if let titleJapanese = manga.titleJapanese {
                        Text(titleJapanese)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Text("Estado: \(manga.status.statusDescripcion)")
                    StarRatingViewComponent(rating: Int(manga.score))
                }
                Spacer()
            }
        }
        .padding(.all, 10)
    }
}


#Preview {
    MangasCellView(manga: .testManga)
}
