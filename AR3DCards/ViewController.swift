//
//  ViewController.swift
//  AR3DCards
//
//  Created by eren on 28.08.2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Enable Auto Lightning
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main){
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Added")
        }
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let nodeMain = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let nodePlane = SCNNode(geometry: plane)
            
            nodePlane.eulerAngles.x = -.pi / 2
            
            nodeMain.addChildNode(nodePlane)
            
            
            if imageAnchor.referenceImage.name == "card1"{
                
                if let sceneCoffee = SCNScene(named: "art.scnassets/Coffee.scn"){
                    
                    if let nodeCoffee = sceneCoffee.rootNode.childNodes.first{
                        
                        nodeCoffee.eulerAngles.x = .pi / 2
                        
                        nodePlane.addChildNode(nodeCoffee)
                    }
                }
            }else{
                
                if let sceneCoffee = SCNScene(named: "art.scnassets/Coffee2.scn"){
                    
                    if let nodeCoffee = sceneCoffee.rootNode.childNodes.first{
                        
                        nodeCoffee.eulerAngles.x = .pi / 2
                        
                        nodePlane.addChildNode(nodeCoffee)
                    }
                }
            }
            
        }else{
            print("Not ARImage anchor")
        }
        
        return nodeMain
    }
}
