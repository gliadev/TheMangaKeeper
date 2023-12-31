//
//  MangasDetailView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 1/1/24.
//

import SwiftUI

struct MangasDetailView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 20) {
                       AsyncImage(url: URL(string: "\(manga.mainPictureFormateada)")) { image in
                           image.resizable()
                                .aspectRatio(contentMode: .fill)
                       } placeholder: {
                           Rectangle().foregroundColor(.gray)
                       }
                       .frame(height: 300)
                       .cornerRadius(12)
                       .shadow(radius: 8)

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
                           Text("Puntuacion: \(manga.score, specifier: "%.2f")")
                               .bold()
                           // Aquí podrías agregar el componente de estrellas más tarde
                       }

                       Text("Generos: \(manga.genres.map { $0.genre }.joined(separator: ", "))")
                       Text("Demographic: \(manga.demographics.map { $0.demographic }.joined(separator: ", "))")

                       Text("Synopsis")
                           .font(.headline)
                       Text(manga.sypnosis!)
                           .lineLimit(5)
                           .onTapGesture {
                            // para expandir la sinopsis, no funciona aun
                           }

                       Spacer()
                   }
                   .padding()
               }
           }
       }

#Preview {
    MangasDetailView(manga: .testManga)
    .environmentObject(MangasViewModel())
}
