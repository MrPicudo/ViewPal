/* ViewPalApp.swift --> ViewPal. Created by Miguel Torres on 24/04/23. */

import SwiftUI

@main
/// Estructura creada por default al iniciar el proyecto, controla el inicio de la aplicación, y el tipo de contenedores que tendrá la primer vista cargada.
struct ViewPalApp: App {
    var body: some Scene {
        WindowGroup {
            // Lo único que agregamos es un NavigationStack para poder navegar con navigationsLinks entre vistas.
            NavigationStack {
                ContentView()
            }
        }
    }
}
