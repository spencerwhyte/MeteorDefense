
//
//  TDViewController.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "TDViewController.h"
#import "EAGLView.h"

// Uniform index.
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};


#define USE_DEPTH_BUFFER 1
#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)

@interface TDViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation TDViewController

@synthesize animating, context, displayLink;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(gameState ==1){
        UITouch * t  =[touches anyObject];
        CGPoint p =  [t locationInView: self.view];
        float x = p.x ;
        float y = p.y;
        [currentGameWorld touchesBeganX:x andY:y];
    }else if(gameState == 0){
        for(UITouch * t in touches){
            CGPoint p =  [t locationInView: self.view];
            float x = p.x ;
            float y = p.y;
            [Menu touchesBeganX:x andY:y];
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(gameState ==1){
        UITouch * t  =[touches anyObject];
        CGPoint p =  [t locationInView: self.view];
        float x = p.x ;
        float y = p.y;
        [currentGameWorld touchesMovedX:x andY:y];
    }else if(gameState == 0){
        for(UITouch * t in touches){
            CGPoint p =  [t locationInView: self.view];
            float x = p.x ;
            float y = p.y;
            [Menu touchesMovedX:x andY:y];
        }
    }
}
- (void)movieDidFinish:(NSNotification*)aNotification{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    gameState  = 0;
	[Audio playSound:@"Ambiento"];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	int previousGameState = gameState;
    if(gameState ==1){
        UITouch * t  =[touches anyObject];
        CGPoint p =  [t locationInView: self.view];
        float x = p.x ;
        float y = p.y;
        [currentGameWorld touchesEndedX:x andY:y];
	}else if(gameState == 0){
        for(UITouch * t in touches){
            CGPoint p =  [t locationInView: self.view];
            float x = p.x ;
            float y = p.y;
            
            
            
            gameState = [Menu touchesEndedX:x andY:y];
            if(previousGameState !=gameState && gameState == 4){
				[Audio stopSound:@"Ambiento"];
					NSURL * someURL =[[NSBundle mainBundle] URLForResource:@"tutorial" withExtension:@"m4v"];
					[PlayVideoViewController playMovieAtURL:someURL inView:self.view withDelegate:self];
					
            }
            
            if(gameState == 2){
                [ScoreBoard showScoreBoard:self.view];
            }
        }
  
    }else if(gameState == 3){
        gameState = 0;
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(gameState ==1){
        UITouch * t  =[touches anyObject];
        CGPoint p =  [t locationInView: self.view];
        float x = p.x ;
        float y = p.y;
        [currentGameWorld touchesCancelledX:x andY:y];
    }else if(gameState == 0){
        for(UITouch * t in touches){
            CGPoint p =  [t locationInView: self.view];
            float x = p.x ;
            float y = p.y;
            [Menu touchesCancelledX:x andY:y];
        }
    }
}

- (void)dealloc
{
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
    [ScoreBoard setInstance:sb];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1) {
        animationFrameInterval = frameInterval;
        
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    
    if (!animating) {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
    
}

- (void)stopAnimation
{
    if (animating) {
        [currentGameWorld pause];
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}

int gotName;




- (void)drawFrame
{
   
    [(EAGLView *)self.view setFramebuffer];
 
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

    glClear(GL_COLOR_BUFFER_BIT);
        if(gameState ==1){ // Game
            glMatrixMode(GL_MODELVIEW);
            glLoadIdentity(); 
      
            if([Score hasLost]){
                if(gotName == 0){
				//	NSURL * someURL =[[NSBundle mainBundle] URLForResource:@"MDdone" withExtension:@"m4v"];
				//	[PlayVideoViewController playMovieAtURL:someURL inView:self.view withDelegate:self];
                    gotName = 2;
					if(gotName ==2){
					//	[Audio stopSound:@"Ambiento"];	
					//	[Audio cleanUpOpenAL];
					}
                    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:   [  [ NSString alloc] initWithFormat:@"Score: %d\n Please enter your name:", [Score getScore]]  message:@"This gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 62.0, 260.0, 25.0)];
					myTextField.text = [NSString stringWithFormat:@"Apollo"];
                    nameTextField = myTextField;
                    [myTextField setBackgroundColor:[UIColor whiteColor]];
                    [myAlertView addSubview:myTextField];
                    // myTransform = CGAffineTransformMakeTranslation(0.0, 130.0);
                    ///[myAlertView setTransform:myTransform];
                    [myAlertView show];
                    [myAlertView release];
                    
                }
                if(gotName == 3){
                    gotName = 0;
                    
                    gameState = 2; // Go to score screen
                    [currentGameWorld reset];
                    [ScoreBoard showScoreBoard:self.view];
                    
                    
                }
				if(gotName == 4){
                    gotName = 0;
                    
                    gameState = 3; // Go to score screen
                    [currentGameWorld reset];
                   // [ScoreBoard showScoreBoard:self.view];
                    
                    
                }
				if(gotName == 5){
                    gotName = 0;
                    
                    gameState = 4; // Go to score screen
                    [currentGameWorld reset];
					// [ScoreBoard showScoreBoard:self.view];
                    
                    
                }
                if(gotName == 1){
					
                    gameState = 2; // Go to score screen
                    gotName =0;
                    [ScoreBoard registerScore:[Score getScore] forName:[nameTextField text]];
                    [currentGameWorld reset];
                    [ScoreBoard showScoreBoard:self.view];
					//}
                }
                
                
            }else{
                if(!subMenuMode){
                    [currentGameWorld update]; // Update the game world
                    [currentGameWorld draw]; // Draw the game world
                    [ParticleSystem draw]; // Draw the particle system

				}else{
                    [currentGameWorld draw]; // Draw the game world
                    [SBMenu draw];
				}
			/*	if(!SBsubMenuMode){
					[currentGameWorld update]; // Update the game world
					[currentGameWorld draw]; // Draw the game world
					[ParticleSystem draw]; // Draw the particle system
					} else if (SBsubMenuMode){
						[currentGameWorld draw];
						[SubMenu draw];
			
					}*/
			}
        }else if(gameState ==0){ // Menu
           [Menu draw];
		}else if(gameState ==3){ // credits
				[Credit draw];
		}else if(gameState ==4){ // credits

        }else if(gameState == 2){ // Score board
            if([ScoreBoard doneScoreBoard]){
                [ScoreBoard hideScoreBoard:self.view];
                gameState = 0;
            }
        }
    [(EAGLView *)self.view presentFramebuffer];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        gotName =3;
    }
    if(buttonIndex == 1){
        gotName = 1;
    }
    
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (void)awakeFromNib
{
    EAGLContext *aContext;
    
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (!aContext) {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
    
    currentGameWorld = [[GameWorld alloc] initWithWidth:self.view.bounds.size.width andHeight:self.view.bounds.size.height];
    [ParticleSystem load];
    [Menu load];
    [Credit load];
	[Sounds loadsounds];
    gameState = 0;
    
    /*
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     //glRotatef(-90.0, 0.0, 0.0, 1.0);
     const GLfloat zNear = 0.1, zFar = 430.0, fieldOfView = 60.0;
     GLfloat size;
     glEnable(GL_DEPTH_TEST);
     glMatrixMode(GL_PROJECTION);
     size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
     CGRect rect = self.view.bounds;
     glFrustumf( -size / (rect.size.height / rect.size.width),size / (rect.size.height / rect.size.width), -size, size , zNear, zFar);
     */
    
    CGRect rect = self.view.bounds;
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity();
    //glOrtho (0, rect.size.width , rect.size.height , 0, 0, 1);
    glOrthof(0, rect.size.width , rect.size.height, 0, 0, 1);
    glMatrixMode (GL_MODELVIEW);
    gotName = 0;
    subMenuMode = false;
    [Audio playSound:@"Ambiento"];
	//NSURL * someURL =[[NSBundle mainBundle] URLForResource:@"MDdone" withExtension:@"m4v"];
	//[PlayVideoViewController playMovieAtURL:someURL inView:self.view withDelegate:self];
	//videoDone=true;
//	gameState = 1000;
	
}


- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_COLOR, "color");
    
    // Link program.
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
    
    // Release vertex and fragment shaders.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    return TRUE;
}

@end
