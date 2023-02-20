//
//  ItemTableViewCell.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    private lazy var icon: ImageView = {
        let image = ImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        itemTitle.text = title
        icon.loadImage(by: url)
    }
    
}

extension ItemTableViewCell {
    
    func setupView() {
        contentView.addSubview(icon)
        contentView.addSubview(itemTitle)
    }
    
    func setConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 55),
            icon.widthAnchor.constraint(equalToConstant: 55),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            itemTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15),
            itemTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}
