package
{
	import flash.display.MovieClip;
	import Card;
	import Boarder;
	import BlueBoard;
	import flash.events.MouseEvent;
	import RedBoard;
	import Snow;
	
	public class MemoryGame extends MovieClip
	{
		private var _card:Card;
		private var _boarder:Boarder;
		private var _blueBoard:BlueBoard;
		private var _cardX:Number;
		private var _cardY:Number;
		private var _firstCard:*;
		private var _totalMatches:Number;
		private var _currentMatches:Number;
		private var _redBoard:RedBoard;
		private var _snow:Snow;
		private var _cards:Array;
		public var  _message:String;
		
		public function MemoryGame()
		{
			_message = "点一点纸牌，开始游戏吧！";
			message_txt.text = _message;
			
			_cards = new Array();
			_totalMatches = 4;
			_currentMatches = 0;
			createCards();
		}
		
		private function createCards():void
		{
			_cardX = 45;
			_cardY = 10;
			for(var i:Number = 0; i < 2; i++)
			{
				_card = new Card();
				addChild(_card);
				_boarder = new Boarder();
				_card.setType(_boarder);
				_card.x = _cardX;
				_card.y = _cardY;
				_cardX += _card.width + 50;
				_card.addEventListener(MouseEvent.CLICK, checkCards);
				_cards.push(_card);
			}
			for(var j:Number = 0; j < 2; j++)
			{
				_card = new Card();
				addChild(_card);
				_blueBoard = new BlueBoard();
				_card.setType(_blueBoard);
				_card.x = _cardX;
				_card.y = _cardY;
				_cardX += _card.width + 50;
				_card.addEventListener(MouseEvent.CLICK, checkCards);
				_cards.push(_card);
			}
			
			_cardX = 45;
			_cardY = _card.height + 30;
			for(var k:Number = 0; k < 2; k++)
			{
				_card = new Card();
				addChild(_card);
				_redBoard = new RedBoard();
				_card.setType(_redBoard);
				_card.x = _cardX;
				_card.y = _cardY;
				_cardX += _card.width + 50;
				_card.addEventListener(MouseEvent.CLICK, checkCards);
				_cards.push(_card);
			}
			for(var l:Number = 0; l < 2; l++)
			{
				_card = new Card();
				addChild(_card);
				_snow = new Snow();
				_card.setType(_snow);
				_card.x = _cardX;
				_card.y = _cardY;
				_cardX += _card.width + 50;
				_card.addEventListener(MouseEvent.CLICK, checkCards);
				_cards.push(_card);
			}
			randomizeCards(_cards);
		}
		
		private function checkCards(e:MouseEvent):void
		{
			e.currentTarget.removeEventListener(MouseEvent.CLICK, checkCards);
			if(_firstCard == undefined)
			{
				_firstCard = e.currentTarget;
			}
			else if(String(_firstCard._type) == String(e.currentTarget._type))
			{
				_message = "Good";
				message_txt.text = _message;
				_firstCard = undefined;
				_currentMatches ++;
				if(_currentMatches >= _totalMatches)
				{
					_message = "YOU WIN !";
					message_txt.text = _message;
				}
			}
			else
			{
				_message = "wrong";
				message_txt.text = _message;
				_firstCard.gotoAndPlay("flipBack");
				e.currentTarget.gotoAndPlay("flipBack");
				_firstCard.addEventListener(MouseEvent.CLICK, checkCards);
				e.currentTarget.addEventListener(MouseEvent.CLICK, checkCards);
				_firstCard = undefined;				
			}
		}
		
		private function randomizeCards(cards:Array):void
		{
			var randomCard1:Number;
			var randomCard2:Number;
			var card1X:Number;
			var card1Y:Number;
			
			for(var i:Number = 0; i < 10; i++)
			{
				randomCard1 = Math.floor(Math.random() * cards.length);
				randomCard2 = Math.floor(Math.random() * cards.length);
				
				card1X = cards[randomCard1].x;
				card1Y = cards[randomCard1].y;
				cards[randomCard1].x = cards[randomCard2].x;
				cards[randomCard1].y = cards[randomCard2].y
				cards[randomCard2].x = card1X;
				cards[randomCard2].y = card1Y;
			}
		}
	}
}