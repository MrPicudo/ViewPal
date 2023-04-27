/* HistoryLog.swift --> Hackathon. Created by BaymaxCoders on 25/04/23. */

import SwiftUI

struct HistoryLog: Identifiable, Hashable {
    var id = UUID()
    var readedText: String
    var date: Date
    var image: String
}

class GlobalLog: ObservableObject {
  @Published var log: [HistoryLog] = [
    HistoryLog(readedText: "Acetaminofén 500mg, Alivio del dolor y fiebre, 30 tabletas", date: Date(), image: "tarjeta 1"),
    HistoryLog(readedText: "Habia una vez una encantadora princesa, pero estaba condenada por un terrible hechizo que solo podia romperse con el beso del verdadero amor. La habian encerrado en un castillo que lo custodiaba un horrible dragón que escupia fuego. Muchos valientes caballeros habian intentado liberarla de esa sombria prisión, pero ninguno lo habia logrado.Custodiada por el dragón esperaba en el último cuarto de la torre más alta a su primer amor, y al beso de su verdadero amor", date: Date(), image: "tarjeta 2"),
    HistoryLog(readedText: "Amoxicilina 500mg, Antibiótico de amplio espectro, 10 comprimidos", date: Date(), image: "tarjeta 3"),
    HistoryLog(readedText: "Loratadina 10mg, Antihistamínico para alergias, 14 comprimidos", date: Date(), image: "tarjeta 4"),
    HistoryLog(readedText: "Omeprazol 20mg, Protector gástrico y reductor de acidez, 28 cápsulas", date: Date(), image: "tarjeta 7"),
    HistoryLog(readedText: "Paracetamol 500mg, Analgésico y antipirético, e4 tabletas", date: Date(), image: "tarjeta 6")
  ]
}
