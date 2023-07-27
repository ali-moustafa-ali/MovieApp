//
//  MainTabBarVC.swift
//  tabBar
//
//  Created by Ali Moustafa on 15/06/2023.
//

import UIKit
import os.log

class MainTabBarVC: UITabBarController {
    
    // Replace "Tajawal-Extrabold" with the name of your custom font
    private let customFontName = "RobotoCondensed-Bold"
    private let customFontSize: CGFloat = 15
    
    
    let customTabBarView: UIView = {
        // Create a new UIView instance
        let view = UIView(frame: .zero)
        
        // Set the background color to a blue shade
        view.backgroundColor = #colorLiteral(red: 1, green: 0.4610022902, blue: 0, alpha: 1)
        
        // Set the corner radius of the view's layer to 20 for rounded corners
        view.layer.cornerRadius = 20
        
        // Specify that only the top-left and top-right corners should be rounded
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        // Allow the view's layer to extend beyond its bounds to show the shadow effect
        view.layer.masksToBounds = false
        
        // Set the shadow color to black
        view.layer.shadowColor = UIColor.black.cgColor
        
        // Set the offset of the shadow to (0, -8.0) to position it above the view
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        
        // Set the opacity of the shadow to 0.12 for a slight transparency
        view.layer.shadowOpacity = 0
        
        // Set the radius of the shadow to 10.0 for a blur effect
        view.layer.shadowRadius = 10.0
        
        // Return the configured view
        return view
    }()
    
    //    method is an overridden method in UITabBarController that gets called when the view's layout is about to be updated. In this particular implementation, the code is modifying the frame of the tab bar.
    override func viewWillLayoutSubviews() {
        // Set the height of the tab bar to 90 points
        tabBar.frame.size.height = CGFloat(90)
        
        // Set the vertical origin of the tab bar so that it appears at the bottom of the view with a distance of 90 points from the bottom
        tabBar.frame.origin.y = view.frame.height - CGFloat(90)
    }
    
    /*
     This code is adjusting the appearance of the tab bar by setting its height to 90 points and positioning it at the bottom of the view with a distance of 90 points from the bottom edge. This allows you to customize the height and position of the tab bar according to your desired layout.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        applyCustomTabBarAppearance()
        setupTabBar()
        addCustomTabBarView()
        tabbarDesignSetup()
    }
    
    
    /*
     method is an overridden method in UITabBarController that gets called after the view's layout has been updated. In this particular implementation, the code is adjusting the frames of the tab bar and a custom tab bar view.
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set the height of the tab bar to 90 points
        tabBar.frame.size.height = 83
        
        // Set the vertical origin of the tab bar so that it appears at the bottom of the view with a distance of 90 points from the bottom
        tabBar.frame.origin.y = view.frame.height - 83
        
        // Set the frame of the customTabBarView to match the frame of the tabBar
        customTabBarView.frame = tabBar.frame
    }
    
    private func addCustomTabBarView() {
        // Set the frame of the customTabBarView to match the frame of the tabBar
        customTabBarView.frame = tabBar.frame
        
        // Add the customTabBarView to the view hierarchy
        view.addSubview(customTabBarView)
        
        // Bring the tabBar to the front, ensuring it's visible above the customTabBarView
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    private func tabbarDesignSetup() {
        // Set the tint color of the tab bar
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        // Set the content mode of the tab bar to center
        tabBar.contentMode = .center
        
        // Set the unselected item tint color of the tab bar
        tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Set the background color of the tab bar
        tabBar.barTintColor = #colorLiteral(red: 0.2559205294, green: 0.6358472705, blue: 0.835888803, alpha: 1)
        
        // Set the height and position of the tab bar
        tabBar.frame.size.height = CGFloat(100)
        tabBar.frame.origin.y = view.frame.height - CGFloat(100)
        
        // Set the translucency of the tab bar
        tabBar.isTranslucent = true
        
        // Set the corner radius of the tab bar
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        
        // Set the border width of the tab bar 0.1
        tabBar.layer.borderWidth = 0
        
        // Set the masked corners of the tab bar
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Set the title position adjustment of tab bar items
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }
    
    func createTabBarController(fromStoryboardWithName storyboardName: String, identifier: String, itemTitle: String, itemImageName: String) -> UIViewController {
        // Create a new instance of the storyboard based on the provided name
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        // Instantiate the view controller from the storyboard using the given identifier
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        // Set the title and image of the view controller's tab bar item
        viewController.tabBarItem.title = itemTitle
        viewController.tabBarItem.image = UIImage(named: itemImageName)
        
        // Return the configured view controller
        return viewController
    }
    
    
    func setupTabBar() {
        // Create view controllers for each tab item
        let homeViewController = createTabBarController(fromStoryboardWithName: "MovieSB", identifier: "MoviesViewControllerID", itemTitle: NSLocalizedString("movies_tab_title", comment: ""), itemImageName: "home")
        let discoverViewController = createTabBarController(fromStoryboardWithName: "DiscoverSB", identifier: "DiscoverID", itemTitle: NSLocalizedString("discover_tab_title", comment: ""), itemImageName: "Discover")

        let navCont = UINavigationController(rootViewController: homeViewController)
        let navContr = UINavigationController(rootViewController: discoverViewController)
        // Set the view controllers for the tab bar controller
        viewControllers = [navCont, navContr]
    }
    
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Find the index of the selected item in the tab bar
        guard let index = tabBar.items?.firstIndex(of: item) else {
            return
        }
        
        // Get the subview containing the icon image view
        let subviewIndex = index + 1
        guard let subview = tabBar.subviews[subviewIndex].subviews.first as? UIImageView else {
            return
        }
        
        // Perform the spring animation on the icon image view
        performSpringAnimation(on: subview)
    }
    
    
    
    func performSpringAnimation(on imageView: UIImageView) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            // Scale down the image view
            imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            
            UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                // Further reduce the size of the image view
                imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { _ in
                // Animation completion handler
            }
        }) { _ in
            // Animation completion handler
        }
    }
    
    
    private func applyCustomTabBarAppearance() {
        
        // Define custom font attributes
        if let customFont = UIFont(name: customFontName, size: customFontSize) {
            // Create a dictionary with the custom font attributes
            let fontAttributes = [NSAttributedString.Key.font: customFont]
            // Apply the custom font attributes to the tab bar items
            UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        } else {
            // Fallback to system font if custom font is not available
            let systemFont = UIFont.systemFont(ofSize: 12.0)
            let fontAttributes = [NSAttributedString.Key.font: systemFont]
            UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
            os_log("Custom font '%@' not found. Using system font instead.", log: .default, type: .error, customFontName)
        }
        
    }
    
}


