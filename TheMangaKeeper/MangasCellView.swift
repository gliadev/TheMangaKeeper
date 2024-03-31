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
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    HStack(spacing: 10) {
                        AsyncImage(url: URL(string: manga.mainPictureFormateada)) { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(width: 100, height: 150)
                                 .cornerRadius(9)
                                 .shadow(radius: 7)
                        } placeholder: {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading) {
                            Text(manga.title)
                                .font(.title2)
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
                            //Text(manga.scoreFormateado)
                            StarRatingViewComponent(rating: Int(manga.score))
                            
                        }
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

//                    if showFavoriteButton {
//                        Button(action: {
//                            mangasVM.toogleMangaFavorite(mangaID: manga.id)
//                        }) {
//                            Image(systemName: "heart.fill")
//                                .padding(8)
//                                .foregroundColor(.red)
//                                .background(Color.white.opacity(0.9))
//                                .clipShape(Circle())
//                                .shadow(radius: 3)
//                        }
//                        .padding(.top, 10)
//                        .padding(.trailing, 10)
//                    }
                }
            }
        }
        

#Preview {
    MangasCellView(manga: .testManga)
}
