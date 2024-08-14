//
//  ListViewController.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

protocol ListView: AnyObject {
    func reloadData()
}

class ListViewController: UIViewController, ListView {
    var presenter: ListPresenterInput?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CatCell")
        return tableView
    }()
    
    // Criar o refresh control
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: "CatCell")
        
        // Definir uma altura fixa para as células
        tableView.rowHeight = 100
        
        presenter?.viewDidLoad()
    }

    private func setupView() {
        title = "Cat List"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Configurar o refresh control
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func refreshData() {
        presenter?.viewDidLoad()
    }

    func reloadData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatTableViewCell
        
        if let catItem = presenter?.item(at: indexPath.row) {
            cell.configure(with: catItem, image: nil)  // Iniciar com o spinner
            
            let imageUrlString = "https://cataas.com/cat/\(catItem.id)"
            
            if let imageUrl = URL(string: imageUrlString) {
                loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        if let image = image {
                            cell.configure(with: catItem, image: image)
                        } else {
                            cell.displayError("Failed to load image")
                        }
                    }
                }
            }
        }
        
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
