//
//  TheMangaKeeperApp.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//
// ✅ TODO: BUSCAR UNA SOLUCION PARA QUE EL MODELO DEVUELVA LA PUNTUACION YA FORMATEADA
// ✅ TODO: MODIFICAR LOS NOMBRES DE LOS ESTADOS
// TODO: revisar llamadas en la red intentar hacer carga desde local y cuando se ejecute hacer la peticion a la red
// TODO: guardar Favoritos
// TODO: revisar las imagenes


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
    
