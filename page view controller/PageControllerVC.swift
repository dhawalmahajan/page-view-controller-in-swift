//
//  PageControllerVC.swift
//  page view controller
//
//  Created by Dhawal Mahajan on 16/09/18.
//  Copyright © 2018 Dhawal Mahajan. All rights reserved.
//

import UIKit

class PageControllerVC: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    lazy var vcArray : [UIViewController] = {
        return [self.vcInstances(name: "firstview"),
                self.vcInstances(name: "secondview"),
                self.vcInstances(name: "thirdview")]
    }()
    
    
    private func vcInstances(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcArray.index(of: viewController) else { return nil }
        let previousVCIndex = vcIndex - 1
        guard previousVCIndex >= 0 else { return vcArray.last }
        guard vcArray.count > previousVCIndex else { return nil }
        return vcArray[previousVCIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let _vcIndex = vcArray.index(of: viewController) else { return nil }
        let nextVCIndex = _vcIndex + 1
        guard nextVCIndex < vcArray.count else { return vcArray.first }
        guard vcArray.count > nextVCIndex else { return nil }
        return vcArray[nextVCIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    } // The number of items reflected in the page indicator.
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first,
            let firstVCIndex = vcArray.index(of: firstVC) else { return 0 }
        
        return firstVCIndex
    }


}
