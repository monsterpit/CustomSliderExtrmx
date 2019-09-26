//
//  SliderView.swift
//  CustomSliderExtrmx
//
//  Created by MyGlamm on 9/25/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit



protocol SliderViewItemSelectedDelegate : class {
    
    
    func selectedRow(index : Int,color : UIColor)
    
}


class SliderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    private let roundedCornerView = UIView()
    
    private var colorCodeViews : [UIColor] = []
    
    private var cellId = "cell"
    
    private var circleView : UIImageView = UIImageView()
    
    private var lastSelectedCell : IndexPath = IndexPath(item: 0, section: 0)
    
    private var cornerRadius : CGFloat = 0
    
    var skinToneCollectionView : UICollectionView!
    
   // var selectedIndex : Int = 0
    
    private var isGradientView : Bool = false
    
    private var gradientColors : [CGColor] = []
    
    weak var sliderViewSelectedDelegate : SliderViewItemSelectedDelegate?
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    required init(colors : [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)],cornerRadius : CGFloat,isGradientView : Bool = false , gradientColors : [UIColor] = [#colorLiteral(red: 0.9891870618, green: 0.7692108154, blue: 0.7603701353, alpha: 1),#colorLiteral(red: 1, green: 0.6661287546, blue: 0.656347692, alpha: 1)] ,selectedIndex : Int = 0) {
        super.init(frame: CGRect.zero)
        
        colorCodeViews = colors
        
        self.cornerRadius = cornerRadius
        
        self.isGradientView = isGradientView
        
        self.gradientColors = gradientColors.map{$0.cgColor}
        
        self.lastSelectedCell = IndexPath(item: selectedIndex, section: 0)
        
        roundedCornerView(cornerRadius : cornerRadius)
        
        


        setupSliderColorView()
        
//        if isGradientView{
//
////            let collectionViewBackgroundView = UIView()
////            let gradientLayer = CAGradientLayer()
////            gradientLayer.frame.size = skinToneCollectionView.frame.size
////            // Start and end for left to right gradient
////            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
////            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
////            gradientLayer.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
////            skinToneCollectionView.backgroundView = collectionViewBackgroundView
////            skinToneCollectionView.backgroundView?.layer.addSublayer(gradientLayer)
//
//            print(roundedCornerView.bounds)
//        }
        
        circleView.image = makeCircleWith(imageSize: 100,backgroundColor: #colorLiteral(red: 0.7805789832, green: 0.02354164009, blue: 0.9616711612, alpha: 1))
      
        addSubview(circleView)

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
    
    
    private func setupSliderColorView(){

        
        
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
               // print(location)
            
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

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
       print(roundedCornerView.bounds)
        
                if isGradientView{
        
                    skinToneCollectionView.backgroundColor = .clear
                    
//                    let collectionViewBackgroundView = UIView()
                    let gradientLayer = CAGradientLayer()
                    gradientLayer.frame = roundedCornerView.bounds
                    // Start and end for left to right gradient
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                    gradientLayer.colors = gradientColors
                   // roundedCornerView.backgroundView = collectionViewBackgroundView
                    roundedCornerView.layer.addSublayer(gradientLayer)
        
                    
                    
                    
                    
                    //print(roundedCornerView.bounds)
                }
        
        
        //let indexPath = IndexPath(item: 0, section: 0)
        skinToneCollectionView.selectItem(at: lastSelectedCell, animated: true, scrollPosition: .left)
        skinToneCollectionView.delegate?.collectionView?(skinToneCollectionView, didSelectItemAt: lastSelectedCell)
        
        
    }
 

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = frame.width/CGFloat(colorCodeViews.count)
   
        return CGSize(width: size, height: (cornerRadius*2) )
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
        //print(indexPath.item)
        
        self.lastSelectedCell  = indexPath
        
        let attribute = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrame = attribute?.frame ?? CGRect.zero
        
        let cellHeight : CGFloat = (cornerRadius * 2)
        
        let extraSpacing : CGFloat = (cellFrame.width) / 2 > 20 ? 20 : (cellFrame.width) / 2
        
        
        UIView.animate(withDuration: 0.2) {
            [weak self] in
            guard let `self` = self else {return}
            self.circleView.frame = CGRect(x: ((cellFrame.midX - self.cornerRadius) - (extraSpacing/2) ), y: (cellFrame.minY - (extraSpacing/2)), width: (cellHeight) + extraSpacing , height: (cellHeight) + extraSpacing)
        }

     
        if colorCodeViews.count != 1 && isGradientView{

            let cellPaddingForFirstAndLast : CGFloat = 5
            
            if indexPath.item == 0 {
                circleView.frame = CGRect(x: -(cellPaddingForFirstAndLast), y: (cellFrame.minY - (extraSpacing/2)), width: (cellHeight) + extraSpacing , height: (cellHeight) + extraSpacing)
            }
            else if indexPath.item == (colorCodeViews.count - 1){
                circleView.frame = CGRect(x: ((cellFrame.maxX - (cellHeight) - extraSpacing) + (cellPaddingForFirstAndLast) ), y: (cellFrame.minY - (extraSpacing/2)), width: (cellHeight) + extraSpacing , height: (cellHeight) + extraSpacing)
            }

        }
        
        
        sliderViewSelectedDelegate?.selectedRow(index: indexPath.item, color: colorCodeViews[indexPath.item])
        
       // print(circleView.frame)
    }
    
    
 
    fileprivate func makeCircleWith(imageSize: Int, backgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) -> UIImage? {
        
        let size = CGSize(width: imageSize, height: imageSize)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        //change the divider to change the border width
        let borderWidth = imageSize/10
        
        let circelWidthNHeight = (imageSize - (borderWidth * 2))
        
        let bounds = CGRect(x: borderWidth, y: borderWidth, width: circelWidthNHeight, height: circelWidthNHeight)
        
        
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
