//
//  TheMangaKeeperApp.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//
// TODO: BUSCAR UNA SOLUCION PARA QUE LE MODELO LA DEVUELVA FORMATEADA
// TODO: MODIFICAR LOS NOMBRES DE LOS ESTADOS
// TODO: guardar Favoritos

import SwiftUI
  
@main
struct TheMangaKeeperApp: App {
    @StateObject var mangaVM = MangasViewModel()
    var body: some Scene {
        WindowGroup {
            MangasTabBar()
                .environmentObject(mangaVM)
        }
    }
}
    
