//
//  ViewController.swift
//  Animations
//
//  Created by Dhruv Upadhyay on 3/3/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayPositionOpen = CGPointMake(160, 469);
    var trayPositionClosed = CGPointMake(160, 634);
    var smileyOriginalCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!

    @IBOutlet weak var canvasView: UIView!
    
    
    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        

        
        let point = panGestureRecognizer.locationInView(view)
        
        // Total translation (x,y) over time in parent view's coordinate system
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            
           trayOriginalCenter = trayView.center
            
                        print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            
             trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
            if(trayOriginalCenter.y > self.trayView.center.y) {
                
                UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 12, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.trayView.center = self.trayPositionOpen
                    }, completion: nil)
                
                
                
            } else {
                
                UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 12, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.trayView.center = self.trayPositionClosed
                    }, completion: nil)
                
            }
            
            
            print("Gesture ended at: \(point)")
        }
        
        
    }
    
    
    @IBAction func onImagePanned(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let point = panGestureRecognizer.locationInView(view)
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            print("dfsdf")
            let imageView = panGestureRecognizer.view as! UIImageView
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            
            newlyCreatedFace.center.y += trayView.frame.origin.y
            smileyOriginalCenter = newlyCreatedFace.center
            
            var newPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            
            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            imageView.addGestureRecognizer(newPanGestureRecognizer)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            newlyCreatedFace.center = CGPoint(x: smileyOriginalCenter.x + translation.x, y: smileyOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}

