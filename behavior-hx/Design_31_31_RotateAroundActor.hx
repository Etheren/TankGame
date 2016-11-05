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



class Design_31_31_RotateAroundActor extends ActorScript
{
	public var _DistanceX:Float;
	public var _DistanceY:Float;
	public var _Direction:Float;
	public var _Distance:Float;
	public var _Speed:Float;
	public var _Facing:Float;
	public var _PointAway:Bool;
	public var _OriginActor:Actor;
	public var _StepSeconds:Float;
	public var _NewDistance:Float;
	public var _DistanceThreshold:Float;
	public var _FixedRadius:Bool;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_Initialize():Void
	{
		if(((hasValue(_OriginActor)) && _OriginActor.isAlive()))
		{
			_DistanceX = asNumber((actor.getXCenter() - _OriginActor.getXCenter()));
			propertyChanged("_DistanceX", _DistanceX);
			_DistanceY = asNumber((actor.getYCenter() - _OriginActor.getYCenter()));
			propertyChanged("_DistanceY", _DistanceY);
			_Distance = asNumber(Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2))));
			propertyChanged("_Distance", _Distance);
			_Direction = asNumber(Math.atan2(_DistanceY, _DistanceX));
			propertyChanged("_Direction", _Direction);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Distance X", "_DistanceX");
		_DistanceX = 0.0;
		nameMap.set("Distance Y", "_DistanceY");
		_DistanceY = 0.0;
		nameMap.set("Direction", "_Direction");
		_Direction = 0.0;
		nameMap.set("Distance", "_Distance");
		_Distance = 0.0;
		nameMap.set("Speed", "_Speed");
		_Speed = 10.0;
		nameMap.set("Facing", "_Facing");
		_Facing = 0.0;
		nameMap.set("Point Away", "_PointAway");
		_PointAway = true;
		nameMap.set("Origin Actor", "_OriginActor");
		nameMap.set("Step Seconds", "_StepSeconds");
		_StepSeconds = 0.0;
		nameMap.set("New Distance", "_NewDistance");
		_NewDistance = 0.0;
		nameMap.set("Distance Threshold", "_DistanceThreshold");
		_DistanceThreshold = 10.0;
		nameMap.set("Fixed Radius", "_FixedRadius");
		_FixedRadius = true;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_StepSeconds = asNumber((getStepSize() / 1000));
		propertyChanged("_StepSeconds", _StepSeconds);
		_customEvent_Initialize();
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((hasValue(_OriginActor)) && _OriginActor.isAlive()))
				{
					if(!(_FixedRadius))
					{
						_DistanceX = asNumber((actor.getXCenter() - _OriginActor.getXCenter()));
						propertyChanged("_DistanceX", _DistanceX);
						_DistanceY = asNumber((actor.getYCenter() - _OriginActor.getYCenter()));
						propertyChanged("_DistanceY", _DistanceY);
						_NewDistance = asNumber(Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2))));
						propertyChanged("_NewDistance", _NewDistance);
						if((Math.abs((_NewDistance - _Distance)) > _DistanceThreshold))
						{
							_Distance = asNumber(_NewDistance);
							propertyChanged("_Distance", _Distance);
							_Direction = asNumber(Math.atan2(_DistanceY, _DistanceX));
							propertyChanged("_Direction", _Direction);
						}
					}
					_Direction = asNumber((_Direction + Utils.RAD * ((_Speed * _StepSeconds))));
					propertyChanged("_Direction", _Direction);
					_Direction = asNumber((_Direction - ((2 * Math.PI) * Math.floor((_Direction / (2 * Math.PI))))));
					propertyChanged("_Direction", _Direction);
					actor.setX(((_OriginActor.getXCenter() + (_Distance * Math.cos(_Direction ))) - (actor.getWidth()/2)));
					actor.setY(((_OriginActor.getYCenter() + (_Distance * Math.sin(_Direction ))) - (actor.getHeight()/2)));
					if(_PointAway)
					{
						actor.setAngle(Utils.RAD * ((Utils.DEG * (_Direction) - _Facing)));
					}
				}
			}
		});
		
		/* ======================== Something Else ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_Speed = asNumber(-(_Speed));
				propertyChanged("_Speed", _Speed);
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((sceneHasBehavior("Game Debugger") && asBoolean(getValueForScene("Game Debugger", "_Enabled"))))
				{
					if(((hasValue(_OriginActor)) && _OriginActor.isAlive()))
					{
						g.strokeColor = getValueForScene("Game Debugger", "_CustomColor");
						g.strokeSize = Std.int(getValueForScene("Game Debugger", "_StrokeThickness"));
						g.translateToScreen();
						g.drawCircle(_OriginActor.getXCenter(), _OriginActor.getYCenter(), _Distance);
						g.drawLine(_OriginActor.getXCenter(), _OriginActor.getYCenter(), actor.getXCenter(), actor.getYCenter());
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}