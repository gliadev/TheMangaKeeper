//
//  MangasCellView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//


import SwiftUI

struct MangasCellView: View {
    let manga: Manga
    
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
                
                if let titleJapanese = manga.titleJapanese {
                    Text(titleJapanese)
                        .font(.subheadline) // Fuente más pequeña para el título en japonés
                        .foregroundColor(.secondary)
                        .lineLimit(1) // Asegurarse de que el texto no se desborde
                }
                Text("Puntuacion: \(manga.scoreFormateado)")
                if manga.isFavorite {
                    Image(systemName: "star")
                        .foregroundStyle(.yellow)
                }
                
                Text("Estado: \(manga.status.statusDescripcion)")
            }
            Spacer() // Empuja todo hacia la izquierda
        }
        .padding(.vertical, 14) // espacio arriba y abajo del contenido con los bordes de la celda
        .background(Color(.secondarySystemBackground)) // Un fondo para cada celda
        .cornerRadius(12) // Esquinas redondeadas para el fondo
        
    }
}

// activo datos en local
#Preview {
    MangasCellView(manga: .testManga)
}






