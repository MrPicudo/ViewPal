/* HistoryView.swift --> ViewPal. Created by BaymaxCoders on 25/04/23. */

import SwiftUI
import AVFoundation

struct HistoryView: View {
    
    @StateObject private var speeaches = SpeechManager()
    
    @StateObject var globalLogs = GlobalLog()
    
    /*@State var logs: [HistoryLog] = [
        HistoryLog(readedText: "Acetaminofén 500mg, Alivio del dolor y fiebre, 30 tabletas", date: Date(), image: "tarjeta 1"),
        HistoryLog(readedText: "Habia una vez una encantadora princesa, pero estaba condenada por un terrible hechizo que solo podia romperse con el beso del verdadero amor. La habian encerrado en un castillo que lo custodiaba un horrible dragón que escupia fuego. Muchos valientes caballeros habian intentado liberarla de esa sombria prisión, pero ninguno lo habia logrado.\nCustodiada por el dragón esperaba en el último cuarto de la torre más alta a su primer amor, y al beso de su verdadero amor", date: Date(), image: "tarjeta 2"),
        HistoryLog(readedText: "Amoxicilina 500mg, Antibiótico de amplio espectro, 10 comprimidos", date: Date(), image: "tarjeta 3"),
        HistoryLog(readedText: "Loratadina 10mg, Antihistamínico para alergias, 14 comprimidos", date: Date(), image: "tarjeta 4"),
        HistoryLog(readedText: "Omeprazol 20mg, Protector gástrico y reductor de acidez, 28 cápsulas", date: Date(), image: "tarjeta 7"),
        HistoryLog(readedText: "Paracetamol 500mg, Analgésico y antipirético, e4 tabletas", date: Date(), image: "tarjeta 6"),
    ]*/
    
    var body: some View {
        ZStack {
            Image("fondo negro")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                Text("Historial de capturas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(10)
                ScrollView {
                    ForEach(globalLogs.log) { historyLog in
                        HistoryFrame(readedText: historyLog.readedText, date: historyLog.date, background: historyLog.image)
                    }
                }
                Spacer()
                Spacer()
            }
        }
        .onDisappear {
            speeaches.stop()
        }
    }
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
