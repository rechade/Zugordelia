s.boot;
MIDIClient.init;
MIDIIn.connectAll;
//~kickArray = "/home/pi/Desktop/kitz/9th/kickz/*.wav".pathMatch;
//~snareArray = "/home/pi/Desktop/kitz/9th/snarez/*.wav".pathMatch;
//~hatArray = "/home/pi/Desktop/kitz/9th/hatz/*.wav".pathMatch;

~kickArray = "c:/dilla/kickz/*.wav".pathMatch;
~snareArray = "c:/dilla/snarez/*.wav".pathMatch;
~hatArray = "c:/dilla/hatz/*.wav".pathMatch;

// use 1st file in each folder (needs validations)
~kickIndex=0;
~snareIndex=0;
~hatIndex=0;

// consts for each pad
~kick=67;
~snare=65;
~hat=66;
~up=63;
~down=64;

~kickBuffer = Buffer.read(s,~kickArray[~kickIndex],0,-1,[0,1]);
~snareBuffer= Buffer.read(s,~snareArray[~snareIndex],0,-1,[0,1]);
~hatBuffer = Buffer.read(s,~hatArray[~hatIndex],0,-1,[0,1]);

(
MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	[vel, nn, chan, src].postln;
	case
	{nn == ~kick} {~kickBuffer.play;~last = nn;}
	{nn == ~snare} {~snareBuffer.play;~last = nn;}
	{nn == ~hat} {~hatBuffer.play;~last = nn;}
	{nn == ~up} {
		case
		{~last == ~kick}{
			~kickIndex=~kickIndex+1;
			~kickBuffer=Buffer.read(s,~kickArray[~kickIndex],0,-1,[0,1]);
		}
		{~last == ~snare}{
			~snareIndex=~snareIndex+1;
			~snareBuffer=Buffer.read(s,~snareArray[~snareIndex]);
		}
		{~last == ~hat}{
			~hatIndex=~hatIndex+1;
			~hatBuffer=Buffer.read(s,~hatArray[~hatIndex]);
		}
	}
	{nn == ~down} {
		case
		{~last == ~kick}{
			~kickIndex=~kickIndex-1;
			~kickBuffer=Buffer.read(s,~kickArray[~kickIndex],0,-1,[0,1]);
		}
		{~last == ~snare}{
			~snareIndex=~snareIndex-1;
			~snareBuffer=Buffer.read(s,~snareArray[~snareIndex]);
		}
		{~last == ~hat}{
			~hatIndex=~hatIndex-1;
			~hatBuffer=Buffer.read(s,~hatArray[~hatIndex]);
		}
	}
}
);


);
