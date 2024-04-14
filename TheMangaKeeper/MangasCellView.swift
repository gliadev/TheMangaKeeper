//
//  MangasCellViewSecond.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 10/3/24.
//

import SwiftUI

struct MangasCellView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    var body: some View {
        ZStack {
                   LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                       .cornerRadius(12)
                       .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 2)
                   HStack(spacing: 16) {
                       MangaCoverImage(manga: manga)
                       VStack(alignment: .leading, spacing: 4) {
                           Text(manga.title)
                               .font(.headline)
                               .fontWeight(.bold)
                               .foregroundColor(.primary)
                               .lineLimit(1)
                           
                           if let titleJapanese = manga.titleJapanese {
                               Text(titleJapanese)
                                   .font(.subheadline)
                                   .foregroundColor(.secondary)
                                   .lineLimit(1)
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
