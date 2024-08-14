//
//  SceneDelegate.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
                   
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let listModule = ListRouter.createModule()
        window?.rootViewController = listModule
        window?.makeKeyAndVisible()
    }
}
