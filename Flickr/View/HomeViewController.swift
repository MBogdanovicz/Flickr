//
//  HomeViewController.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 22/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {

    private var userid: String!
    private var page = 1
    private var photoArray: [PhotoRequest.Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "Home View"
        findByUsername()
    }
    
    private func findByUsername() {
        showLoading()
        Services.findByUsername("eyetwist", success: { userid in
            
            if let userid = userid {
                self.userid = userid
                self.page = 1
                self.getPublicPhotos()
            }
            
        }) { error in
            self.showError(error)
        }
    }
    
    private func getPublicPhotos() {
        Services.getPublicPhotos(userid: userid, page: page, success: { photoRequest in
            
            if let photo = photoRequest?.photo {
                if self.page == 1 {
                    self.photoArray = [PhotoRequest.Photo]()
                }
                self.photoArray?.append(contentsOf: photo)
                self.collectionView.reloadData()
                self.hideLoading()
            }
        }, fail: { error in
            self.showError(error)
        })
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let photo = sender as? PhotoRequest.Photo {
            let infoViewController = segue.destination as! InfoViewController
            infoViewController.photo = photo
        }
    }
    
    private func formatPhotoURL(_ photo: PhotoRequest.Photo) -> URL {
        return URL(string: "https://farm\(photo.farm!).staticflickr.com/\(photo.server!)/\(photo.id!)_\(photo.secret!)_t.jpg")!
    }
    
    @objc override func tryAgain() {
        findByUsername()
    }
    
    private func showLoading() {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.startAnimating()
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.black
        view.alpha = 0.8
        view.addSubview(activity)
        view.tag = 100
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        self.view.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            view.widthAnchor.constraint(equalToConstant: 150),
            view.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            ])
    }
    
    private func hideLoading() {
        let view = self.view.viewWithTag(100)
        UIView.animate(withDuration: 0.3, animations: {
            view?.alpha = 0
        }) { _ in
            view?.removeFromSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photoArray![indexPath.row]
        performSegue(withIdentifier: "infoSegue", sender: photo)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(100) as! UIImageView
        let photo = photoArray![indexPath.row]
        
        imageView.sd_setImage(with: formatPhotoURL(photo))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let photoArray = self.photoArray else {
            return
        }
        
        if indexPath.row >= photoArray.count - 5 {
            page += 1
            getPublicPhotos()
        }
    }
}
