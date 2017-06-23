s.boot;
MIDIClient.init;
MIDIIn.connectAll;
//~kickArray = "/home/pi/Desktop/kitz/9th/kickz/*.wav".pathMatch;
//~snareArray = "/home/pi/Desktop/kitz/9th/snarez/*.wav".pathMatch;
//~hatArray = "/home/pi/Desktop/kitz/9th/hatz/*.wav".pathMatch;

~kickArray = "c:/dilla/kickz/*.wav".pathMatch;
~snareArray = "c:/dilla/snarez/*.wav".pathMatch;
~hatArray = "c:/dilla/hatz/*.wav".pathMatch;
if (~platform=="pi",{
	// DRUMHAT consts
	~kick=67;
	~hat=66;
	~snare=65;
	~up=63;
	~down=64;
	// raspi paths
	~kickArray = "/home/pi/Desktop/kitz/9th/kickz/*.wav".pathMatch;
	~snareArray = "/home/pi/Desktop/kitz/9th/snarez/*.wav".pathMatch;
	~hatArray = "/home/pi/Desktop/kitz/9th/hatz/*.wav".pathMatch;
},
{
	// windows paths
	~kickArray = "c:/dilla/kickz/*.wav".pathMatch;
	~snareArray = "c:/dilla/snarez/*.wav".pathMatch;
	~hatArray = "c:/dilla/hatz/*.wav".pathMatch;
	// PUSH consts for each pad
	~kick=38;
	~hat=37;
	~snare=36;
	~up=99;
	~down=91;
})

// use 1st file in each folder (needs validations)
~kickIndex=0;
~snareIndex=0;
~hatIndex=0;




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
			~kickIndex=(~kickIndex+1) % ~kickArray.size;
			~kickBuffer=Buffer.read(s,~kickArray[~kickIndex],0,-1,[0,1]);
		}
		{~last == ~snare}{
			~snareIndex=(~snareIndex+1) % ~snareArray.size;
			~snareBuffer=Buffer.read(s,~snareArray[~snareIndex]);
		}
		{~last == ~hat}{
			~hatIndex=(~hatIndex+1) % ~hatArray.size;
			~hatBuffer=Buffer.read(s,~hatArray[~hatIndex]);
		}
	}
	{nn == ~down} {
		case
		{~last == ~kick}{
			~kickIndex=(~kickIndex-1)  % ~kickArray.size;
			~kickBuffer=Buffer.read(s,~kickArray[~kickIndex],0,-1,[0,1]);
		}
		{~last == ~snare}{
			~snareIndex=(~snareIndex-1) % ~snareArray.size;
			~snareBuffer=Buffer.read(s,~snareArray[~snareIndex]);
		}
		{~last == ~hat}{
			~hatIndex=(~hatIndex-1) % ~hatArray.size;
			~hatBuffer=Buffer.read(s,~hatArray[~hatIndex]);
		}
	}
}
);


);
