//
//  ListInteractor.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import Foundation

protocol ListInteractorInput {
    func fetchCatItems()
}

protocol ListInteractorOutput: AnyObject {
    func didFetchCatItems(_ items: [CatItem])
    func didFailFetchingCatItems(with error: Error)
}

class ListInteractor: ListInteractorInput {
    weak var presenter: ListInteractorOutput?

    func fetchCatItems() {
        guard let url = URL(string: "https://cataas.com/api/cats?tags=cute") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.presenter?.didFailFetchingCatItems(with: error)
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"]) as Error
                self.presenter?.didFailFetchingCatItems(with: error)
                return
            }

            do {
                let items = try JSONDecoder().decode([CatItem].self, from: data)
                self.presenter?.didFetchCatItems(items)
            } catch {
                self.presenter?.didFailFetchingCatItems(with: error)
            }
        }

        task.resume()
    }
}
