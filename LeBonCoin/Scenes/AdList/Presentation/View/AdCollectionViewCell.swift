//
//  AdCollectionViewCell.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 04/07/2022.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AdCollectionViewCell"
    
    private let thumbnailImageView: UIImageDownloaderView = UIImageDownloaderView()
    private let categoryLabel: UILabel = UILabel()
    private let urgentTagView: UIView = UIView()
    private let urgentLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    private let creationDateLabel: UILabel = UILabel()
    private let categoryBgView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configure(model: ClassifiedAd, category: AdCategory?) {
        categoryLabel.attributedText = (category?.name ?? "AD_LIST_UKNOWN_CATEGORY".localized).attributedText(color: UIColor.category, font: TypoGraphy.AdList.category)
        titleLabel.attributedText = model.title.attributedText(color: UIColor.adTitle, font: TypoGraphy.AdList.title)
        priceLabel.attributedText = model.priceLiteral.attributedText(color: UIColor.price, font: TypoGraphy.AdList.price)
        creationDateLabel.attributedText = (model.creationDate?.toAdDateString ?? "").attributedText(color: UIColor.creationDate, font: TypoGraphy.AdList.creationDate)
        thumbnailImageView.load(with: URL(string: model.imagesUrl.small ?? ""), placeholder: UIImage.placeHolder)
        urgentTagView.isHidden = !model.isUrgent
    }
    
    private func setupViews() {
        // Thumbnail
        self.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.70).isActive = true
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        // Urgent View
        self.addSubview(urgentTagView)
        urgentTagView.translatesAutoresizingMaskIntoConstraints = false
        urgentTagView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        urgentTagView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        urgentTagView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor).isActive = true
        urgentTagView.backgroundColor = UIColor.urgentBackground
        urgentTagView.layer.cornerRadius = 7
        // Urgent Label
        urgentTagView.addSubview(urgentLabel)
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.topAnchor.constraint(equalTo: urgentTagView.topAnchor, constant: 4.0).isActive = true
        urgentLabel.bottomAnchor.constraint(equalTo: urgentTagView.bottomAnchor, constant: -4.0).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: urgentTagView.leadingAnchor, constant: 4.0).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: urgentTagView.trailingAnchor, constant: -4.0).isActive = true
        urgentLabel.attributedText = "AD_LIST_URGENT".localized.attributedText(color: UIColor.urgent, font: TypoGraphy.AdList.urgent)
        urgentTagView.isHidden = true
        // Category background view
        self.addSubview(categoryBgView)
        categoryBgView.translatesAutoresizingMaskIntoConstraints = false
        categoryBgView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8.0).isActive = true
        categoryBgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        categoryBgView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor).isActive = true
        categoryBgView.backgroundColor = UIColor.categoryBackground
        categoryBgView.layer.cornerRadius = 7
        // Category Label
        categoryBgView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: categoryBgView.topAnchor, constant: 4.0).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: categoryBgView.bottomAnchor, constant: -4.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: categoryBgView.leadingAnchor, constant: 4.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: categoryBgView.trailingAnchor, constant: -4.0).isActive = true
        // Title Label
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.numberOfLines = 2
        // Price Label
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // Creation date label
        self.addSubview(creationDateLabel)
        creationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        creationDateLabel.topAnchor.constraint(greaterThanOrEqualTo: priceLabel.bottomAnchor, constant: 4.0).isActive = true
        creationDateLabel.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor).isActive = true
        creationDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        creationDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        creationDateLabel.textAlignment = .right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
