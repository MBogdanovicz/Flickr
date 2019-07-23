//
//  UIViewControllerExtensions.swift
//  Flickr
//
//  Created by Marcelo Bogdanovicz on 23/07/19.
//  Copyright © 2019 Flickr. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(_ error: Error?) {
        let label = UILabel(frame: CGRect.zero)
        label.text = error?.localizedDescription
        label.numberOfLines = 0
        
        let button = UIButton(type: .system)
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(removeErrorViewAndTryAgain), for: .touchUpInside)
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        view.addSubview(button)
        view.tag = 123
        
        let viewController = UIApplication.shared.keyWindow!.rootViewController
        viewController?.view.addSubview(view)
        
        setupErrorConstraints(label: label, button: button, container: view)
    }
    
    private func setupErrorConstraints(label: UILabel, button: UIButton, container: UIView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalTo: container.superview!.heightAnchor, constant: 0),
            container.widthAnchor.constraint(equalTo: container.superview!.widthAnchor, constant: 0)
            ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 16),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16)
            ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
            label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16),
            label.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: container.topAnchor, multiplier: 16)
            ])
    }
    
    @objc private func removeErrorViewAndTryAgain() {
        let viewController = UIApplication.shared.keyWindow!.rootViewController
        let view = viewController?.view.viewWithTag(123)
        view?.removeFromSuperview()
        
        tryAgain()
    }
    
    @objc func tryAgain() {
    }
}

