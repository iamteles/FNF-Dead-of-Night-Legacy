function loadAnimations()
{
	addByPrefix('idle', 'Abi Idle', 24, false);
	addByPrefix('sing', 'Abi Speaking', 24, false);

	addOffset('idle', 115, 189);
	addOffset('sing', 220, 226)

	if (isPlayer)
		set('flipX', true);
	else
		set('flipX', false);

	playAnim('idle');
	set('antialiasing', true);
	setBarColor([255, 255, 140]);
	setCamOffsets(30, -300);
	setOffsets(-130, 370);
}