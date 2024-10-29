//
//  ImagePicker.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI
import PhotosUI

 public struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
     

     public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

     public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }

     public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

     public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
