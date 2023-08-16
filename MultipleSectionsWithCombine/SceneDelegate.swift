//
//  SceneDelegate.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		/// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
		let window = UIWindow(windowScene: windowScene)
		
		/// 3. Create a view hierarchy programmatically
		let viewController = StoreVC()
		let navigation = UINavigationController(rootViewController: viewController)
		
		/// 4. Set the root view controller of the window with your view controller
		window.rootViewController = navigation
		
		/// 5. Set the window and call makeKeyAndVisible()
		self.window = window
		window.makeKeyAndVisible()
	}
}

