//
//  DetailViewController.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

protocol DetailView: AnyObject {
    func displayCatDetails(for item: CatItem)
}

class DetailViewController: UIViewController, DetailView {
    var presenter: DetailPresenterInput?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "DetailImageView" // Adicionar identificador de acessibilidade
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        
        // Adicionar identificador de acessibilidade à view de detalhes
        self.view.accessibilityIdentifier = "DetailView"
    }

    private func setupView() {
        title = "Cat Details"
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }

    func displayCatDetails(for item: CatItem) {
        label.text = """
        Tags: \(item.tags.joined(separator: ", "))
        MimeType: \(item.mimetype)
        Size: \(item.size)
        """

        // Configurar a URL da imagem
        let imageUrlString = "https://cataas.com/cat/\(item.id)"
        
        // Carregar a imagem de forma assíncrona
        if let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }

    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
