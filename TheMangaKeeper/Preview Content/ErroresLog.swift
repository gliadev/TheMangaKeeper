//
//  ErroresLog.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/3/24.
//

import Foundation
// Simplemente para ir apuntado las cosas que ido solucionando y que no se me olviden

/*
 Tenia un error cuando ejecutaba la aplicacion en los log
 Logging Error: Failed to initialize logging system. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables.
 
 
 Parece que con esto se soluciona de momento no a vuelto a salir
 En Xcode, ve a la barra de menú y selecciona "Product" (Producto) > "Scheme" (Esquema) > "Edit Scheme..." (Editar esquema...).
 En la ventana que aparece, asegúrate de que estés viendo la pestaña "Run" (Ejecutar) en el lado izquierdo.
 Luego, ve a la sección "Arguments" (Argumentos) en las pestañas de arriba.
 En la sección de "Environment Variables" (Variables de Entorno), haz clic en el botón "+" para añadir una nueva variable.
 Añade IDEPreferLogStreaming como el nombre de la variable y establece su valor en YES.
 Asegúrate de aplicar los cambios y cierra la ventana de configuración.
 Intenta ejecutar tu aplicación nuevamen
 
 
 
 */
