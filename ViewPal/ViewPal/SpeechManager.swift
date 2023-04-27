/* SpeechManager.swift --> ViewPal. Created by BaymaxCoders on 25/04/23. */

import Foundation
import AVFoundation

/// Clase de tipo "ObservableObject" que permite tener un objeto que lee texto en voz alta dentro de una vista.
class SpeechManager: ObservableObject {
    
    // Objeto que nos permite leer en voz alta un texto de la aplicación
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    /// Lee en voz alta el texto ingresado
    func speak(_ text: String) {
        // Convertimos el texto a un formato que puede leer el sintetizador.
        let speechUtterance = AVSpeechUtterance(string: text)
        /// Configuramos el idioma del sintetizador y la velocidad de locución.
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        speechUtterance.rate = 0.53
        // Hacemos que se lea el texto.
        speechSynthesizer.speak(speechUtterance)
    }
    
    /// Detiene la lectura del texto cuando sea necesario
    func stop() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
    }
    
}
