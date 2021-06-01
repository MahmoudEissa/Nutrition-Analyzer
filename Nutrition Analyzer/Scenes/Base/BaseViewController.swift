//
//  BaseViewController.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit
import RxSwift

class BaseViewController:  UIViewController {
    
    // MARK: - Outlets
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .link
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()
    
    // MARK: - Variables
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    func setupView() {
        bindViewsToViewModel()
        bindViewModelToViews()
        setupCallbacks()
    }
    
    func bindViewsToViewModel() { }
    func bindViewModelToViews() { }
    func setupCallbacks() { }
    
    func showAlert(title : String?, message: String?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .destructive))
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
