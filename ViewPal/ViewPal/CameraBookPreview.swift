/* CameraBookView.swift --> ViewPal. Created by BaymaxCoders on 25/04/23. */

import SwiftUI
import AVFoundation

struct CameraBookView: View {
    
    // Variable de estado, se declara por primera vez aquí.
    @StateObject private var cameraViewModel = CameraModel()
    @StateObject private var speeaches = SpeechManager()
    
    /// El cuerpo de la vista principal contiene una etiqueta o bien, la imagen tomada, un botón de tomar fotografía y las etiquetas del texto detectado.
    var body: some View {
        ZStack {
            Image("fondo color 2")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    // Link de retorno a la vista principal
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "house")
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .padding()
                    }
                    Spacer()
                }
                /// Si no se ha capturado ninguna imagen con la cámara, entonces se muestra el texto de instrucciones y el botón para tomar la fotografía
                if cameraViewModel.image != nil {
                    // Imagen de fondo mientras se lee el libro
                    Image(uiImage: cameraViewModel.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    // Texto que se va a leer.
                    if let recognizedText = cameraViewModel.recognizedText {
                        Text("Leyendo...")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .onAppear {
                                speeaches.speak(recognizedText)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    speeaches.speak("Presiona de nuevo para tomar la siguiente foto")
                                }
                            }
                    }
                    
                    Spacer() // - - -
                    
                    // Link de reinicio
                    NavigationLink(destination: CameraBookView()) {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.black)
                            .frame(width: 50)
                    }
                } else {
                    Spacer() // - - -
                    
                    Text("Por favor, presiona el botón de la cámara para escanear una página completa de un libro")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                speeaches.speak("Presiona al centro, en la parte inferior de la pantalla para activar la cámara y escanear una página completa de un libro.")
                            }
                        }
                    
                    Spacer() // - - -
                    
                    Button {
                        cameraViewModel.captureImage()
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.black)
                            .frame(width: 150)
                            .padding(.bottom, 60)
                    }
                }
            }
            .sheet(isPresented: $cameraViewModel.isPresentingImagePicker) {
                ImagePicker(sourceType: .camera, completionHandler: cameraViewModel.imagePickerCompletionHandler)
                    .onAppear {
                        speeaches.stop()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            speeaches.speak("Camara activada, presiona al centro en la parte inferior de la pantalla para tomar la foto")
                        }
                    }
            }
        }
        .onDisappear {
            speeaches.stop()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CameraBookView_Previews: PreviewProvider {
    static var previews: some View {
        CameraBookView()
    }
}
