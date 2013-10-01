package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Gustav Grännsjö
	 */
	public class Main extends Sprite 
	{
		
		public var playerDamage:int = 15;
		public var monsterDamage:int = 30;
		public var playerHP:int = 220;
		public var monsterHP:int = 110;
		public var originPlayerHP:int = playerHP;
		public var originMonsterHP:int = monsterHP;
		public var playerName:String = "Garruk Wildspeaker";
		public var monsterName:String = "Jace Beleren";
		public var texty:TextField = new TextField();
		public var playerDmgTaken:int = 0
		public var monsterDmgTaken:int = 0
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			texty.width = 500;
			texty.height = 800;
			texty.border = true;
			texty.wordWrap = true;
			texty.multiline = true;
			addChild(texty);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, fightFiveRounds); //Restart the fight if you press space
			
			
		}
		public function fightFiveRounds(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32) //(Spacebar)
			{
				//Reset the variables that changed
				texty.text = "";
				playerHP = originPlayerHP;
				monsterHP = originMonsterHP;
				//Start the fighting
				for (var i:int = 1; i <= 6; i++)
				{
					if (i != 1 && i !=6) //Writing out the hp remaining
					{
						texty.appendText("|Round " + i + "|\n" + playerName + "'s health remaining: " + String(playerHP) + "\n");
						texty.appendText(monsterName + "'s health remaining: " + String(monsterHP) + "\n\n");
					}
					else if (i != 6) //Writing out the starting HP of turn 1
					{
						texty.appendText("|Round " + i + "|\n" + playerName + "'s starting health: " + String(playerHP) + "\n");
						texty.appendText(monsterName + "'s starting health: " + String(monsterHP) + "\n\n");
					}
					if (i == 6) //Writing out the results after all the 5 turns
					{
						texty.appendText("|Results|\n" + playerName + "'s health remaining: " + String(playerHP) + "\n");
						texty.appendText(monsterName + "'s health remaining: " + String(monsterHP) + "\n\n");
						if (playerHP > 0 && monsterHP <= 0)
						{
							texty.appendText(playerName + " is victorious!");
						}
						else if (playerHP <= 0 && monsterHP > 0)
						{
							texty.appendText(monsterName + " is victorious!");
						}
						else if (playerHP <= 0 && monsterHP <= 0)
						{
							texty.appendText("They killed each other!");
						}
						else if (playerHP > monsterHP)
						{
							texty.appendText(monsterName + " planeswalks away in shame!"); 
						}
						else
						{
							texty.appendText(playerName + " planeswalks away in shame!"); 
						}
					}
					//Calculate damage
					playerDmgTaken = monsterDamage + monsterDamage * Math.random();
					monsterDmgTaken = playerDamage + playerDamage * Math.random();
					//Inflict the damage
					playerHP -= playerDmgTaken;
					monsterHP -= monsterDmgTaken;
					//Write out how much damage has been dealt
					if (i != 6)
					{
						texty.appendText(playerName + " deals " + String(monsterDmgTaken) + " damage to " + monsterName + "\n");
						texty.appendText(monsterName + " deals " + String(playerDmgTaken) + " damage to " + playerName + "\n\n");
					}
				}
			}
		}
	}
	
}