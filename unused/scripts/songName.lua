function onCreatePost()
	makeLuaSprite('songCreditBG', 'songSlide/bartext', 0, 200);
	setObjectCamera('songCreditBG', 'camOther');
	addLuaSprite('songCreditBG');
	setProperty('songCreditBG.alpha', 0.7);

	makeLuaText('songCreditTxt', songName);
	setTextSize('songCreditTxt', 40);
	setTextBorder('songCreditTxt', 0);
	setTextFont('songCreditTxt', 'cocoSharp.ttf');
	setTextAlignment('songCreditTxt', 'left');
	setObjectCamera('songCreditTxt', 'camOther');
	setBlendMode('songCreditTxt', 'add');
	setProperty('songCreditTxt.antialiasing', getProperty('songCreditBG.antialiasing'));
	setObjectOrder('songCreditTxt', getObjectOrder('songCreditBG') + 1);

	setProperty('songCreditBG.x', -getProperty('songCreditBG.width'));
	setProperty('songCreditBG.scale.y', getProperty('songCreditBG.scale.y') / (getProperty('songCreditBG.height') / getProperty('songCreditTxt.height')) + 0.25);
	setProperty('songCreditTxt.y', getProperty('songCreditBG.y') + (getProperty('songCreditBG.height') - getProperty('songCreditTxt.height'))/2);
 
	runTimer('startCredit', getVar('crochetSec'));
end

function onUpdatePost(elapsed)
	setProperty('songCreditTxt.x', getProperty('songCreditBG.x') + (getProperty('songCreditBG.width') - getProperty('songCreditTxt.width')) - 60);
end

function onTimerCompleted(tag)
	if tag == 'startCredit' then
		startTween('creditStart', 'songCreditBG', {x = -getProperty('songCreditBG.width') + 75 + getProperty('songCreditTxt.width')}, getVar('crochetSec') * 2, {ease = 'quartOut', onComplete = 'onTweenCompleted'});
	end

	if tag == 'startFinish' then
		startTween('creditFinish', 'songCreditBG', {x = -getProperty('songCreditBG.width')}, getVar('crochetSec') * 2, {ease = 'quartIn'});
	end
end

function onTweenCompleted(tag)
	if tag == 'creditStart' then
		runTimer('startFinish', getVar('crochetSec') * 8);
	end
end
