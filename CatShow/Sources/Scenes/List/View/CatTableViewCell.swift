//
//  CatTableViewCell.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    
    private let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(catImageView)
        contentView.addSubview(tagsLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            // Configuração do catImageView
            catImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            catImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            catImageView.widthAnchor.constraint(equalToConstant: 80),
            catImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Configuração do activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: catImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: catImageView.centerYAnchor),
            
            // Configuração do tagsLabel
            tagsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tagsLabel.leftAnchor.constraint(equalTo: catImageView.rightAnchor, constant: 10),
            tagsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            // Configuração do sizeLabel
            sizeLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 5),
            sizeLabel.leftAnchor.constraint(equalTo: catImageView.rightAnchor, constant: 10),
            sizeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with catItem: CatItem, image: UIImage?) {
        tagsLabel.text = catItem.tags.joined(separator: ", ")
        sizeLabel.text = "Size: \(catItem.size) bytes"
        
        if let image = image {
            catImageView.image = image
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
            catImageView.image = nil
        }
    }
    
    func displayError(_ error: String) {
        tagsLabel.text = error
        sizeLabel.text = ""
        catImageView.image = nil
        activityIndicator.stopAnimating()
    }
}
