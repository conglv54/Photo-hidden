//
//  ViewController.swift
//  PhotoPro
//
//  Created by Lê Công on 1/8/15.
//  Copyright (c) 2015 Lê Công. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var assets: PHAsset!
    private var userAlbums: PHFetchResult!
    private var userFavorites: PHFetchResult!
    private var allPhotos: PHFetchResult!

    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (PHAuthorizationStatus) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                switch PHAuthorizationStatus {
                case .Authorized:
                    self.fetchCollections()
                    break
                default:
                    break
                }
            })
        }
    }

    func fetchCollections() {
        userAlbums = PHCollection.fetchTopLevelUserCollectionsWithOptions(nil)
        userFavorites = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumFavorites, options: nil)
        allPhotos = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        
        tbl.reloadData()
        
//        PHCachingImageManager.defaultManager().requestImageForAsset(allPhotos[1] as PHAsset, targetSize: CGSizeMake(100, 100), contentMode: PHImageContentMode.AspectFill, options: PHImageRequestOptions()) { ( image: UIImage!, [NSObject : AnyObject]!) -> Void in
//            self.imv.image = image
//        }
        
        println("User Albums " + userAlbums.count.description + "User Favorites: " + userFavorites.count.description)
    }
    
    //MARK - Tableview Delegate & Datasource 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = allPhotos {
            return photos.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let asset = allPhotos[indexPath.row] as PHAsset
        
        PHImageManager.defaultManager().requestImageDataForAsset(asset, options: nil) { (data: NSData!, string: String!, UIImageOrientation, [NSObject : AnyObject]!) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let img = UIImage(data: data)
                cell.imageView?.image = img
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
            let asset = self.allPhotos[indexPath.row] as PHAsset
            PHAssetChangeRequest.deleteAssets([asset])
        }, completionHandler: { (Bool, NSError) -> Void in
            self.tbl.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

