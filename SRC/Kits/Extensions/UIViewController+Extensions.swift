//
//  UIViewController+Extensions.swift

import Foundation
import UIKit

extension UIViewController {
    
    static var name: String {
        return String(describing: self)
    }
   
    func set(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func present(_ controller: UIViewController,
                 modalTransitionStyle: UIModalTransitionStyle,
                 modalPresentationStyle: UIModalPresentationStyle,
                 animated flag: Bool,
                 completion: (() -> Swift.Void)? = nil) {
        controller.modalTransitionStyle = modalTransitionStyle
        controller.modalPresentationStyle = modalPresentationStyle
        self.present(controller, animated: flag, completion: completion)
    }
    
    var isModal: Bool {
        return presentingViewController != nil ||
            navigationController?.presentingViewController?.presentedViewController === navigationController ||
            tabBarController?.presentingViewController is UITabBarController
    }
}

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message : String, onDismiss: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in 
            
            onDismiss?()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    func setSafeAreaTop(for view: UIView?,
                          topConstraint: NSLayoutConstraint?,
                          constant: CGFloat = 0 ) {
        if #available(iOS 11.0, *) { } else { // IOS 10 and later
            topConstraint?.isActive = false
            view?
                .topAnchor
                .constraint(equalTo: topLayoutGuide.bottomAnchor,
                            constant: constant).isActive = true
        }
    }
}

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ControllerType
    static var storyboardName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ControllerType
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardName: String {
        return String(describing: self)
    }
   
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = storyboardName
        let storyboard = Self.storyboard(name: fileName, bundle: bundle)
        
        return storyboard.instantiateInitialViewController() as! Self
    }
    
    static func instantiateViewController(identifier: String, bundle: Bundle? = nil) -> Self {
        let storyboard = Self.storyboard(name: identifier, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    static func instantiateViewControllerFromMain(identifier: String, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    private static func storyboard(name: String, bundle: Bundle? = nil) -> UIStoryboard {
        let fileName = storyboardName
        assert((bundle ?? Bundle.main).path(forResource: name, ofType: "storyboardc") != nil,
               "Can't load storyboard of given name")
        
        return UIStoryboard(name: fileName, bundle: bundle)
    }
}
