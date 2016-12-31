//
//  MainMenuScene.swift
//  Animal Tap
//
//  Created by Trung Nguyễn on 12/16/16.
//  Copyright © 2016 group4ios. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene
{
    let clickSoundEffect = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let gameTitleLabel1 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel1.text = "Animal"
        gameTitleLabel1.fontSize = 90
        gameTitleLabel1.fontColor = SKColor.whiteColor()
        gameTitleLabel1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        gameTitleLabel1.zPosition = 1
        self.addChild(gameTitleLabel1)
        
        let gameTitleLabel2 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel2.text = "Tap"
        gameTitleLabel2.fontSize = 250
        gameTitleLabel2.fontColor = SKColor.whiteColor()
        gameTitleLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        gameTitleLabel2.zPosition = 1
        self.addChild(gameTitleLabel2)
        
        let gameByLabel = SKLabelNode(fontNamed: "Pusab")
        gameByLabel.text = "Group 4"
        gameByLabel.fontSize = 50
        gameByLabel.fontColor = SKColor.whiteColor()
        gameByLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.95)
        gameByLabel.zPosition = 1
        self.addChild(gameByLabel)
        
        
        let startLabel = SKLabelNode(fontNamed: "Pusab")
        startLabel.text = "Play"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.whiteColor()
        startLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.35)
        startLabel.zPosition = 1
        startLabel.name = "startButton"
        self.addChild(startLabel)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOnTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(pointOnTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "startButton"
            {
                self.runAction(clickSoundEffect)
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransation = SKTransition.fadeWithDuration(0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransation)
                
            }
            
        }
    }
    
}

