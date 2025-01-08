charName = "momo";
charAmount = 30;
charPosBeat = 1;
charPosDecay = 1;

function onBeatHit()
 if curBeat % charPosBeat == 0 then
  charAmount = math.random(15, 20);
  if boyfriendName == charName then setProperty('boyfriend.y', getProperty("boyfriend.y") + charAmount); end
  if dadName == charName then setProperty('dad.y', getProperty("dad.y") + charAmount); end
  if gfName == charName then setProperty('gf.y', getProperty("gf.y") + charAmount); end
 end
end

function onUpdate(elapsed)
 if boyfriendName == charName then charPosLerp("boyfriend", elapsed); end
 if dadName == charName then charPosLerp("dad", elapsed); end
 if gfName == charName then charPosLerp("gf", elapsed); end
end

function charPosLerp(char, dt)
 if char == "boyfriend" or char == "dad" or char == "gf" then
 local originY = getProperty(char .. "Group.y") + getProperty(char .. ".positionArray[1]");
 setProperty(char .. ".y", lerp(originY, getProperty(char .. ".y"), math.min(math.max(1 - (dt * 3.125 * charPosDecay), 0), 1)));
 else
 return;
 end
end

function lerp(s, e, t)
 return s + (e - s) * math.min(t, 1);
end