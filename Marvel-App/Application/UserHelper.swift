//
//  UserHelper.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit

class UserHelper {
    
    static func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
    
    static func getImageUrl(thumbnail: Thumbnail?) -> String {
        return (thumbnail?.path ?? "")+"."+(thumbnail?.thumbnailExtension ?? "jpg")
    }
    
    static func openLink(link: String ) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
}
