package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_19_19_BulletMovement extends ActorScript
{
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if((Engine.engine.getGameAttribute("Direction") == "up"))
		{
			actor.applyImpulseInDirection(270, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (0));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "down"))
		{
			actor.applyImpulseInDirection(90, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (180));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "left"))
		{
			actor.applyImpulseInDirection(180, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (270));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "right"))
		{
			actor.applyImpulseInDirection(0, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (90));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "upleft"))
		{
			actor.applyImpulseInDirection(225, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (225));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "upright"))
		{
			actor.applyImpulseInDirection(315, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (315));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "downleft"))
		{
			actor.applyImpulseInDirection(135, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (135));
		}
		else if((Engine.engine.getGameAttribute("Direction") == "downright"))
		{
			actor.applyImpulseInDirection(45, Engine.engine.getGameAttribute("BulletForce"));
			actor.setAngle(Utils.RAD * (45));
		}
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}