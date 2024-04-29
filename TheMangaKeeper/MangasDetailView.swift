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
    let manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: "\(manga.mainPictureFormateada)")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                Button(action: {
                    if manga.isFavorite {
                        showVolumeManagement = true
                    } else {}
                }) {
                    Text("Gestion de los Volumenes")
                }
                .opacity(mangasVM.checkIsFavorite(manga: manga) ? 1 : 0) 
               // .controlSize(.large)
                //.tint(manga.isFavorite ? .red : .gray)
                MangasColectionButtoView(manga: manga)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(mangasVM.checkIsFavorite(manga: manga) ? .red : .blue)
                
                
                
                Text(manga.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(manga.titleJapanese ?? "")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("By \(manga.authors.map { "\($0.firstName) \($0.lastName)" }.joined(separator: ", "))")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("Puntuacion: \(manga.scoreFormateado)")
                        .bold()
                    // componente de las estrellas??
                }
                Text("\(String(describing: manga.volumes))")
                
                Text("Generos: \(manga.genres.map { $0.genre.rawValue }.joined(separator: ", "))")
                Text("Demographic: \(manga.demographics.map { $0.demographic }.joined(separator: ", "))")
                
                Text("Synopsis")
                    .font(.headline)
                Text(manga.sypnosis ?? "No Synopsis disponible")
                //.lineLimit(5)
                    .onTapGesture {
                        // para expandir la sinopsis, no funciona aun
                    }
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            .sheet(isPresented: $showVolumeManagement) {
                MangaVolumesManagementView(manga: manga).environmentObject(mangasVM)
            }
        }
    }
}


#Preview {
    MangasDetailView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}
