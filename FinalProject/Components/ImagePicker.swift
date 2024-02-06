//
//  ImagePicker.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    // MARK: - Properties
    @Binding var image: UIImage?
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // MARK: - Properties
        let parent: ImagePicker
        
        // MARK: - Inits
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // MARK: - Methods
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
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

