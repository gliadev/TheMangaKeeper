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
// ✅ TODO: los datos en local para probar no termina de funcionar
// ✅ TODO: Paginacion
// 🚨 TODO: Pulir lo que tenemos hasta ahora que funcione fino diferentes pruebas sin errores se mentienen fav que este ok, se dupblican los mangas de la coleeccion, confirmacion por mensaje para eliminar un manga.
// 🚨 TODO: añadir un filtro ORDENAR ARRAY DE MANGAS POR ORDEN ALFABETICO
// TODO: CREAR LAS TRES PROPIEDADES EN EL MODELO (GESTION COLEECION) BUSCAR MODO DESDE EL DETALLE DARLE UN VALOR

// 🚨 TODO: error nw_connection_add_timestamp_locked_on_nw_queue [C2] al cargar mangas
// 🚨 TODO: Error for queryMetaDataSync: 2
// 🚨 TODO: Busquedas



// ⁉️ TODO:  Para el grid hay tengo que crear un  configuracion para la vista antes y desde la vista de grid llamarla




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
    
