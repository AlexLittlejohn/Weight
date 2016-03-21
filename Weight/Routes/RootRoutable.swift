//
//  RootRoutable.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/02/24.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit
import ReSwiftRouter

class RootRoutable: Routable {
    let navigationController: UINavigationController
    let rootStoryboard = "Storyboard"
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func setToViewController(animated: Bool, identifier: String, viewControllerClass: AnyClass) -> Routable {
        
        let itemMirror = Mirror(reflecting: viewControllerClass)
        
        if let topViewController = navigationController.topViewController {
            let mirror = Mirror(reflecting: topViewController.self.dynamicType)
            if mirror.subjectType == itemMirror.subjectType {
                return topViewController as! Routable
            }
        }
 
        if let viewController = navigationController.viewControllers.filter({ viewController in
            let mirror = Mirror(reflecting: viewController.self.dynamicType)
            return mirror.subjectType == itemMirror.subjectType
        }).first {
            navigationController.popToViewController(viewController, animated: animated)
            return viewController as! Routable
        }  else {
            let viewController = UIStoryboard(name: rootStoryboard, bundle: nil)
                .instantiateViewControllerWithIdentifier(identifier)
            navigationController.pushViewController(viewController, animated: animated)
            return viewController as! Routable
        }
    }
    
    func setToWeightViewController(animated: Bool) -> Routable {
        return setToViewController(animated, identifier: WeightViewController.identifier, viewControllerClass: WeightViewController.self)
    }
    
    func setToWeightCaptureViewController(animated: Bool) -> Routable {
        return setToViewController(animated, identifier: WeightCaptureViewController.identifier, viewControllerClass: WeightCaptureViewController.self)
    }
    
    func setToDateCaptureViewController(animated: Bool) -> Routable {
        return setToViewController(animated, identifier: DateCaptureViewController.identifier, viewControllerClass: DateCaptureViewController.self)
    }
    
    func changeRouteSegment(to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        completionHandler()
        
        if to == WeightViewController.identifier {
            return setToWeightViewController(animated)
        } else if to == WeightCaptureViewController.identifier {
            return setToWeightCaptureViewController(animated)
        } else if to == DateCaptureViewController.identifier {
            return setToDateCaptureViewController(animated)
        } else {
            fatalError("no valid routes")
        }
    }
    
    func changeRouteSegment(from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        return changeRouteSegment(to, animated: animated, completionHandler: completionHandler)
    }
    
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        return changeRouteSegment(routeElementIdentifier, animated: animated, completionHandler: completionHandler)
    }
    
    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) {
        completionHandler()
    }
}
