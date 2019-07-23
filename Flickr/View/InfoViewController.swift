//
//  InfoViewController.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 22/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var photo: PhotoRequest.Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "Info View"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        Services.getInfo(photoid: photo.id!, success: { photoInfo in
            
            self.descriptionLabel.text = photoInfo?.description
            self.dateLabel.text = self.formatDate(photoInfo?.dateuploaded)
            self.title = photoInfo?.title
                
            Services.getSizes(photoid: photoInfo!.id!, success: { sizes in

                var sourceURL: URL!
                if let size = sizes?.first(where: { $0.label?.lowercased() == "original"}) {
                    sourceURL = URL(string: size.source!)
                } else {
                    sourceURL = URL(string: sizes!.last!.source!)
                }
                
                self.imageView?.sd_setImage(with: sourceURL) { (image, _, _, _) in
                    self.updateAspectRatioConstraint(image: image)
                }
            }, fail: { error in
                self.showError(error)
            })

        }, fail: { error in
            self.showError(error)
        })
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return formatter.string(from: date)
    }
    
    private func updateAspectRatioConstraint(image: UIImage?) {
        
        imageView.addConstraint(NSLayoutConstraint(item: imageView!,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: imageView,
                                                   attribute: .width,
                                                   multiplier: image!.size.width / image!.size.height,
                                                   constant: 0))
    }
}
