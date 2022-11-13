function loadAnimations()
{
	addByPrefix('idle', 'Abi Idle', 24, false);
	addByPrefix('singUP', 'Abi Up', 24);
	addByPrefix('singRIGHT', 'Abi Right', 24);
	addByPrefix('singDOWN', 'Abi Down', 24);
	addByPrefix('singLEFT', 'Abi Left', 24);

	addByPrefix('idle-alt', 'Abi IDLEAnnoyed', 24, false);
	addByPrefix('singUP-alt', 'Abi UPAnnoyed', 24);
	addByPrefix('singRIGHT-alt', 'Abi RIGHTAnnoyed', 24);
	addByPrefix('singDOWN-alt', 'Abi DOWNAnnoyed', 24);
	addByPrefix('singLEFT-alt', 'Abi LEFTAnnoyed', 24);

	addOffset('idle', -508, -120);
	addOffset('singUP', -487, -103);
	addOffset('singDOWN', -512, -149);
	addOffset('singLEFT', -454, -118);
	addOffset('singRIGHT', -529, -116);

	addOffset('idle-alt', -509, -121);
	addOffset('singUP-alt', -493, -103);
	addOffset('singDOWN-alt', -514, -149);
	addOffset('singLEFT-alt', -461, -122);
	addOffset('singRIGHT-alt', -534, -122);

	playAnim('idle');
	set('antialiasing', true);
	setBarColor([255, 255, 140]);
	//setOffsets(-120, 690);
}