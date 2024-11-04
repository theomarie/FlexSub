//
//  ImagePicker.swift
//  FlexSub
//
//  Created by apprenant103 on 25/10/2024.
//

import SwiftUI
import PhotosUI
import Combine


struct ImagePicker : UIViewControllerRepresentable {
    @Binding var image : UIImage?
    
    func makeUIViewController(context : Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Sélectionner uniquement les images
        let picker = PHPickerViewController(configuration : config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController : PHPickerViewController, context : Context) {
        // Non utilisé
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        let parent : ImagePicker
        
        init(_ parent : ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker : PHPickerViewController, didFinishPicking results : [PHPickerResult]) {
            picker.dismiss(animated : true)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print("Erreur lors du chargement de l'image :", error)
                    } else if let image = image as? UIImage {
                        self.parent.image = image
                    }
                }
            }
        }
    }
}
    

