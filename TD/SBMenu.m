//
//  SBMenu.m
//  TD
//
//  Created by Spencer Whyte on 11-02-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SBMenu.h"


@implementation SBMenu

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
    
    constructButtonSelected = [Loader loadImageWithName:@"constructButton2.png"];
    constructButton= [Loader loadImageWithName:@"constructButton.png"];
    
    
    satelliteButton = [Loader loadImageWithName:@"Satellite.png"];
    satelliteButtonSelected= [Loader loadImageWithName:@"Satellite.png"];
    
    
    rocketButton= [Loader loadImageWithName:@"rocketLauncher.png"]; // unselected
    rocketButtonSelected= [Loader loadImageWithName:@"rocketLauncher.png"]; /// selected
    
    manualControlButton =[Loader loadImageWithName:@"manualControlButton.png"];
    manualControlButtonSelected= [Loader loadImageWithName:@"manualControlButton2.png"];
    
    electricFenceButton= [Loader loadImageWithName:@"electricFence.png"];
    electricFenceButtonSelected= [Loader loadImageWithName:@"electricFence.png"];
    
    fusionCoilButton= [Loader loadImageWithName:@"fusionCoil.png"];
    fusionCoilButtonSelected= [Loader loadImageWithName:@"fusionCoil.png"];
	
	closeButton= [Loader loadImageWithName:@"exitButton.png"];
    quitButton= [Loader loadImageWithName:@"quit.png"];
	
	clickButton= [Loader loadImageWithName:@"tapSelectButton.png"];
    placeButton= [Loader loadImageWithName:@"tapToPlace.png"];
	holdButton= [Loader loadImageWithName:@"tapHoldButton.png"];
    currentMenu = nil;
}


+(void)reset{
    currentMenu= nil;
    manualControlSelect = false;
	Tutorial1=false;
	step1=false;
}
+(void)setTutorial{
	Tutorial1=true;	
	step1=true;
}

static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};
static  const GLfloat svt1[] = {
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.0f,
    1.0f,  0.0f,
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
	const GLfloat sv4[] = {
        -width * 0.04, -height *0.04,
        width * 0.04,  -height *0.04,
        -width * 0.04, height * 0.04f,
        width * 0.04,  height * 0.04f
    };
	const GLfloat sv5[] = {
        -width * 0.1, -height *0.04,
        width * 0.1,  -height *0.04,
        -width * 0.1, height * 0.04f,
        width * 0.1,  height * 0.04f
    };
	const GLfloat sv8[] = {
        0.0f, 0.0f,
        1.0f,  0.0f,
        0.0f, 1.0f,
		1.0f,  1.0f
    };
	
	if(step1==true && Tutorial1==true){
		glBindTexture(GL_TEXTURE_2D, holdButton);
		glPushMatrix();
		//glScalef(2.0, 2.0, 0.0);
		glTranslatef(width*0.50, -height * 0.05, 0.0f);
		glVertexPointer(2, GL_FLOAT, 0,sv8);
		glTexCoordPointer(2, GL_FLOAT,0 , svt);
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		glPopMatrix();
		NSLog(@"I MADE IT TO HERE");
	}
	
	if(step3==true && Tutorial1==true){
		glBindTexture(GL_TEXTURE_2D, placeButton);
		glPushMatrix();
		glScalef(2.0, 2.0, 0.0);
		glTranslatef(width*0.30, -height * 0.15, 0.0f);
		glVertexPointer(2, GL_FLOAT, 0,sv8);
		glTexCoordPointer(2, GL_FLOAT,0 , svt);
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		glPopMatrix();
	NSLog(@"I MADE IT TO HERE3");
	}
	
	
  //  [Audio playSound:@"Ambiento"];
    if(currentMenu !=nil){ // IF there is actually a menu to be displayed
        
        glPushMatrix();
		glTranslatef(width*0.5, height*0.67, 0.0f);
        glScalef(fminf(1.0f,5*((float)CACurrentMediaTime() - currentMenu.creationTime)), fminf(1.0, 5*(1*(float)CACurrentMediaTime() - currentMenu.creationTime)), 1.0f);
		
        if(currentMenu.menuState == 0){ // If the menu to be displayed is the main menu
            glBindTexture(GL_TEXTURE_2D, menuBackground); 
            glVertexPointer(2, GL_FLOAT, 0,sv);
            glTexCoordPointer(2, GL_FLOAT,0 , svt);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            if(step1==true && Tutorial1){
				step1=false;
				step2=true;
			}
			if(step2==true && Tutorial1==true){
				glBindTexture(GL_TEXTURE_2D, clickButton);
				glPushMatrix();
				glScalef(2.0, 2.0, 0.0);
				glTranslatef(width*0.30, -height * 0.1, 0.0f);
				glVertexPointer(2, GL_FLOAT, 0,sv8);
				glTexCoordPointer(2, GL_FLOAT,0 , svt);
				glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
				glPopMatrix();
				NSLog(@"I MADE IT TO HERE2");
			}

            if([Score getCredits] >= [Satellite getPrice]){
                if(currentMenu.selected ==0 ){
                    glBindTexture(GL_TEXTURE_2D, satelliteButtonSelected);
                }else{
                    glBindTexture(GL_TEXTURE_2D, satelliteButton);
                }
				
                glPushMatrix();
                glTranslatef(0.0, -height * 0.15, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
            }
			if([Score getCredits] >= [SatelliteVariant getPrice]){
                if(currentMenu.selected ==1 ){
                    glBindTexture(GL_TEXTURE_2D, rocketButtonSelected);
                }else{
                    glBindTexture(GL_TEXTURE_2D, rocketButton);
                }
                glPushMatrix();
				glTranslatef(0.0, -height * -0.15, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv4);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
            }
			if([Score getCredits] >= [ElectricFence getPrice]){
                if(currentMenu.selected ==2 ){
                    glBindTexture(GL_TEXTURE_2D, electricFenceButtonSelected);
                }else{
                    glBindTexture(GL_TEXTURE_2D, electricFenceButton);
                }
				
                glPushMatrix();
				glTranslatef(-width * -0.22, -height * 0.01, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
            }
			if([Score getCredits] >= [FusionCoil getPrice]){
                if(currentMenu.selected ==3){
                    glBindTexture(GL_TEXTURE_2D, fusionCoilButtonSelected);
                }else{
                    glBindTexture(GL_TEXTURE_2D, fusionCoilButton);
                }
				
                glPushMatrix();
				glTranslatef(-width * 0.22, -height * 0.01, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
            }	
				glBindTexture(GL_TEXTURE_2D, closeButton);
                glPushMatrix();
                glTranslatef(0.0, -height * 0.01, 0.0f);
                glVertexPointer(2, GL_FLOAT, 0,sv2);
                glTexCoordPointer(2, GL_FLOAT,0 , svt);
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                glPopMatrix();
				glBindTexture(GL_TEXTURE_2D, quitButton);
			glPushMatrix();
			glTranslatef(0.0, -height * -0.25, 0.0f);
			glVertexPointer(2, GL_FLOAT, 0,sv5);
			glTexCoordPointer(2, GL_FLOAT,0 , svt1);
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
+(void)audio{
	[Audio stopSound:@"Ambiento"];
	[Audio cleanUpOpenAL];
}

- (void)touchesBeganX:(float)x andY:(float)y{
    if(!self.remove){// If this menu should be being displayed
		
        
        
        
        
        if(x < width *0.60 && x >  width * 0.40 && y <  height *0.55 && y > height* 0.35){ // If the user selects to add a satellite
            if([Score getCredits] >= [Satellite getPrice]){
                selected = 0;
            }
        }else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.85 && y > height*0.69){ // If the user selects the satellite variant
            if([Score getCredits] >= [SatelliteVariant getPrice]){
                selected = 1;
            }
        }else if(x < width *0.76 && x >  width * 0.53 && y <  height *0.68 && y > height*0.52){ // If the user selects the electric fence
            if([Score getCredits] >= [ElectricFence getPrice]){
                selected = 2;
            }
        }else if(x < width *0.46 && x >  width * 0.23 && y <  height *0.68 && y > height*0.52){ // If the user selects the fusion coil
           //if(fccount <1){
			if([Score getCredits] >= [FusionCoil getPrice]){
                selected = 3;
          //  }
		   }
		}else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.68 && y > height*0.52){ // If the user selects the fusion coil
			selected = 4;		
        }else{  // If the user selects something other than one of the menu's
            selected = -1; // Make sure that the menu doesnt display any of the buttons as depressed
        }
		
		
    }
}


- (void)touchesMovedX:(float)x andY:(float)y{
    if(x < width *0.60 && x >  width * 0.40 && y <  height *0.55 && y > height* 0.35){ // If the user selects to add a satellite
		if([Score getCredits] >= [Satellite getPrice]){
			selected = 0;
		}
	}else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.85 && y > height*0.69){ // If the user selects the satellite variant
		if([Score getCredits] >= [SatelliteVariant getPrice]){
			selected = 1;
		}
	}else if(x < width *0.76 && x >  width * 0.53 && y <  height *0.68 && y > height*0.52){ // If the user selects the electric fence
		if([Score getCredits] >= [ElectricFence getPrice]){
			selected = 2;
		}
	}else if(x < width *0.46 && x >  width * 0.23 && y <  height *0.68 && y > height*0.52){ // If the user selects the fusion coil
		//if(fccount <1){
		if([Score getCredits] >= [FusionCoil getPrice]){
			selected = 3;
			//  }
		}
	}else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.68 && y > height*0.52){ // If the user selects the fusion coil
		selected = 4;		
	}else{  // If the user selects something other than one of the menu's
		selected = -1; // Make sure that the menu doesnt display any of the buttons as depressed
	}
	
}

+(bool)manualControlSelect{
    return manualControlSelect;
	
}

+(void)setManualControlSelect:(bool)selected{
    manualControlSelect = selected;
}

+(void)setMenuTrue{
	men1=true;	
}
+(void)setMenuFalse{
	men1=false;	
}
+(void)hidemenu{
	hidemenu1=true;
}
+(void)resetmenu{
	[SpaceBase setmen3False];
	[SpaceBase setmen5False]; 
}
- (void)touchesEndedX:(float)x andY:(float)y{
    if(!self.remove){ // If this menu should be being displayed
		if(men1==true){
			NSLog(@"msden3=true");
		if(x <      width *0.60 && x >  width * 0.40 && y <  height *0.53 && y > height*0.35){ // If the user selects to add a satellite
			if([Score getCredits] >= [Satellite getPrice]){
				if(step2==true && Tutorial1){
					step2=false;
					step3=true;
				}
				self.remove = true; // Stop displaying this menu
				subMenuMode = false;
				firstUpdate2 = true;
				Satellite * s = [[Satellite alloc] init]; // Create a new sattelite to be added
				[objects addObject:s]; // Add the satellite to the game
				s.beingPlaced = true; // Tell the satellite that it is being placed
				[s release]; // Mem mgmnt
				[SBMenu resetmenu];
			}
		}
		
        
        
		else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.83 && y > height*0.75){ // if the user selects to add a satellite variant
			if([Score getCredits] >= [SatelliteVariant getPrice]){
				subMenuMode = false;
				self.remove = true; // Stop displaying this menu
				firstUpdate2 = true;
				SatelliteVariant * s = [[SatelliteVariant alloc] init]; // Create a new sattelite variant to be added
				[objects addObject:s]; // Add the satellite to the game
				s.beingPlaced = true; // Tell the satellite that it is being placed
				[s release]; // Mem mgmnt
				[SBMenu resetmenu];
			}
			
			
		}else if(x < width *0.76 && x >  width * 0.53 && y <  height *0.66 && y > height*0.52){ // If the user selects the satellite variant
			if([Score getCredits] >= [ElectricFence getPrice]){
				self.remove = true; // Stop displaying this menu
				subMenuMode = false;
				firstUpdate2 = true;
				ElectricFence * e = [[ElectricFence alloc] init]; // Create a new sattelite variant to be added
				[objects addObject:e]; // Add the satellite to the game
				e.beingPlaced = true; // Tell the satellite that it is being placed
				[e release]; // Mem mgmnt
				[SBMenu resetmenu];
			}
		}else if(x < width *0.46 && x >  width * 0.23 && y <  height *0.66 && y > height*0.52){ // If the user selects the satellite variant
			//if(fccount < 1){
				if([Score getCredits] >= [FusionCoil getPrice]){
				self.remove = true; // Stop displaying this menu
				subMenuMode = false;
				firstUpdate2 = true;
				FusionCoil  * f = [[FusionCoil alloc] init]; // Create a new sattelite variant to be added
				[objects addObject:f]; // Add the satellite to the game
				f.beingPlaced = true; // Tell the satellite that it is being placed
				//fccount++;
				[f release]; // Mem mgmnt
					[SBMenu resetmenu];
			//	}
			}
		}else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.71 && y > height*0.57){ // If the user selects the satellite variant
			NSLog(@"test2");
			self.remove = true;// Stop displaying this menu
			subMenuMode = false;
			firstUpdate2 = true;
			[SBMenu resetmenu];
		}else if(x < width *0.60 && x >  width * 0.40 && y <  height *0.96 && y > height*0.85){ // If the user selects the satellite variant
			//	self.remove=true;
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:   [  [ NSString alloc] initWithFormat:@"Menu \n Score: %d\n Credits: %d\n", [Score getScore],[Score getCredits]] message:nil delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Main menu", nil];
			
			//	UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle: @"Menu\n" message:@"Score: %d\n", [Score getScore], @"Credits: %d\n", [Score getCredits] delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Manual",@"Quit" nil];
			[myAlertView show];
			[myAlertView release];
			[SBMenu resetmenu];
		}else{  // If the user selects something other than one of the menu's
			selected = -1; // Make sure tht the menu doesnt display any of the buttons as depressed
		}
		}
        
	}

    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
		alertView.hidden =true;
		subMenuMode = false;
		firstUpdate2 = true;
		self.remove=true;
    }
    if(buttonIndex == 1){
		int hp;
		hp=[Score getEarthHealth];
		[Score changeEarthHealth:-hp];
		subMenuMode = false;
		firstUpdate2 = true;
		self.remove=true;
		
    }
	/*if(buttonIndex == 2){
		if(!manualControlSelect){
		manualControlSelect=true;
		}
		if(manualControlSelect){
			manualControlSelect=false;
		}
    }*/
    
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
