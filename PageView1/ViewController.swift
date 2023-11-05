//
//  ViewController.swift
//  PageView1
//
//  Created by Bao Hoang on 05/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var pageControlView: UIPageControl!
    
    var pageViewController: CustomPageViewController? = nil
    let dataSource = ["ViewController_0", "ViewController_1", "ViewController_2", "ViewController_3", "ViewController_4", "ViewController_5"]
    
    var currentViewControllerIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
    }
    
    private func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        self.pageViewController = pageViewController
        pageControlView.numberOfPages = dataSource.count
        pageControlView.currentPage = currentViewControllerIndex
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        containView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view as Any]
        
        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  metrics: nil,
                                                                  views: views))
        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                  metrics: nil,
                                                                  views: views))
        //        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
        //                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        //                                                                    metrics: nil,
        //                                                                  views: views))
        //        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
        //                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        //                                                                    metrics: nil,
        //                                                                  views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else { return }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    private func detailViewControllerAt(index: Int) -> DataViewController? {
        
        if dataSource.count == 0 || index < 0 || index >= dataSource.count {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        dataViewController.index(ofAccessibilityElement: index)
        dataViewController.displayText = dataSource[index]
        dataViewController.index = index
        
        return dataViewController
    }
    
    @IBAction func backPageView(_ sender: Any) {
        guard let pageViewController = pageViewController
        else { return }
        pageViewController.goToPreviousPage()
    }
    
    @IBAction func nextPageView(_ sender: Any) {
        guard let pageViewController = pageViewController
        else { return }
        pageViewController.goToNextPage()
    }
}

extension ViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers![0] as? DataViewController {
                pageControlView.currentPage = currentViewController.index ?? 0
            }
        }
    }
}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let dataViewController = viewController as? DataViewController,
              let currentIndex = dataViewController.index
        else { return nil }
        
        if currentIndex == 0 {
            return nil
        } else {
            return detailViewControllerAt(index: currentIndex - 1)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let dataViewController = viewController as? DataViewController,
              let currentIndex = dataViewController.index
        else { return nil }
        
        if currentIndex == dataSource.count - 1 {
            return nil
        } else {
            return detailViewControllerAt(index: currentIndex + 1)
        }
    }
}
