/* HistoryFrame.swift --> ViewPal. Created by BaymaxCoders on 25/04/23. */

import SwiftUI

struct HistoryFrame: View {
    
    @StateObject private var speeaches = SpeechManager()
    
    let readedText: String
    let date: Date
    let background: String
    
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
                .ignoresSafeArea(.all)
            HStack {
                VStack {
                    Text(readedText)
                        .font(.body)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                    Text(date, style: .date)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                }
                // Botón para reproducir el texto leído del historial
                Button {
                    speeaches.stop()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        speeaches.speak(readedText)
                    }
                } label: {
                    Image(systemName: "speaker.wave.2.circle.fill")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(Color.white)
                }
            }
            .padding(40)
        }.frame(width: 450, height: 200)
    }
}

struct HistoryFrame_Previews: PreviewProvider {
    static var previews: some View {
        HistoryFrame(readedText: "Hola soy una prueba", date: Date(), background: "Background")
    }
}
