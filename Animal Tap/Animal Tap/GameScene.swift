//
//  GameScene.swift
//  Animal Tap
//
//  Created by Trung Nguyễn on 12/16/16.
//  Copyright (c) 2016 group4ios. All rights reserved.
//

import SpriteKit

var scoreNumber = 0
var nameOfPic = ""
var keyWordIndex = 0
var randomIndex = 0
var randomIndexWrong = 0
var keyWord = ""

class GameScene: SKScene {
    
    let scoreLabel = SKLabelNode(fontNamed: "Pusab")
    
    let wordLabel = SKLabelNode(fontNamed: "Pusab")
    
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)
    
    let playGameOverSoundEffect = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    
    let arrayOfWord=["Dog","Owl","Snake","Rabbit","Monkey","Parrot","Penguins","Dolphin","Shark","Bear","Camel","Dairy Cows","Cat","Dinosaur","Wolf","Fish","Giraffe","Panther","Pig","Eel","Frog","Gaur","Gorillas","Hippo","Jellyfish","Koala","Kangaroo","Cheetah","Lion","Mouse","Panda"]
    
    let gameArea: CGRect
    
    override init(size: CGSize){
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: size.height*0.75)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    
    
    override func didMoveToView(view: SKView) {
        
        scoreNumber = 0
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "H1")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
        
        let disc1 = SKSpriteNode()
        disc1.zPosition = 2
        disc1.name = "discObject1"
        self.addChild(disc1)
        
        scoreLabel.fontSize = 250
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        self.addChild(scoreLabel)
        //
        wordLabel.fontSize = 70
        wordLabel.text = arrayOfWord[1]
        wordLabel.fontColor = SKColor.whiteColor()
        wordLabel.zPosition = 1
        wordLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        self.addChild(wordLabel)
        //
        
    }
    
    func spawNewDisc(){
        
        let ramdomImageNumber = arc4random_uniform(30)

        randomIndex = Int(ramdomImageNumber)
        
        let disc = SKSpriteNode(imageNamed: "H\(ramdomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        //
        keyWord = arrayOfWord[randomIndex]
        wordLabel.text = keyWord
        //
        let randomX = random(min: CGRectGetMinX(gameArea) + disc.size.width/2,
                             max: CGRectGetMaxX(gameArea) - disc.size.width/2)
        
        let randomY = random(min: CGRectGetMinY(gameArea) + disc.size.height/2,
                             max: CGRectGetMaxY(gameArea) - disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY)
        self.addChild(disc)
        
        disc.runAction(SKAction.sequence([
                SKAction.scaleTo(0, duration: 5),
                playGameOverSoundEffect,
                SKAction.runBlock(runGameOver)
            ]))
        
    }
    
    func spawDiscWrong() {
        if randomIndex > 0
        {
            let randomImageNumber1 = Int(arc4random_uniform(UInt32(randomIndex-1)))
            let disc1 = SKSpriteNode(imageNamed: "H\(randomImageNumber1)")
            disc1.zPosition = 2
            disc1.name = "discObject1"
            
            let randomX1 = random(min: CGRectGetMinX(gameArea) + disc1.size.width/2,
                                  max: CGRectGetMaxX(gameArea) - disc1.size.width/2)
            
            let randomY1 = random(min: CGRectGetMinY(gameArea) + disc1.size.height/2,
                                  max: CGRectGetMaxY(gameArea) - disc1.size.height/2)

                disc1.position=CGPoint(x: randomX1, y: randomY1)
                self.addChild(disc1)
            
            disc1.runAction(SKAction.sequence([
                SKAction.scaleTo(0, duration: 5),
                ]))

        }
        else
        {
            let randomImageNumber1 = Int(arc4random_uniform(3) + 1)
            let disc1 = SKSpriteNode(imageNamed: "H\(randomImageNumber1)")
            disc1.zPosition = 2
            disc1.name = "discObject1"
            
            let randomX1 = random(min: CGRectGetMinX(gameArea) + disc1.size.width/2,
                                  max: CGRectGetMaxX(gameArea) - disc1.size.width/2)
            
            let randomY1 = random(min: CGRectGetMinY(gameArea) + disc1.size.height/2,
                                  max: CGRectGetMaxY(gameArea) - disc1.size.height/2)
            
            disc1.position=CGPoint(x: randomX1, y: randomY1)
            self.addChild(disc1)
            
            disc1.runAction(SKAction.sequence([
                SKAction.scaleTo(0, duration: 5),
                ]))

        }
    }
    
    func runGameOver(){
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fadeWithDuration(0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let positionOfTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            //
            if nameOfTappedNode == "discObject"{
                
                tappedNode.name = ""
                
                tappedNode.removeAllActions()
                
                tappedNode.runAction(SKAction.sequence([
                    SKAction.fadeOutWithDuration(0.1),
                    SKAction.removeFromParent()
                    ]))
                
                self.runAction(playCorrectSoundEffect)
                
                spawNewDisc()
                spawDiscWrong()
                
                scoreNumber += 1
                scoreLabel.text = "\(scoreNumber)"
                
                if scoreNumber == 30 || scoreNumber == 70 || scoreNumber == 140 || scoreNumber == 240 ||
                    scoreNumber == 340 || scoreNumber == 440 {
                    spawDiscWrong()
                }
                
            }
            else if nameOfTappedNode == "discObject1"
            {
                self.runAction(playGameOverSoundEffect)
                runGameOver()
            }
           
        }
    }
    
}
