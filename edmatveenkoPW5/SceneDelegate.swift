//
//  SceneDelegate.swift
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 17.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Создаем экземпляр NewsViewController
        let newsViewController = NewsViewController()
        
        // Создаем экземпляры Interactor, Router и Presenter
        let interactor = NewsInteractorImpl()
        let router = NewsRouterImpl(viewController: newsViewController)
        let presenter = NewsPresenterImpl(view: newsViewController, interactor: interactor, router: router)
        
        // Устанавливаем Presenter в ViewController
        newsViewController.presenter = presenter
        
        // Устанавливаем корневой ViewController
        window?.rootViewController = UINavigationController(rootViewController: newsViewController)
        window?.makeKeyAndVisible()
    }
}
