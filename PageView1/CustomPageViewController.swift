//
//  CustomPageViewController.swift
//  PageView1
//
//  Created by Bao Hoang on 05/11/2023.
//

import UIKit

class CustomPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
                
                //update pageControlView.currentPage
                delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
            }
        }
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController){
                setViewControllers([previousPage], direction: .reverse, animated: true, completion: completion)
                
                //update pageControlView.currentPage
                delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
            }
        }
    }
}
