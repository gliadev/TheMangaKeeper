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
// ✅ TODO: Busqueda
// ✅ TODO: añadir un filtro ORDENAR ARRAY DE MANGAS POR ORDEN ALFABETICO


// ✅ TODO: pulir bien las vistas antes de avanzar, empezar hacer bien la vista de grid.
//          controlar cuando reinicias la app y seleccionas un manga que ya esta en tu coleccion te da opcion de agregarlo
//          pero no lo agrega si no que lo borra, tengo que controlar mi flujo de ejecucion de los datos
//
//          sacar al boton de filtrado de la barra de busqueda y revisar bien como los muestra
//
//          revisar la funcion toogle intentar sacar un poco el codigo fuera por ejemplo checkduplicate
//          revisar el didSet

// ESTO LIMPIAR CODIGO Y REPASAR METODOS LIMPIAR CODIGO



// TODO: CREAR LAS TRES PROPIEDADES EN EL MODELO (GESTION COLEECION) BUSCAR MODO DESDE EL DETALLE DARLE UN VALOR

// 🚨 TODO: error nw_connection_add_timestamp_locked_on_nw_queue [C2] al cargar mangas
// 🚨 TODO: Error for queryMetaDataSync: 2




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
    
