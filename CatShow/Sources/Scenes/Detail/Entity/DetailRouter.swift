//
//  DetailRouter.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

protocol DetailRouterInput {
    func navigateBack()
}

class DetailRouter: DetailRouterInput {
    weak var viewController: UIViewController?

    static func createModule(with item: CatItem) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.catItem = item

        interactor.presenter = presenter

        router.viewController = view

        return view
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
