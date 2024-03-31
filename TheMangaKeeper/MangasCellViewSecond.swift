//
//  MangasCellViewSecond.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/3/24.
//
//
//import SwiftUI
//
//struct MangasCellViewSecond: View {
//    @EnvironmentObject var mangasVM: MangasViewModel
//        let manga: Manga
//        
//        var body: some View {
//            HStack {
//                        AsyncImage(url: URL(string: manga.mainPictureFormateada)) { phase in
//                            switch phase {
//                            case .success(let image):
//                                image.resizable()
//                                     .aspectRatio(contentMode: .fill)
//                                     .frame(width: 100, height: 150)
//                                     .cornerRadius(8)
//                            case .failure:
//                                Image(systemName: "photo")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 150)
//                                    .background(Color.gray.opacity(0.3))
//                                    .cornerRadius(8)
//                            case .empty:
//                                ProgressView()
//                                    .frame(width: 100, height: 150)
//                            @unknown default:
//                                EmptyView()
//                            }
//                        }
//                        .shadow(radius: 5)
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text(manga.title)
//                                .font(.headline)
//                                .lineLimit(2)
//                                .foregroundColor(.primary)
//                            
//                            Text(manga.status.statusDescripcion)
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                            
//                            Spacer()
//                            
//                            HStack {
//                                if manga.isFavorite {
//                                    Image(systemName: "heart.fill")
//                                        .foregroundColor(.red)
//                                }
//                                
//                                Spacer()
//                                
//                                Button(action: {
//                                    withAnimation {
//                                        mangasVM.toogleMangaFavorite(mangaID: manga.id)
//                                    }
//                                }) {
//                                    Text(manga.isFavorite ? "Eliminar de favoritos" : "Añadir a favoritos")
//                                        .font(.caption)
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal, 16)
//                                        .padding(.vertical, 8)
//                                        .background(manga.isFavorite ? Color.red : Color.blue)
//                                        .cornerRadius(20)
//                                }
//                            }
//                        }
//                        .padding(.leading, 8)
//                    }
//                    .padding()
//                    .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
//                    .cornerRadius(12)
//                    .shadow(radius: 2)
//                    .padding(.horizontal)
//                    .padding(.vertical, 4)
//                }
//            }
//#Preview {
//    MangasCellViewSecond(manga: .testManga)
//        .environmentObject(MangasViewModel.localTestMangas)
//}
