//
//  ImagePreviewView.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 08/07/2022.
//

import Foundation
import UIKit

class ImagePreviewView: UIView {
    
    private var backgroundView: UIView = UIView()
    private var containerView: UIView = UIView()
    private var imageView: UIImageView = UIImageView()
    private var closeButton: UIButton = UIButton()
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        // Background view
        self.addSubview(backgroundView)
        backgroundView.backgroundColor = .black
        backgroundView.layer.opacity = 0.5
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // Container
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        containerView.backgroundColor = UIColor.previewBackground
        // Image
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        // Close
        containerView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapOnClose), for: .touchUpInside)
    }
    
    @objc private func didTapOnClose() {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
