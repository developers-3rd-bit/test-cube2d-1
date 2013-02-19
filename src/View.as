package
{
   import com.greensock.TweenMax;
   import com.halcyon.layout.common.HalcyonHGroup;
   import com.halcyon.layout.common.HalcyonVGroup;
   import com.halcyon.layout.common.LayoutEvent;
   import com.soma.ui.layouts.VBoxUI;
   
   import common.TweenedButton;
   import common.UserPanel;
   
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View extends Sprite
   {
      public static const WEBCAM_BTN_CLICK:String = "webcamBtnClick";
      public static const CALL_BTN_CLICK:String = "callBtnClick";
      public static const INFO_BTN_CLICK:String = "infoBtnClick";
      public static const HELP_BTN_CLICK:String = "helpBtnClick";
      public static const AWAY_BTN_CLICK:String = "awayBtnClick";
      public static const CUBE_CLICK:String = "cubeClick";
      
      private var _vGroup:HalcyonVGroup;
      private var _userPanel:UserPanel;
      private var _hGroup:HalcyonHGroup;
      private var _buttonsHGroup:HalcyonHGroup;
      private var _leftArrowBtn:TweenedButton;
      private var _webcamBtn:TweenedButton;
      private var _callBtn:TweenedButton;
      private var _infoBtn:TweenedButton;
      private var _helpBtn:TweenedButton;
      private var _awayBtn:TweenedButton;
      private var _rightArrowBtn:TweenedButton;
      private var _preferredWidth:Number = 24;
      private var _preferredHieght:Number = 24;
      private var _buttonsHGroupMask:Shape;
      private var _initialButtonGroupXValue:Number;
      
      private var _inSpotLight:Boolean = false;
      
      public function View(width:Number, height:Number)
      {
         super();
         
         _vGroup = new HalcyonVGroup(this, width, height);
         _vGroup.verticalGap = 5;
         _vGroup.childrenAlign = VBoxUI.ALIGN_TOP_CENTER;
         
         _userPanel = new UserPanel();
         _userPanel.addEventListener(MouseEvent.CLICK, onCubeClick, false, 0, true);
         _vGroup.addChild(_userPanel);
         
         _buttonsHGroupMask = new Shape();
         _hGroup = new HalcyonHGroup(this, width);
         _hGroup.paddingLeft = 9;
         _hGroup.horizontalgap = 10;
         _buttonsHGroup = new HalcyonHGroup(_hGroup, 130, 24);
         _buttonsHGroup.horizontalgap = 10;
         
         _leftArrowBtn = new TweenedButton(McLeftArrow, _preferredWidth, _preferredHieght);
         _leftArrowBtn.addEventListener(MouseEvent.CLICK, onLeftArrowBtnClick, false, 0, true);
         _hGroup.addChild(_leftArrowBtn);
         
         _webcamBtn = new TweenedButton(McWebcam, _preferredWidth, _preferredHieght);
         _webcamBtn.addEventListener(MouseEvent.CLICK, onWebcamBtnClick, false, 0, true);
         _buttonsHGroup.addChild(_webcamBtn);
         
         _callBtn = new TweenedButton(McCall, _preferredWidth, _preferredHieght);
         _callBtn.addEventListener(MouseEvent.CLICK, onCallBtnClick, false, 0, true);
         _buttonsHGroup.addChild(_callBtn);
         
         _infoBtn = new TweenedButton(McInfo, _preferredWidth, _preferredHieght);
         _infoBtn.addEventListener(MouseEvent.CLICK, onInfoBtnClick, false, 0, true);
         _buttonsHGroup.addChild(_infoBtn);
         
         _helpBtn = new TweenedButton(McHelp, _preferredWidth, _preferredHieght);
         _helpBtn.addEventListener(MouseEvent.CLICK, onHelpBtnClick, false, 0, true);
         _buttonsHGroup.addChild(_helpBtn);
         
         _awayBtn = new TweenedButton(McAway, _preferredWidth, _preferredHieght);
         _awayBtn.addEventListener(MouseEvent.CLICK, onAwayBtnClick, false, 0, true);
         _buttonsHGroup.addChild(_awayBtn);
         
         _hGroup.addChild(_buttonsHGroup);
         _initialButtonGroupXValue = _buttonsHGroup.x + 5;
         
         _rightArrowBtn = new TweenedButton(McRightArrow, _preferredWidth, _preferredHieght);
         _rightArrowBtn.addEventListener(MouseEvent.CLICK, onRightArrowBtnClick, false, 0, true);
         _hGroup.addChild(_rightArrowBtn);
         
         _vGroup.addChild(_hGroup);
         this.addChild(_vGroup);
         
         _buttonsHGroupMask = new Shape;
         drawMask();
         _buttonsHGroup.mask = _buttonsHGroupMask;
         _leftArrowBtn.enabled = false;
         _leftArrowBtn.alpha = .5;
         _userPanel.height = height - _buttonsHGroup.height - 5;
         _userPanel.width = width - 20;
         this.addChild(_buttonsHGroupMask);
      }
      
      override public function get height():Number
      {
         return _vGroup.height;
      }
      
      public function get inSpotLight():Boolean
      {
         return _inSpotLight;
      }
      
      private function onCubeClick(event:Event):void
      {
         var layoutEvent:LayoutEvent = new LayoutEvent(CUBE_CLICK);
         layoutEvent.extra = this;
         dispatchEvent(layoutEvent);
      }
      
      public function scale():void
      {
         this.scaleX = 1.5;
         this.scaleY = 1.5;
         _inSpotLight = true;
      }
      
      public function unScale():void
      {
         this.scaleX = 1;
         this.scaleY = 1;
         _inSpotLight = false;
      }
      
      public function drawMask():void
      {
         _buttonsHGroupMask.graphics.clear();
         _buttonsHGroupMask.graphics.beginFill(0xFFFFFF, 1);
         _buttonsHGroupMask.graphics.drawRect(_buttonsHGroup.x - 1, _buttonsHGroup.y, _buttonsHGroup.width, 800);
         _buttonsHGroupMask.graphics.endFill();
      }
      
      public function set userName(value:String):void
      {
         _userPanel.userName = value;
      }
      
      public function set userImage(value:DisplayObject):void
      {
         _userPanel.userImage = value;
      }
      
      private function onLeftArrowBtnClick(event:Event):void 
      {
         if(_leftArrowBtn.enabled == false) return;
         TweenMax.to(_buttonsHGroup, 1.0, {x:_initialButtonGroupXValue - 2});
         _leftArrowBtn.enabled = false;
         _leftArrowBtn.alpha = .5;
         _rightArrowBtn.alpha = 1;
         _rightArrowBtn.enabled = true;
      }
      
      private function onRightArrowBtnClick(event:Event):void 
      {
         if(_rightArrowBtn.enabled == false) return;
         TweenMax.to(_buttonsHGroup, 1.0, {x:_initialButtonGroupXValue - _preferredWidth - 15});
         _rightArrowBtn.enabled = false;
         _rightArrowBtn.alpha = .5;
         _leftArrowBtn.alpha = 1;
         _leftArrowBtn.enabled = true;
      }
      
      private function onWebcamBtnClick(event:Event):void
      {
         dispatchEvent(new Event(WEBCAM_BTN_CLICK));
      }
      
      private function onCallBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(CALL_BTN_CLICK));
      }
      
      private function onInfoBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(INFO_BTN_CLICK));
      }
      
      private function onHelpBtnClick(event:Event):void
      {
         dispatchEvent(new Event(HELP_BTN_CLICK));
      }
      
      private function onAwayBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(AWAY_BTN_CLICK));
      }
   }
}