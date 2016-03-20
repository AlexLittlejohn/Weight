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
    
    func setToWeightViewController() -> Routable {
        
        guard !(navigationController.topViewController is WeightViewController) else {
            return navigationController.topViewController as! Routable
        }

        if let viewController = navigationController.viewControllers.filter({ $0 is WeightViewController }).first {
            navigationController.popToViewController(viewController, animated: true)
            return viewController as! Routable
        }  else {
            let viewController = UIStoryboard(name: rootStoryboard, bundle: nil)
                .instantiateViewControllerWithIdentifier(WeightViewController.identifier) as! WeightViewController
            navigationController.pushViewController(viewController, animated: true)
            return viewController
        }
    }
    
    func setToWeightCaptureViewController() -> Routable {
        
        guard !(navigationController.topViewController is WeightCaptureViewController) else {
            return navigationController.topViewController as! Routable
        }
        
        if let viewController = navigationController.viewControllers.filter({ $0 is WeightCaptureViewController }).first {
            navigationController.popToViewController(viewController, animated: true)
            return viewController as! Routable
        }  else {
            let viewController = UIStoryboard(name: rootStoryboard, bundle: nil)
                .instantiateViewControllerWithIdentifier(WeightCaptureViewController.identifier) as! WeightCaptureViewController
            navigationController.pushViewController(viewController, animated: true)
            return viewController
        }
    }
    
    func setToDateCaptureViewController() -> Routable {
        
        guard !(navigationController.topViewController is DateCaptureViewController) else {
            return navigationController.topViewController as! Routable
        }
        
        if let viewController = navigationController.viewControllers.filter({ $0 is DateCaptureViewController }).first {
            navigationController.popToViewController(viewController, animated: true)
            return viewController as! Routable
        }  else {
            let viewController = UIStoryboard(name: rootStoryboard, bundle: nil)
                .instantiateViewControllerWithIdentifier(DateCaptureViewController.identifier) as! DateCaptureViewController
            navigationController.pushViewController(viewController, animated: true)
            return viewController
        }
    }
    
    func changeRouteSegment(from: RouteElementIdentifier, to: RouteElementIdentifier, completionHandler: RoutingCompletionHandler) -> Routable {
        
        if to == WeightViewController.identifier {
            completionHandler()
            return setToWeightViewController()
        } else if to == WeightCaptureViewController.identifier {
            completionHandler()
            return setToWeightCaptureViewController()
        } else if to == DateCaptureViewController.identifier {
            completionHandler()
            return setToDateCaptureViewController()
        } else {
            fatalError("no valid routes")
        }
    }
    
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, completionHandler: RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == WeightViewController.identifier {
            completionHandler()
            return setToWeightViewController()
        } else if routeElementIdentifier == WeightCaptureViewController.identifier {
            completionHandler()
            return setToWeightCaptureViewController()
        } else if routeElementIdentifier == DateCaptureViewController.identifier {
            completionHandler()
            return setToDateCaptureViewController()
        } else {
            fatalError("no valid routes")
        }
    }
    
    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier, completionHandler: RoutingCompletionHandler) {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }

}
