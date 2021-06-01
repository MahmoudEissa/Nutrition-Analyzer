//
//  TextView.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TextView: UITextView {

    // MARK: - Outlets
    fileprivate lazy var placeholderLabel: UILabel  = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = font
        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview().inset(8)
        }
        return label
    }()
    
    // MARK: - Variables
    let disposeBag = DisposeBag()
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    // MARK: - Life Cycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        rx.text.orEmpty.map{!$0.isEmpty}.asDriver(onErrorJustReturn: false)
            .drive(placeholderLabel.rx.isHidden).disposed(by: disposeBag)
        
    }
    
    // MARK: - Functions
    
    // MARK: - Actions

}
