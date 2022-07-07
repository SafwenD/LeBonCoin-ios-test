//
//  AdDetailsViewController.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//  

import UIKit

class AdDetailsViewController: UIViewController {

    // MARK: - Private properties
    private var viewModel: AdDetailsViewModelProtocol?
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var adImageView: UIImageDownloaderView = UIImageDownloaderView()
    private var categoryLabel: UILabel = UILabel()
    private var dateLabel: UILabel = UILabel()
    private var categoryBgView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var descriptionHeadLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private let urgentTagView: UIView = UIView()
    private let urgentLabel: UILabel = UILabel()
    
    // MARK: - View lifecycle

    init(viewModel: AdDetailsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Display logic
    private func setupViews() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        self.title = "AD_DETAIL_PAGE_TITLE".localized
        // Scroll View
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        // Content View
        self.scrollView.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // Image
        self.contentView.addSubview(adImageView)
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        adImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        adImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        adImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.35).isActive = true
        adImageView.isUserInteractionEnabled = true
        adImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnImage)))
        // category
        self.contentView.addSubview(categoryBgView)
        categoryBgView.translatesAutoresizingMaskIntoConstraints = false
        categoryBgView.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: 8.0).isActive = true
        categoryBgView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8.0).isActive = true
        categoryBgView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor).isActive = true
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
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: categoryBgView.bottomAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        titleLabel.numberOfLines = 0
        // Price Label
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        // Date Label
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: 8.0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        // description title Label
        contentView.addSubview(descriptionHeadLabel)
        descriptionHeadLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionHeadLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12.0).isActive = true
        descriptionHeadLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        descriptionHeadLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        descriptionHeadLabel.attributedText = "AD_DETAIL_DESCRIPTION".localized.attributedText(color: UIColor.adTitle, font: TypoGraphy.AdDetails.descriptionTitle)
        // description Label
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: descriptionHeadLabel.bottomAnchor, constant: 8.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8.0).isActive = true
        descriptionLabel.numberOfLines = 0
        // Urgent View
        contentView.addSubview(urgentTagView)
        urgentTagView.translatesAutoresizingMaskIntoConstraints = false
        urgentTagView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        urgentTagView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        urgentTagView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
        urgentTagView.backgroundColor = UIColor.urgentBackground
        urgentTagView.layer.cornerRadius = 7
        // Urgent Label
        urgentTagView.addSubview(urgentLabel)
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.topAnchor.constraint(equalTo: urgentTagView.topAnchor, constant: 4.0).isActive = true
        urgentLabel.bottomAnchor.constraint(equalTo: urgentTagView.bottomAnchor, constant: -4.0).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: urgentTagView.leadingAnchor, constant: 4.0).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: urgentTagView.trailingAnchor, constant: -4.0).isActive = true
        urgentLabel.attributedText = "AD_DETAIL_URGENT".localized.attributedText(color: UIColor.urgent, font: TypoGraphy.AdDetails.urgent)
        urgentTagView.isHidden = true
    }
    
    private func updateUI() {
        adImageView.load(with: URL(string: viewModel?.ad.imagesUrl.thumb ?? ""), placeholder: UIImage.placeHolder)
        categoryLabel.attributedText = (viewModel?.categoryName ?? "").attributedText(color: UIColor.category, font: TypoGraphy.AdDetails.category)
        titleLabel.attributedText = (viewModel?.ad.title ?? "").attributedText(color: UIColor.adTitle, font: TypoGraphy.AdDetails.title)
        priceLabel.attributedText = (viewModel?.ad.priceLiteral ?? "").attributedText(color: UIColor.price, font: TypoGraphy.AdDetails.price)
        dateLabel.attributedText = (viewModel?.ad.creationDate?.toAdDateString ?? "").attributedText(color: UIColor.price, font: TypoGraphy.AdDetails.creationDate)
        descriptionLabel.attributedText = (viewModel?.ad.description ?? "").attributedText(color: UIColor.desc, font: TypoGraphy.AdDetails.description)
        urgentTagView.isHidden = !(viewModel?.ad.isUrgent ?? false)
    }
    
    @objc private func didTapOnImage() {
        guard let image = self.adImageView.image else { return }
        presentPreview(forImage: image)
    }
    
    private func presentPreview(forImage image: UIImage) {
        let preview = ImagePreviewView(frame: self.view.frame, image: image)
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        self.view.addSubview(preview)
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        preview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        preview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        preview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
