//
//  CustomLaunchScreenViewController.swift
//  MarvelApp
//
//  Created by Maged on 20/02/2024.
//

import UIKit

class CustomLaunchScreenViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var logoImage: UIImageView!
    
    // MARK: - Properties
    var coordinator: Coordinator?

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLogo()
        animateProgressBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Method
    private func animateLogo() {
        // Customize the animation properties
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.logoImage.transform = CGAffineTransform(translationX: 0, y: 20)
        }, completion: nil)
    }
    
    private func animateProgressBar() {
        // Set the initial progress to 0
        progressBar.setProgress(0.0, animated: false)

        // Animate the progress gradually over a sequence of durations
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.progressBar.setProgress(0.10, animated: true)
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.progressBar.setProgress(0.20, animated: true)
            }) { _ in
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    self.progressBar.setProgress(0.30, animated: true)
                }) { _ in
                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                        self.progressBar.setProgress(0.50, animated: true)
                    }) { _ in
                        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                            self.progressBar.setProgress(0.70, animated: true)
                        }) { _ in
                            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                                self.progressBar.setProgress(1.0, animated: true)
                            }) { _ in
                                // Completion block is called after the animation completes
                                // Delay for an additional 1 second (adjust as needed)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    // Navigate to the next screen (e.g., your main view controller)
                                    self.navigateToNextScreen()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func navigateToNextScreen() {
        guard let windowScene = self.view.window?.windowScene else { return }
        let navigationController = UINavigationController()
        let coordinator = Coordinator(navigationController: navigationController)
        coordinator.start()
        let mainViewController = ListOfCharactersViewController(nibName: "ListOfCharactersViewController", bundle: nil)
        navigationController.pushViewController(mainViewController, animated: true)
        self.view.window?.windowScene = windowScene
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }

    // MARK: - Action
}
