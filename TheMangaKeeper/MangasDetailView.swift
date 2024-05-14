//
//  MangasDetailView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 1/1/24.
//

import SwiftUI

struct MangasDetailView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var showVolumeManagement = false
    @State var expanSynopsis = false
    let manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(manga.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
                    
                    if let titleJapanese = manga.titleJapanese {
                        Text(titleJapanese)
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                    }
                }
                
                MangaDetailCoverImage(manga: manga)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 5)
                    .padding(.vertical, 20)
                
                MangasColectionButtoView(manga: manga)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(mangasVM.checkIsFavorite(manga: manga) ? .red : .blue)
                    .padding(.bottom, 20)
                
//                Button(action: {
//                    if manga.isFavorite {
//                        showVolumeManagement = true
//                    } else {}
//                }) {
//                    Text("Gestion de los Volumenes")
//                }
//                .opacity(mangasVM.checkIsFavorite(manga: manga) ? 1 : 0)
                
                Group {
                    Text("By \(manga.authors.map { "\($0.firstName) \($0.lastName)" }.joined(separator: ", "))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Puntuación: \(manga.scoreFormateado) / 10")
                        .bold()
                    
//                    if let volumes = manga.volumes {
//                        Text("Volumenes: \(volumes)")
//                    } else {
//                        Text("Volumnes: - sin informacion -")
//                    }
                    HStack {
                        
                        if let volumes = manga.volumes {
                            Text("Volúmenes: \(volumes)")
                        } else {
                            Text("Volúmenes: - sin información -")
                        }

                        
                        Button(action: {
                            if manga.isFavorite {
                                showVolumeManagement = true
                            }
                        }) {
                            HStack {
                                Image(systemName: "gear")
                                
                            }
                        }
                        .opacity(mangasVM.checkIsFavorite(manga: manga) ? 1 : 0)
                    }
                    .padding()
                    
                    Text("Géneros: \(manga.genres.map { $0.genre.rawValue }.joined(separator: ", "))")
                    
                    if !manga.demographics.isEmpty {
                        Text("Demográfico: \(manga.demographics.map { $0.demographic }.joined(separator: ", "))")
                    }
                    
                }
                .padding(.vertical, 2)
                
                VStack(alignment: .leading) {
                    Text("Synopsis")
                        .font(.headline)
                }
                Text(manga.sypnosis ?? "No Synopsis disponible")
                    .lineLimit(expanSynopsis ? nil : 3)
                    .animation(.easeInOut, value: expanSynopsis)
                
                if !expanSynopsis {
                    Button("Ver más") {
                        expanSynopsis.toggle()
                    }
                    .foregroundStyle(.blue)
                    .padding(.bottom, 20)
                }
            }
            Spacer()
        }
        .padding([.horizontal, .bottom])
        .sheet(isPresented: $showVolumeManagement) {
            MangaVolumesManagementView(manga: manga).environmentObject(mangasVM)
        }
    }
    
}


#Preview {
    MangasDetailView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}
