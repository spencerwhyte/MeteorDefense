//
//  Menu.m
//  TD
//
//  Created by Spencer Whyte on 11-03-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"


@implementation Menu

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
		normal3=false;
		tutorial3=false;
    }
    
    return self;
}



+ (void)touchesBeganX:(float)x andY:(float)y{
    if( y > height * 0.14 && y < height * 0.26){
        selectedMenuItem = 2;
      
    }else if( y > height * 0.26 && y < height * 0.38){
        selectedMenuItem = 1;
       
    }else if( y > height * 0.38 && y < height * 0.50){
        selectedMenuItem = 4;
		
    }/*else if(y > height * 0.50 && y < height * 0.62){
        selectedMenuItem = 4;
		
    }*/else{
        selectedMenuItem = -1;
    }
}

+ (void)touchesMovedX:(float)x andY:(float)y{
 
}

+ (int)touchesEndedX:(float)x andY:(float)y{
    selectedMenuItem = -1;
    if(y > height * 0.14 && y < height * 0.26){
		//[Audio playSound:@"Ambiento"];
		return 1;
    }else if(y > height * 0.26 && y < height * 0.38){
        return 2;
    }else if(y > height * 0.38 && y < height * 0.50){
        return 4;
    }else if(y > height * 0.50 && y < height * 0.62){
        return 3;
    }
    return 0;
    
}

+ (void)touchesCancelledX:(float)x andY:(float)y{

}



static  const GLfloat svt2[] = {

    
    0.0f, 0.35f,
    1.0f, 0.35f,
    0.0f,  0.0f,
    1.0f,  0.0f,

};


static  const GLfloat svt[] = {
    
    
    
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.35f,
    1.0f,  0.35f,
};



static  const GLfloat standard[] = {
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.0f,
    1.0f,  0.0f,
};




static float menuY;

+(void)draw{
	//NSURL * someURL =[[NSBundle mainBundle] URLForResource:@"menuMusic" withExtension:@"mp3"];
	//[PlaySoundController playSoundAtURL:someURL];
    //PlayVideoViewController 
    const GLfloat sv[] = {
       0.0, 0.0,
       width, 0.0,
       0.0, height*0.65,
       width, height*0.65
    };
    const GLfloat sv2[] = {
        0.0,  height*0.65,
        width,  height*0.65,
        0.0, height,
        width, height
    };
    
    
    const GLfloat sv4[] = {
        width*0.3, height * -0.1,
        width* 0.7, height * -0.1,
        width*0.3, height*0.02,
        width*0.7, height*0.02
    };
    const GLfloat sv3[] = {
        width*0.3,  height * 0.02,
        width* 0.7, height * 0.02,
        width*0.3, height*0.14,
        width*0.7, height*0.14
    };
	const GLfloat sv5[] = {
        width*0.3,  height * 0.14,
        width* 0.7, height * 0.14,
        width*0.3, height*0.26,
        width*0.7, height*0.26
    };
	const GLfloat sv6[] = {
        width*0.3,  height * 0.26,
        width* 0.7, height * 0.26,
        width*0.3, height*0.38,
        width*0.7, height*0.38
    };
    
    
    
    glPushMatrix();
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glBindTexture(GL_TEXTURE_2D,menuBackground);
    
    
//if(menuY < 190){
        //playvideo here?
       // menuY +=fabs(menuY)*0.1;

  //  }else{

  //  }
	menuY=80;
    glTranslatef(0.0f, -menuY, 0.0f);
    glVertexPointer(2, GL_FLOAT, 0,sv);
    glTexCoordPointer(2, GL_FLOAT,0 , svt);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    glTranslatef(0.0f, 190.0f, 0.0f);
    
    if(selectedMenuItem == 1){
        glBindTexture(GL_TEXTURE_2D, scoreButton2);
    }else{
        glBindTexture(GL_TEXTURE_2D, scoreButton);
    }
    
    glVertexPointer(2, GL_FLOAT, 0,sv3);
    glTexCoordPointer(2, GL_FLOAT,0 , standard);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    if(selectedMenuItem == 2){
        glBindTexture(GL_TEXTURE_2D, startButton2);
    }else{
        glBindTexture(GL_TEXTURE_2D, startButton);
    }
	
    glVertexPointer(2, GL_FLOAT, 0,sv4);
    glTexCoordPointer(2, GL_FLOAT,0 , standard);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	if(selectedMenuItem == 3){
        glBindTexture(GL_TEXTURE_2D, creditsButton);
    }else{
        glBindTexture(GL_TEXTURE_2D, creditsButton);
    }
	glVertexPointer(2, GL_FLOAT, 0,sv6);
    glTexCoordPointer(2, GL_FLOAT,0 , standard);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	if(selectedMenuItem == 4){
        glBindTexture(GL_TEXTURE_2D, tutorialButton);
    }else{
        glBindTexture(GL_TEXTURE_2D, tutorialButton);
    }
    
	glVertexPointer(2, GL_FLOAT, 0,sv5);
   glTexCoordPointer(2, GL_FLOAT,0 , standard);
   glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
    glPopMatrix();
    
    glPushMatrix();
    
    glBindTexture(GL_TEXTURE_2D,menuBackground);
    glVertexPointer(2, GL_FLOAT, 0,sv2);
	glTexCoordPointer(2, GL_FLOAT,0 , svt2);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();
    
    
}


+(void)load{
    
    menuBackground  = [Loader loadImageWithName:@"menuBackground.png"];
    
    scoreButton = [Loader loadImageWithName:@"scoreButton.png"];
    startButton = [Loader loadImageWithName:@"startButton.png"];
    
    scoreButton2 = [Loader loadImageWithName:@"scoreButton2.png"];
    startButton2 = [Loader loadImageWithName:@"startButton2.png"];
	
	tutorialButton = [Loader loadImageWithName:@"tutorialButton.png"];
    creditsButton = [Loader loadImageWithName:@"creditButton.png"];
    
    menuY= 0.04;
    selectedMenuItem = -1;
}
- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
