/* ImagePicker.swift --> ViewPal. Created by BaymaxCoders on 24/04/23. */

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    // Almacenamos el tipo de fuente del UIImagePickerController (cámara o galería de fotos).
    let sourceType: UIImagePickerController.SourceType
    // Un controlador de finalización que se llama cuando se selecciona una imagen o se cancela la selección.
    let completionHandler: (UIImage?) -> Void

    // Función requerida por UIViewControllerRepresentable para crear el controlador de vista.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // Creamos un UIImagePickerController.
        let imagePickerController = UIImagePickerController()
        // Establecemos el tipo de fuente (cámara o galería de fotos) para el controlador.
        imagePickerController.sourceType = sourceType
        // Establecemos el delegado del controlador de vista en el coordinador.
        imagePickerController.delegate = context.coordinator
        // Devolvemos el controlador de vista creado.
        return imagePickerController
    }

    // Función requerida por UIViewControllerRepresentable para actualizar el controlador de vista.
    // En este caso, no es necesario actualizar nada, por lo que se deja vacío.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // Función requerida por UIViewControllerRepresentable para crear un coordinador.
    func makeCoordinator() -> Coordinator {
        // Devolvemos una instancia del coordinador con el controlador de finalización.
        Coordinator(completionHandler: completionHandler)
    }

    // Clase Coordinator que actúa como delegado para el UIImagePickerController.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // Un controlador de finalización que se llama cuando se selecciona una imagen o se cancela la selección.
        let completionHandler: (UIImage?) -> Void

        // Inicializador del coordinador.
        init(completionHandler: @escaping (UIImage?) -> Void) {
            // Almacenamos el controlador de finalización.
            self.completionHandler = completionHandler
        }

        // Función de delegado que se llama cuando se selecciona una imagen en el controlador.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Extraemos la imagen seleccionada del diccionario info.
            let image = info[.originalImage] as? UIImage
            // Llamamos al controlador de finalización con la imagen seleccionada.
            completionHandler(image)
            // Descartamos el controlador de vista.
            picker.dismiss(animated: true)
        }

        // Función de delegado que se llama cuando se cancela la selección de una imagen en el controlador.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Llamamos al controlador de finalización con nil para indicar que no se seleccionó ninguna imagen.
            completionHandler(nil)
            // Descartamos el controlador de vista.
            picker.dismiss(animated: true)
        }
    }

}
