//
//  MangasCellView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

//TODO: revisar llamadas en la red
//TODO: Celda mas currada puntuacion celda
//TODO: NAVEGACION A UN DETALLE SENCILLA VISTA DETALLE DEL MANGA

import SwiftUI

struct MangasCellView: View {
   
    var manga: Manga
    var body: some View {
        HStack (spacing: 10){
            AsyncImage(url: URL(string: manga.mainPictureFormateada)){
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100, height: 150)
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
                                .font(.title2) // Fuente mas grande
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .lineLimit(1) // para que no derborde

                            if let titleJapanese = manga.titleJapanese, !titleJapanese.isEmpty {
                                Text(titleJapanese)
                                    .font(.subheadline) // Fuente más pequeña para el título en japonés
                                    .foregroundColor(.secondary)
                                    .lineLimit(1) // Asegurarse de que el texto no se desborde
                            }
                        }
                        Spacer() // Empuja todo hacia la izquierda
                    }
                    .padding(.vertical, 14) // espacio arriba y abajo del contenido con los bordes de la celda
                    .background(Color(.secondarySystemBackground)) // Un fondo para cada celda
                    .cornerRadius(12) // Esquinas redondeadas para el fondo
            
            
          
            
                    // "limpiaria" la direccion url replanzando / por un string vacion
//            if let urlString = manga.mainPicture.replacingOccurrences(of: "\"", with: ""),
//                       let url = URL(string: urlString) {
//                        AsyncImage(url: url) { image in
//                        image
//                        }
//                        .frame(width: 100, height: 100) // Ajusta el tamaño según sea necesario
//                    }
                }
            }
//TODO: revisar llamadas en la red
//TODO: Celda mas currada puntuacion celda
//TODO: NAVEGACION A UN DETALLE SENCILLA VISTA DETALLE DEL MANGA


// activo datos en local
#Preview {
    MangasCellView(manga: .testManga)
}



//#Preview {
//    MangasCellView(
//        manga: Manga(
//            themes: [],
//            endDate: Date.now,
//            demographics: [],
//            volumes: 15,
//            genres: [],
//            title: "Mi Mnaga",
//            sypnosis: "Una aventura",
//            status: .currentlyPublishing,
//            authors: [],
//            titleEnglish: "My Manga",
//            startDate: .now,
//            score: 12.4,
//            mainPicture: "",
//            chapters: 12,
//            id: 47000,
//            background: "",
//            url: "",
//            titleJapanese: ""
//        )
//    )
//}



