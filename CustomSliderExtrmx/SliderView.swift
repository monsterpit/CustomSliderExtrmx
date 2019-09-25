//
//  SliderView.swift
//  CustomSliderExtrmx
//
//  Created by MyGlamm on 9/25/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class SliderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private let roundedCornerView = UIView()
    
    private var colorCodeViews : [UIColor] = []
    
    private var cellId = "cell"
    
    private var circleView : UIImageView = UIImageView()
    
    private var lastSelectedCell : IndexPath = IndexPath(item: 0, section: 0)
    
    var skinToneCollectionView : UICollectionView!
    
    var selectedIndex : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    required init(colors : [UIColor],cornerRadius : CGFloat,isGradientView : Bool = false ) {
        super.init(frame: CGRect.zero)
        
        colorCodeViews = colors
        
        
        roundedCornerView(cornerRadius : cornerRadius)

        

        setupSkinToneView()
        
        
        circleView.image = makeCircleWith(imageSize: 50,backgroundColor: #colorLiteral(red: 0.7805789832, green: 0.02354164009, blue: 0.9616711612, alpha: 1))
//        circleView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        
////        let attribute = skinToneCollectionView.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))
////        circleView.frame = attribute?.frame ?? CGRect.zero
////        print(circleView.frame )
        
        
        
        super.addSubview(circleView)
        

        

        
//        let stackView = UIStackView()
//
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
        
        

        
        
//        let button1 = UIButton()
//        button1.backgroundColor = #colorLiteral(red: 1, green: 0.6661287546, blue: 0.656347692, alpha: 1)
//
//        button1.addTarget(self, action:#selector(didTap(_:)), for: .touchUpInside)
//
//        let button2 = UIButton()
//        button2.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//        button2.addTarget(self, action:#selector(didTap(_:)), for: .touchUpInside)
//
//        stackView.addArrangedSubview(button1)
//        stackView.addArrangedSubview(button2)
    }



    
    
    private func roundedCornerView(cornerRadius : CGFloat){
        
        
        roundedCornerView.layer.cornerRadius = cornerRadius
        
        roundedCornerView.layer.masksToBounds = true
        
        addSubview(roundedCornerView)
        
        
        roundedCornerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: roundedCornerView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading, multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: roundedCornerView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing, multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: roundedCornerView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top, multiplier: 1,
                           constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: roundedCornerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom, multiplier: 1,
                           constant: 0).isActive = true
    }
    
    
    private func setupSkinToneView(){

        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: 100, height: 1000)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        skinToneCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        //  let skinToneCollectionView = UICollectionView()
        skinToneCollectionView.delegate = self
        skinToneCollectionView.dataSource = self
        skinToneCollectionView.register(colorCell.self, forCellWithReuseIdentifier: cellId)
        skinToneCollectionView.isScrollEnabled = false
        skinToneCollectionView.showsVerticalScrollIndicator = false
        skinToneCollectionView.showsHorizontalScrollIndicator = false


        roundedCornerView.addSubview(skinToneCollectionView)
        
        skinToneCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        skinToneCollectionView.leadingAnchor.constraint(equalTo: roundedCornerView.leadingAnchor, constant: 0).isActive = true
        
        skinToneCollectionView.trailingAnchor.constraint(equalTo: roundedCornerView.trailingAnchor, constant: 0).isActive = true
        
        skinToneCollectionView.topAnchor.constraint(equalTo: roundedCornerView.topAnchor, constant: 0).isActive = true
        
        skinToneCollectionView.bottomAnchor.constraint(equalTo: roundedCornerView.bottomAnchor, constant: 0).isActive = true

        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(toSelectCells:)))
       // panGesture.delegate = self
        skinToneCollectionView.addGestureRecognizer(panGesture)


    }
    
    @objc
    func didPan(toSelectCells panGesture: UIPanGestureRecognizer) {

        //For getting The Y Position OF cell in CollectionView for Finding the cell in Location
        let yPosOfCell = skinToneCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))!.frame
        let yH = yPosOfCell.minX
        
            if panGesture.state == .began {
                skinToneCollectionView.isUserInteractionEnabled = false
                skinToneCollectionView.isScrollEnabled = false
            }
            else if panGesture.state == .changed {
                let location: CGPoint = panGesture.location(in: self)
                print(location)
            
                if let indexPath: IndexPath = skinToneCollectionView.indexPathForItem(at: CGPoint(x: location.x, y: yH)) {
                    if indexPath != lastSelectedCell {
                        skinToneCollectionView.delegate?.collectionView?(skinToneCollectionView, didSelectItemAt: indexPath)
                        lastSelectedCell = indexPath
                    }
                }
            } else if panGesture.state == .ended {
                skinToneCollectionView.isScrollEnabled = true
                skinToneCollectionView.isUserInteractionEnabled = true
            }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = frame.width/CGFloat(colorCodeViews.count)
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCodeViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! colorCell
        cell.backgroundColor = colorCodeViews[indexPath.item]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        let attribute = collectionView.layoutAttributesForItem(at: indexPath)
        circleView.frame = attribute?.frame ?? CGRect.zero
        print(circleView.frame)
    }
    
    
//    @objc func didTap(_ sender: Any) {
//
//        // make sure the sender is a button
//        guard let btn = sender as? UIButton else { return }
//
//        // make sure the button's superview is a stack view
//        guard let stack = btn.superview as? UIStackView else { return }
//
//        // get the array of arranged subviews
//        let theArray = stack.arrangedSubviews
//
//
//
//       // get the "index" of the tapped button
//        if let idx = theArray.firstIndex(of: btn) {
//            print(idx)
//        } else {
//            print("Should never fail...")
//        }
//
//    }
 
    fileprivate func makeCircleWith(imageSize: Int, backgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) -> UIImage? {
        
        let size = CGSize(width: imageSize, height: imageSize)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        //context?.setFillColor(backgroundColor.cgColor)
        //  context?.setStrokeColor(UIColor.blue.cgColor)
        
        //change the divider to change the border width
        let borderWidth = imageSize/10
        
        let circelWidthNHeight = (imageSize - (borderWidth * 2))
        
        let bounds = CGRect(x: borderWidth, y: borderWidth, width: circelWidthNHeight, height: circelWidthNHeight)
        
        //let bounds = CGRect(origin: .zero, size: CGSize(width: size.width - 10, height: size.height - 10))
        // context?.addEllipse(in: bounds)
        // context?.drawPath(using: .fill)
        
        
        let circularPath = UIBezierPath(ovalIn: bounds)
        #colorLiteral(red: 1, green: 0.5921568627, blue: 0.5921568627, alpha: 0).setFill()
        // #colorLiteral(red: 1, green: 0.5921568627, blue: 0.5921568627, alpha: 1).setFill()
        backgroundColor.setStroke()
        circularPath.lineWidth = CGFloat(borderWidth)
        circularPath.fill()
        
        context?.addPath(circularPath.cgPath)
        circularPath.stroke()
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}




class colorCell : UICollectionViewCell{
//    override var isSelected: Bool {
//        
//        didSet {
//            if isSelected {
//                
//            }
//
//        }
//
//    }
}


extension UIColor {
    func image(_ size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
