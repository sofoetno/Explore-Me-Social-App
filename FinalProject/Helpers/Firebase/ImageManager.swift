//
//  ImageManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import FirebaseStorage
import Foundation

final class ImageManager {
    // MARK: - Static properties
    static let shared = ImageManager()
    
    // MARK: - Properties
    private let storage = Storage.storage().reference()
    
    // MARK: - Inits
    private init() { }
    
    // MARK: - Methods
    func saveImage(data: Data) async throws -> (path: String, name: String, downloadUrl: URL) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        let downloadUrl = try await Storage.storage().reference(withPath: returnedPath).downloadURL()
        
        return (returnedPath, returnedName, downloadUrl)
        
    }
}
