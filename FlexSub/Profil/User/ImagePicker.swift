//
//  ImagePicker.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var uiImage: UIImage?
    @ObservedObject var viewModel: AuthViewModel

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.uiImage = image as? UIImage
                    
                    // **Important :** Mettre à jour l'image dans `AuthViewModel`
                    if let uiImage = self.parent.uiImage {
                        DispatchQueue.main.async {
                            self.parent.viewModel.currentUser?.picture = uiImage
                        }
                    }
                }
            }
        }
        
    }
}
