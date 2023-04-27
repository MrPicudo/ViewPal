/* ContentView.swift --> ViewPal. Created by BaymaxCoders on 24/04/23. */

import SwiftUI

/// Vista principal de la app, contiene el TabView para mostrar todas las funcionalidades desarrolladas.
struct ContentView: View {
    
    @StateObject private var speeaches = SpeechManager()
    @StateObject var globalLogs = GlobalLog()
    
    var body: some View {
        TabView {
            // Primera pestaña
            HistoryView().environmentObject(globalLogs)
                .tabItem {
                    Label("HISTORIAL", systemImage: "clock.fill")
                }
                .onDisappear() {
                    speeaches.stop()
                }
            // Segunda pestaña
            CameraPillView().environmentObject(globalLogs)
                .tabItem {
                    Label("IDENTIFICA", systemImage: "pills.fill")
                }
            // Tercera pestaña
            CameraBookView()
                .tabItem {
                    Label("LEE", systemImage: "book.circle")
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
