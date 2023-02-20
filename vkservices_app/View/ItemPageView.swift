//
//  ItemPageView.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

final class ItemPageView: UIView {

    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var desc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var serviceURL: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addGesture()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addGesture() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(URLClicked(_:)))
        serviceURL.addGestureRecognizer(gesture)
    }

    func configure(item: Item) {
        guard let url = URL(string: item.icon_url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.icon.image = UIImage(data: data)
            }
        }.resume()
        itemTitle.text = item.name
        desc.text = item.description
        serviceURL.text = item.service_url
    }
}


private extension ItemPageView {

    @objc func URLClicked(_ sender: UITapGestureRecognizer) {
        guard let url = (sender.view as? UILabel)?.text else { return }
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}


private extension ItemPageView {

    func setupView() {
        addSubview(icon)
        addSubview(itemTitle)
        addSubview(serviceURL)
        addSubview(desc)
        backgroundColor = .systemBackground
    }

    func setConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        desc.translatesAutoresizingMaskIntoConstraints = false
        serviceURL.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icon.bottomAnchor.constraint(equalTo: itemTitle.topAnchor, constant: -20),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: 180),
            icon.heightAnchor.constraint(equalToConstant: 180),

            itemTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            desc.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 20),
            desc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            desc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            desc.heightAnchor.constraint(equalToConstant: 80),

            serviceURL.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 25),
            serviceURL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            serviceURL.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
