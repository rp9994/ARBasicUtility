//
//  PhotoAssetManager.swift
//  VideoApp
//
//  Created by Vikash on 15/11/18.
//  Copyright © 2018 Vikash. All rights reserved.
//

import Foundation
import Photos

class PhotoAssetManager {
    
 typealias AlbumCreationBlock = (PHAssetCollection?)->()
    
    static let shared = PhotoAssetManager()
    
    private init() { }
    
    let App_Album_Name = "MowMow"
    
    func saveVideoFrom(url: URL, completion: @escaping (PHAsset?) -> Void)  {
        
        func save() {
            self.createAlbum { (album) in
                guard let album = album else { return }
                
                var placeholder: PHObjectPlaceholder?
                
                PHPhotoLibrary.shared().performChanges({
                    let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                    
                    guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                    let videoPlaceholder = createAssetRequest?.placeholderForCreatedAsset else { return }
                    
                    placeholder = videoPlaceholder
                    
                    let fastEnumeration =  [videoPlaceholder]
                    albumChangeRequest.addAssets(fastEnumeration as NSFastEnumeration)
                    
                }, completionHandler: { (success, error) in
                    guard let placeholder = placeholder else {
                        completion(nil)
                        return
                    }
                    if success {
                        let assets:PHFetchResult<PHAsset> =  PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                        let asset:PHAsset? = assets.firstObject
                    
                        completion(asset)
                    } else {
                        completion(nil)
                    }

                })

            }
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            save()
        } else {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    save()
                }
            })
        }
        
    }
    

   func createAlbum(completion: @escaping AlbumCreationBlock) {
        let albumName = App_Album_Name
        if let album = findAlbum(name: albumName) {
            completion(album)
        } else {
            createAlbum(name: albumName, completion: completion)
        }
    }

    func findAlbum(name: String) -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", name)
        let fetchResult : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        guard let photoAlbum = fetchResult.firstObject else {
            return nil
        }
        return photoAlbum
    }

    
    func createAlbum(name: String, completion: @escaping AlbumCreationBlock) {
        var albumPlaceholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
        }, completionHandler: { success, error in
            if success {
                guard let placeholder = albumPlaceholder else {
                    completion(nil)
                    return
                }
                let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                guard let album = fetchResult.firstObject else {
                    completion(nil)
                    return
                }
                completion(album)
            } else {
                completion(nil)
            }
        })
    }
    
    
     func saveImage(image: UIImage, album: PHAssetCollection, completion:((PHAsset?)->())? = nil) {
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
            placeholder = photoPlaceholder
            let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
            albumChangeRequest.addAssets(fastEnumeration)
        }, completionHandler: { success, error in
            guard let placeholder = placeholder else {
                completion?(nil)
                return
            }
            if success {
                let assets:PHFetchResult<PHAsset> =  PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                let asset:PHAsset? = assets.firstObject
                completion?(asset)
            } else {
                completion?(nil)
            }
        })
    }

    
    func getPhotoAssetsFrom(album: String) -> PHFetchResult<PHAsset>? {
        if let albumbObj = findAlbum(name: album) {
            let assets = PHAsset.fetchAssets(in: albumbObj, options: nil)
            return assets
        }
        return nil
    }

    func getAllPhotoAssets() -> PHFetchResult<PHAsset>? {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        return allPhotos
    }
    
    func delete(asset: PHAsset, completion:@escaping (Bool)-> Void) {
        PHPhotoLibrary.shared().performChanges( {
            PHAssetChangeRequest.deleteAssets([asset] as NSFastEnumeration)
        }, completionHandler: { success, error in
            print("Finished deleting asset.: ", (success ? "Success" : error!.localizedDescription))
            DispatchQueue.main.async {
                completion(success)
            }
        })
    }
    
    
    func getImage(from asset: PHAsset, with size: CGSize = PHImageManagerMaximumSize, completion: @escaping (UIImage?)-> Void) {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        // this one is key
        requestOptions.isSynchronous = true

        DispatchQueue.global().async {
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .default, options: requestOptions) { (image, info) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
}
