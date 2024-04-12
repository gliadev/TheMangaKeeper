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
                       AsyncImage(url: URL(string: manga.mainPictureFormateada)) { image in
                           image.resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 100, height: 150)
                               .cornerRadius(12)
                               .shadow(radius: 3)
                       } placeholder: {
                           Image(systemName: "photo.fill")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 100, height: 150)
                               .foregroundColor(.gray)
                       }
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
