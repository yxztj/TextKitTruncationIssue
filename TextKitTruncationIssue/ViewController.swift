//
//  ViewController.swift
//  TextKitTruncationIssue
//
//  Created by Jason Yu on 10/11/16.
//  Copyright © 2016 hang. All rights reserved.
//

import UIKit
import CoreText

class ViewController: UIViewController {
    let imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 100, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = self.getImageFromText()
        imageView.backgroundColor = UIColor.gray
        self.view.addSubview(imageView)
        
        let rangeControl = UISlider(frame: CGRect(x: 20, y: 350, width: 300, height: 20))
        rangeControl.minimumValue = 50
        rangeControl.maximumValue = 300
        rangeControl.value = 200
        rangeControl.addTarget(self, action: #selector(ViewController.didMovedSlider(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(rangeControl)
    }
    
    func didMovedSlider(sender: UISlider) {
        let height = CGFloat(sender.value)
        imageView.frame = CGRect(x: 20, y: 20, width: 100, height: height)
        imageView.image = self.getImageFromText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getImageFromText() -> UIImage? {
        let font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 100

        let attr: [String: AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        let textStorage = NSTextStorage(string: "This is a long message. This is a long message. This is a long message.", attributes: attr)
        
        let containerSize = self.imageView.bounds.size
        let textContainer = NSTextContainer(size: containerSize)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)

        layoutManager.addTextContainer(textContainer)
        layoutManager.ensureLayout(for: textContainer)

        UIGraphicsBeginImageContextWithOptions(containerSize, false, UIScreen.main.scale)
        layoutManager.drawGlyphs(forGlyphRange: NSMakeRange(0, textStorage.length), at: CGPoint.zero)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

