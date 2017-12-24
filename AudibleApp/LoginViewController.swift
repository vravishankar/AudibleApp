//
//  ViewController.swift
//  AudibleApp
//
//  Created by CnC on 23/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate:class {
    func finishLoggingIn()
}

class LoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginViewControllerDelegate {
    


    //MARK: Initializations
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    var pageControlBottomAnchor : NSLayoutConstraint?
    var skipButtonTopAnchor : NSLayoutConstraint?
    var nextButtonTopAnchor : NSLayoutConstraint?

    
    //MARK: Model Declarations
    
    var pages : [Page] = {
        
        let firstPage = Page(title: "Best Restaurant in town", message: "Multi Cuisine restaurant in the heart of the town serving great food in good ambience and excellent taste", imageName: "image1")
        let secondPage = Page(title: "Great Ambience in the center of the town", message: "Excellent Food in the center of the town with great ambience and even wifi facility", imageName: "image2")
        let thirdPage = Page(title: "Blend Great Food with our Exotic Drinks", message: "Our bar is filled with the best drinks across the world carefully picked for the best taste", imageName: "image3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    //MARK: View Components
    
    // lazy to ensure the datasource and delegates set in
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = UIColor.blue
        pc.numberOfPages = 4
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let skipButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return btn
    }()
    
    let nextButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.blue
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        

        
        registerCells()
        
        //add keyboard notifications
        addKeyboardNotifications()
        
        // This will not work in landscape mode
        // collectionView.frame = view.frame
        
        // Autolayout collection view

        //Pin the leading edge of the collection view to the leading edge of superview
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        //Pin the top edge of the collection view to the top edge of superview
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        //Pin the leading edge of the collection view to the leading edge of superview
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //Pin the leading edge of the collection view to the leading edge of superview
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        pageControlBottomAnchor?.isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        skipButtonTopAnchor?.isActive = true
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        nextButtonTopAnchor?.isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    //MARK: Private Methods
    
    @objc private func skip() {
        pageControl.currentPage = pages.count - 1
        nextButtonPressed()
    }
    
    @objc private func nextButtonPressed() {
        
        // while at the last page
        if pageControl.currentPage == pages.count {
            return
        }
        
        // Second from last page
        if pageControl.currentPage == pages.count - 1 {
            
            moveButtonsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

        let indexPath = IndexPath(item: pageControl.currentPage+1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
        pageControl.currentPage += 1
    }
    
    private func registerCells() {
        // register collection view cell
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        //register login view cell
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    private func addKeyboardNotifications() {
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        
        // Getting Keyboard Frame Height
//        if let userInfo = notification.userInfo {
//            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
//            let keyboardShowing = (notification.name == NSNotification.Name.UIKeyboardWillShow)
//        }
        
        let y:CGFloat = UIDevice.current.orientation.isLandscape ? -110 : -60
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    //MARK: ViewControllerDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCollectionViewCell
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCollectionViewCell
        
        let page = pages[(indexPath as NSIndexPath).item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //MARK: LoginViewControllerDelegate
    
    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {
            return
        }
        mainNavigationController.viewControllers = [HomeController()]
        
        UserDefaults.standard.setLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Scroll View Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pagenumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pagenumber
        
        if pagenumber == pages.count {
            moveButtonsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
        }
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    private func moveButtonsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

