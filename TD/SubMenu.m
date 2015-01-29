//
//  SBMenu.m
//  TD
//
//  Created by Spencer Whyte on 11-02-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubMenu.h"


@implementation SubMenu

- (id)init {
    if ((self = [super init])) {
        currentMenu = self;
        selected = -1; // Dont display any of the buttons as depresed
        menuState = 0; // Display the main menu
        creationTime = CACurrentMediaTime();
        subMenuMode = true;
    }
    return self;
}

-(void)removeNotification{
    subMenuMode = false;
    currentMenu = nil;   
}

+(void)load{
    menuBackground = [Loader loadImageWithName:@"baseMenu.png"];
    
    
    upgradeButton = [Loader loadImageWithName:@"Satellite.png"];
    recycleButton = [Loader loadImageWithName:@"Satellite.png"];
    
    
    closeButton= [Loader loadImageWithName:@"rocketLauncher.png"]; // unselected
    
    
    currentMenu = nil;
}


+(void)reset{
    currentMenu= nil;
    manualControlSelect = false;
}


static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};


+(SBMenu*)currentMenu{
    
    return currentMenu;
}
+(void)draw{
    
    
    const GLfloat sv[] = {
		- width * 0.3,  - height * 0.20,
		width * 0.3,  - height * 0.20,
		- width * 0.3,  height * 0.20f,
		width * 0.3,  height * 0.20f
    };
    
    const GLfloat sv2[] = {
        -width * 0.06, -height *0.04,
        width * 0.06,  -height *0.04,
        -width * 0.06, height * 0.04f,
        width * 0.06,  height * 0.04f
    };
    
	
	
    
    if(currentMenu !=nil){ // IF there is actually a menu to be displayed
		
        glPushMatrix();
		glTranslatef(tempx, tempy, 0.0f);
        glScalef(fminf(2.0f,5*((float)CACurrentMediaTime() - currentMenu.creationTime)), fminf(2.0, 5*(1*(float)CACurrentMediaTime() - currentMenu.creationTime)), 2.0f);
		
        if(currentMenu.menuState == 0){ // If the menu to be displayed is the main menu
            glBindTexture(GL_TEXTURE_2D, menuBackground); 
            glVertexPointer(2, GL_FLOAT, 0,sv);
            glTexCoordPointer(2, GL_FLOAT,0 , svt);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            
            
            
                if(currentMenu.selected ==0 ){
                    glBindTexture(GL_TEXTURE_2D, recycleButton);
                }else{
                    glBindTexture(GL_TEXTURE_2D, recycleButton);
                }
				
                glPushMatrix();
                glTranslatef(tempx, tempy * 0.15, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
			
                if(currentMenu.selected ==1 ){
                    glBindTexture(GL_TEXTURE_2D, closeButton);
                }else{
                    glBindTexture(GL_TEXTURE_2D, closeButton);
                }
                glPushMatrix();
				glTranslatef(tempx * -0.22, -tempy * 0.01, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
			            /*
			 glPushMatrix();
			 glTranslatef(currentMenu.x, currentMenu.y,0);
			 glRotatef(currentMenu.rotation, 0.0f, 0.0f, 1.0);
			 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			 
			 
			 if(currentMenu.selected == 0){
			 glBindTexture(GL_TEXTURE_2D, constructButtonSelected);
			 }else{
			 glBindTexture(GL_TEXTURE_2D, constructButton);     
			 }  
			 
			 glVertexPointer(2, GL_FLOAT, 0,sv2);
			 glTexCoordPointer(2, GL_FLOAT,0 , svt);
			 
			 
			 
			 
			 
			 glPopMatrix();   
			 
			 */
        }else if(currentMenu.menuState == 1){
            /*
			 glBindTexture(GL_TEXTURE_2D, menuBackground);
			 glVertexPointer(2, GL_FLOAT, 0,sv);
			 glTexCoordPointer(2, GL_FLOAT,0 , svt);
			 glPushMatrix();
			 glTranslatef(currentMenu.x, currentMenu.y,0);
			 glRotatef(currentMenu.rotation, 0.0f, 0.0f, 1.0);
			 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			 
			 
			 if([Score getCredits] >= [SatelliteVariant getPrice]){
			 if(currentMenu.selected ==1 ){
			 glBindTexture(GL_TEXTURE_2D, texture7);
			 }else{
			 glBindTexture(GL_TEXTURE_2D, texture6);
			 }
			 glVertexPointer(2, GL_FLOAT, 0,sv3);
			 glTexCoordPointer(2, GL_FLOAT,0 , svt);
			 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			 }
			 if([Score getCredits] >= [ElectricFence getPrice]){
			 if(currentMenu.selected ==2 ){
			 glBindTexture(GL_TEXTURE_2D, texture9);
			 }else{
			 glBindTexture(GL_TEXTURE_2D, texture8);
			 }
			 glVertexPointer(2, GL_FLOAT, 0,sv3);
			 glTexCoordPointer(2, GL_FLOAT,0 , svt);
			 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			 }
			 
			 if([Score getCredits] >= [FusionCoil getPrice]){
			 if(currentMenu.selected ==3 ){
			 glBindTexture(GL_TEXTURE_2D, texture11);
			 }else{
			 glBindTexture(GL_TEXTURE_2D, texture10);
			 }
			 glVertexPointer(2, GL_FLOAT, 0,sv3);
			 glTexCoordPointer(2, GL_FLOAT,0 , svt);
			 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			 }
			 
			 
			 glPopMatrix();  
             */
        }
        
        glPopMatrix();
    }
}



-(int)checkX:(float)x1 checkY:(float)y1{
    return 9;
}


- (void)touchesBeganX:(float)x andY:(float)y{
    if(!self.remove){// If this menu should be being displayed
		
        
        
        
        
        if(x < width *0.60 && x >  width * 0.40 && y <  height *0.50 && y > height* 0.30){ // If the user selects to add a satellite
            if([Score getCredits] >= [Satellite getPrice]){
                selected = 0;
            }
        }else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.43 && y > height*0.27){ // If the user selects the satellite variant
            if([Score getCredits] >= [SatelliteVariant getPrice]){
                selected = 1;
            }
        }else if(x < width *0.76 && x >  width * 0.53 && y <  height *0.63 && y > height*0.47){ // If the user selects the electric fence
            if([Score getCredits] >= [ElectricFence getPrice]){
                selected = 2;
            }
		}	
        }else{  // If the user selects something other than one of the menu's
            selected = -1; // Make sure that the menu doesnt display any of the buttons as depressed
        }
}


- (void)touchesMovedX:(float)x andY:(float)y{
    
}

+(bool)manualControlSelect{
    return manualControlSelect;
	
}

+(void)setManualControlSelect:(bool)selected{
    manualControlSelect = selected;
}

- (void)touchesEndedX:(float)x andY:(float)y{
    for(Satellite * s1 in satellites){
		for(SatelliteVariant * s2 in satelliteVariants){
			if((x=s1.x)&& (y=s1.y)){
				menuState=0;
				SBsubMenuMode=true;
				tempx=s1.x;
				tempy=s1.y;
				if(!self.remove){
					if(x < tempx *0.60 && x >  tempx * 0.40 && y <  tempy *0.63 && y > tempy*0.47){
							self.remove = true; // Stop displaying this menu
							SBsubMenuMode = false;
							//firstUpdate2 = true;
					}
					else if(x <      tempx *0.60 && x >  tempx * 0.40 && y <  tempy *0.50 && y > tempy*0.30){
						self.remove = true; // Stop displaying this menu
						SBsubMenuMode = false;
						firstUpdate2 = true;
						//Satellite * s = [[Satellite alloc] init]; // Create a new sattelite to be added
						//[objects addObject:s]; // Add the satellite to the game
						s1.beingPlaced = true; // Tell the satellite that it is being placed
						[s1 release]; // Mem mgmnt
					}
				}
			}
			if((x=s2.x)&& (y=s2.y)){
				menuState=0;
				SBsubMenuMode=true;
				tempx=s2.x;
				tempy=s2.y;
				if(!self.remove){
					if(x < tempx *0.60 && x >  tempx * 0.40 && y <  tempy *0.63 && y > tempy*0.47){
						self.remove = true; // Stop displaying this menu
						SBsubMenuMode = false;
						//firstUpdate2 = true;
					}
					else if(x <      tempx *0.60 && x >  tempx * 0.40 && y <  tempy *0.50 && y > tempy*0.30){
						self.remove = true; // Stop displaying this menu
						SBsubMenuMode = false;
						firstUpdate2 = true;
						//Satellite * s = [[Satellite alloc] init]; // Create a new sattelite to be added
						//[objects addObject:s]; // Add the satellite to the game
						s2.beingPlaced = true; // Tell the satellite that it is being placed
						[s2 release]; // Mem mgmnt
					}
				}
			}
		}
	}
        
        
    
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize  selected;
@synthesize  menuState;
@synthesize creationTime;
@end
