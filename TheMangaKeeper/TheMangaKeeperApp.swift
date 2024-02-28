//
//  TheMangaKeeperApp.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//
// ✅ TODO: BUSCAR UNA SOLUCION PARA QUE EL MODELO DEVUELVA LA PUNTUACION YA FORMATEADA
// ✅ TODO: MODIFICAR LOS NOMBRES DE LOS ESTADOS
// ✅ TODO: revisar la vista de la celda en la vista de la celda sale una lista, modificarla para que solo se vea una celda
// ✅ TODO: Vista detalle desde  mi la coleccion
// ✅ TODO: Persistencia de los favoritos de mi coleccion en el interactos un json.


// ⁉️ TODO:  PAGUINACION
// ⁉️ TODO:  Para el grid hay tengo que crear un  configuracion para la vista antes y desde la vista de grid llamarla
// ⁉️ TODO: los datos en local para probar no termina de funcionar

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
    
