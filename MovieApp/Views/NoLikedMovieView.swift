//
//  NoLikedMovieView.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 3.03.2023.
//

import UIKit

protocol NoLikedMovieDelegate : AnyObject {
        
    func goToMoviesPage(_ noLikedMovieView: NoLikedMovieView )
    
}
class NoLikedMovieView: UIView {
    
    weak var delegate : (NoLikedMovieDelegate)?
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("ilk Filmini Beğen", for: .normal)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(button)
        button.addTarget(self,
                         action: #selector(tapButton),
                         for: .touchUpInside)
        clipsToBounds = true
        isHidden = true
    }
    
    @objc func tapButton() {
        delegate?.goToMoviesPage(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: height-40, width: width, height: 40)
        label.frame = CGRect(x: 0, y: 0, width: width, height: height-45)
    }
    
    public func configure(viewModel: NoViewModel ) {
        button.setTitle(viewModel.actionTitle, for: .normal)
        label.text = viewModel.text
    }
    
    
    
   
}

struct NoViewModel {
    let text: String
    let actionTitle: String
}


extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var right: CGFloat {
        return left + width
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var bottom: CGFloat {
        return top + height
    }
}
