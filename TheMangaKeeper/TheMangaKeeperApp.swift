//
//  TheMangaKeeperApp.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//
// ✅ TODO: BUSCAR UNA SOLUCION PARA QUE EL MODELO DEVUELVA LA PUNTUACION YA FORMATEADA
// ✅ TODO: MODIFICAR LOS NOMBRES DE LOS ESTADOS
// ✅ TODO: revisar la vista de la celda en la vista de la celda sale una lista, modificarla para que solo se vea una celda


// 1️⃣ 🚨 TODO: Vista detalle desde  mi la coleccion

// 2️⃣ TODO: Persistencia de los favoritos de mi coleccion en el interactos un json.



// ⁉️ TODO:  PAGUINACION AÑADIR A UN NUEVO LISTADO LOS MANGAS QUE TENGAMOS

// ⁉️ TODO: revisar llamadas en la red intentar hacer carga desde local y cuando se ejecute hacer la peticion a la red

import SwiftUI
  
@main
struct TheMangaKeeperApp: App {
    @StateObject var mangaVM = MangasViewModel()
    var body: some Scene {
        WindowGroup {
            MangasTabBar(manga: .testManga)
                .environmentObject(mangaVM)
                
        }
    }
}
    
