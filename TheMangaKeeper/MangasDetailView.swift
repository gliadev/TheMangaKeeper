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
    @State var expandedSynopsis = false
    let manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                VStack {
                    Text(manga.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    if let titleJapanese = manga.titleJapanese {
                        Text(titleJapanese)
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    MangaDetailCoverImage(manga: manga)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 5)
                        .padding(.vertical, 20)
                    
                }
                Button(action: {
                    if manga.isFavorite {
                        showVolumeManagement = true
                    } else {}
                }) {
                    Text("Gestion de los Volumenes")
                }
                .opacity(mangasVM.checkIsFavorite(manga: manga) ? 1 : 0)
                
                MangasColectionButtoView(manga: manga)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(mangasVM.checkIsFavorite(manga: manga) ? .red : .blue)
                
                
                
                Group {
                    Text("By \(manga.authors.map { "\($0.firstName) \($0.lastName)" }.joined(separator: ", "))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Puntuación: \(manga.scoreFormateado)")
                        .bold()
                    
                    Text("Volúmenes: \(String(describing: manga.volumes))")
                    
                    Text("Géneros: \(manga.genres.map { $0.genre.rawValue }.joined(separator: ", "))")
                    Text("Demográfico: \(manga.demographics.map { $0.demographic }.joined(separator: ", "))")
                }
                .padding(.vertical, 2)
                
                
                Text("Synopsis")
                    .font(.headline)
                Text(manga.sypnosis ?? "No Synopsis disponible")
                    .lineLimit(expandedSynopsis ? nil : 3)  // Limitar a 3 líneas a menos que esté expandido
                    .onTapGesture {
                        expandedSynopsis.toggle()  // Cambiar entre expandido y no expandido
                    }
                    .animation(.easeInOut, value: expandedSynopsis)
                    .padding(.bottom, 20)
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            .sheet(isPresented: $showVolumeManagement) {
                
                Text("Vista para la gestión de volúmenes")
            }
        }
        .navigationTitle("Detalle del Manga")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MangasDetailView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}
