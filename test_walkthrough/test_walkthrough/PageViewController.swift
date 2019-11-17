//
//  PageViewController.swift
//  test_walkthrough
//
//  Created by tessy0901 on 2019/11/15.
//  Copyright © 2019 tessy0901. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var pageViewControllers: [UIViewController] = []
    var nowPage: Int = 0
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self

        //インスタンス化
        let pageViewA = storyboard!.instantiateViewController(withIdentifier: "AViewController") as! AViewController
        let pageViewB = storyboard!.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        let pageViewC = storyboard!.instantiateViewController(withIdentifier: "CViewController") as! CViewController
        pageViewControllers = [pageViewA, pageViewB, pageViewC]

        //最初に表示するページの指定
        self.setViewControllers([pageViewControllers[0]], direction: .forward, animated: true, completion: nil)

        pageViewA.onButtonTapped = {
            self.currentPage = 1
            self.setViewControllers([self.pageViewControllers[1]], direction: .forward, animated: true, completion: nil)
        }
        pageViewB.onButtonTapped = {
            self.currentPage = 2
            self.setViewControllers([self.pageViewControllers[2]], direction: .forward, animated: true, completion: nil)
        }
        pageViewC.onButtonTapped = {
            self.currentPage = 0
            self.setViewControllers([self.pageViewControllers[0]], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    //全ページ数を返すメソッド
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    //現在のページを返すメソッド
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.firstIndex(of: viewController)
        if index == 0 {
            return nil
        } else {
            return pageViewControllers[index!-1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.firstIndex(of: viewController)
        if index == pageViewControllers.count - 1 {
            return nil
        } else {
            return pageViewControllers[index!+1]
        }
    }
}
