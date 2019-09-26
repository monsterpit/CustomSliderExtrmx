//
//  ViewController.swift
//  CustomSliderExtrmx
//
//  Created by MyGlamm on 9/25/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sliderView  : SliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let sliderViewHeight : CGFloat = 40
        
        sliderView = SliderView(colors: [#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.6661287546, blue: 0.656347692, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.6661287546, blue: 0.656347692, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)] , cornerRadius : sliderViewHeight/2,selectedIndex : 2)
        
      // sliderView = SliderView(cornerRadius: sliderViewHeight/2, isGradientView: true, gradientColors: [#colorLiteral(red: 1, green: 0.9764705882, blue: 0.9764705882, alpha: 1),#colorLiteral(red: 1, green: 0.8549019608, blue: 0.8549019608, alpha: 1)],selectedIndex: 2)
        
        

        
        //#fff9f9,#ffdada
        view.addSubview(sliderView)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false

        
        sliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        sliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        sliderView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        sliderView.heightAnchor.constraint(equalToConstant: sliderViewHeight).isActive = true
        
        
        sliderView.sliderViewSelectedDelegate = self
        
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        
//        let indexPath = IndexPath(item: 0, section: 0)
//        sliderView.skinToneCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
//        sliderView.skinToneCollectionView.delegate?.collectionView?(sliderView.skinToneCollectionView, didSelectItemAt: indexPath)
//        
//    }
    
    
//    override func viewDidLayoutSubviews() {
//        let index = IndexPath(item: 0, section: 0)
//    
//        
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.sliderView.skinToneCollectionView.delegate?.collectionView?(self.skinToneCollectionView, didSelectItemAt: index)
//        }
//       
//    }

    
    
    
}




extension ViewController : SliderViewItemSelectedDelegate{
    func selectedRow(index: Int, color: UIColor) {
        print("My index is \(index)")
    }
    
    
}
