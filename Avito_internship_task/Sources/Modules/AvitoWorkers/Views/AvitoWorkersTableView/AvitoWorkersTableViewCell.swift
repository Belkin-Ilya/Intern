//
//  AvitoWorkersTableViewCell..swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 21.10.2022.
//

import UIKit

final class AvitoWorkersTableViewCell: UITableViewCell {
    // MARK: - Public Propertires
    
    static let identifier = "AvitoWorkersTableViewCell"
    
    // MARK: - Private Propertires
    
    private let namedAvatar = "avatar"
    
    private enum LayoutConstants {
        enum StackView {
            static let topAnchor: CGFloat = 10
            static let leadingAnchor: CGFloat = 30
            static let trailingAnchor: CGFloat = -30
            static let bottomAnchor: CGFloat = -10
            static let spacing: CGFloat = 10
        }
        
        enum ImageView {
            static let leadingAnchor: CGFloat = 40
            static let heightAnchor: CGFloat = 40
            static let widthAnchor: CGFloat = 40
        }
        
        enum DescriptionLabel {
            static let numberOfLines: Int = 0
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(axis: .vertical, spacing: LayoutConstants.StackView.spacing, alignment: .leading).forAutolayout
        return stack
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView().forAutolayout
        imageView.image = UIImage(named: namedAvatar)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel().forAutolayout
        label.font = UIFont.avenirNextDemiBoldSize20()
        return label
    }()
    
    private lazy var numberPhoneLabel: UILabel = {
        let label = UILabel().forAutolayout
        label.font = UIFont.avenirNextSize14()
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel().forAutolayout
        label.font = UIFont.avenirNextSize14()
        label.numberOfLines = LayoutConstants.DescriptionLabel.numberOfLines
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupHierarchy()
        setConstraintsForStackView()
        setConstraintsForImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public Methods
    
    func configure(model: ListViewModel) {
        nameLabel.text = model.name
        numberPhoneLabel.text = model.phoneNumber
        skillsLabel.text = model.skills
    }
    
    // MARK: - Private Methods
    
    private func setupHierarchy() {
        [stackView, image].forEach { subView in contentView.addSubview(subView) }
        [nameLabel, numberPhoneLabel, skillsLabel].forEach  { stackView.addArrangedSubview($0) }
    }
    
    private func setConstraintsForStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.StackView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: LayoutConstants.StackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.StackView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.StackView.bottomAnchor)
        ])
    }
    
    private func setConstraintsForImage() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: stackView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.ImageView.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: LayoutConstants.ImageView.heightAnchor),
            image.widthAnchor.constraint(equalToConstant: LayoutConstants.ImageView.widthAnchor)
        ])
    }
}
