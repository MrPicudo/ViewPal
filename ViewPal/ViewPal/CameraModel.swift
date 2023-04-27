/* CameraModel.swift --> ViewPal. Created by BaymaxCoders on 24/04/23. */

import SwiftUI
import UIKit
import AVFoundation
import Vision

// Define una clase CameraModel que hereda de NSObject e implementa el protocolo ObservableObject
class CameraModel: NSObject, ObservableObject {
    
    // Variables publicadas que pueden ser observadas por las vistas SwiftUI
    @Published var image: UIImage? // Imagen capturada con la cámara
    @Published var isPresentingImagePicker = false // Bandera para mostrar el selector de imágenes
    @Published var recognizedText: String? // Texto reconocido en la imagen
    @Published var matchStatus = false // Estado de coincidencia entre el texto reconocido y el texto de referencia
    
    // Cadena de comparación de texto
    private let referenceText = "Valclan"
    
    // Función para iniciar la captura de imágenes
    func captureImage() {
        isPresentingImagePicker = true
    }

    // Controlador de finalización del selector de imágenes
    func imagePickerCompletionHandler(image: UIImage?) {
        self.image = image
        isPresentingImagePicker = false
        
        // Si se capturó una imagen, intenta reconocer texto en ella
        if let image = image {
            recognizeTextInImage(image)
        }
    }

    // Función privada para reconocer texto en una imagen
    private func recognizeTextInImage(_ image: UIImage) {
        // Convierte la imagen a CGImage; si falla, muestra un mensaje de error y retorna
        guard let cgImage = image.cgImage else {
            print("Failed to convert UIImage to CGImage.")
            return
        }

        // Crea una solicitud de reconocimiento de texto y maneja su resultado
        let request = VNRecognizeTextRequest { (request, error) in
            // Si hay un error en el reconocimiento de texto, imprime el error y retorna
            if let error = error {
                print("Error recognizing text: \(error)")
                return
            }

            // Obtiene las observaciones de texto reconocido y extrae el texto de los candidatos principales
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: " ")

            // Actualiza las propiedades publicadas en el hilo principal
            DispatchQueue.main.async {
                self.recognizedText = recognizedText
                self.matchStatus = recognizedText == self.referenceText
            }
        }

        // Configura el nivel de reconocimiento de la solicitud
        request.recognitionLevel = .accurate
        let requests = [request]

        // Ejecuta la solicitud de reconocimiento de texto en un hilo de fondo
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform(requests)
        }
    }
}
