camOffsetFollow = nil;
bfOffsetFollow = nil;
dadOffsetFollow = nil;
gfOffsetFollow = nil;
bfOffsetPos = {nil, nil};
dadOffsetPos = {nil, nil};
gfOffsetPos = {nil, nil};
bfPos = {nil, nil};
dadPos = {nil, nil};
gfPos = {nil, nil};
bfZoom = nil;
dadZoom = nil;
gfZoom = nil;

function onUpdate()
if camOffsetFollow == nil then camOffsetFollow = 0; end

 ofs = camOffsetFollow;

if bfPos[1] == nil then
 bfCamPosX = getMidpointX('boyfriend') - 100 - (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')) + (bfOffsetPos[1] == nil and 0 or bfOffsetPos[1]);
else
 bfCamPosX = bfPos[1] + (bfOffsetPos[1] == nil and 0 or bfOffsetPos[1]);
end
if bfPos[2] == nil then
 bfCamPosY = getMidpointY('boyfriend') - 100 + (getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]')) + (bfOffsetPos[2] == nil and 0 or bfOffsetPos[2]);
else
 bfCamPosY = bfPos[2] + (bfOffsetPos[2] == nil and 0 or bfOffsetPos[2]);
end

if dadPos[1] == nil then
 dadCamPosX = getMidpointX('dad') + 150 + (getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')) + (dadOffsetPos[1] == nil and 0 or dadOffsetPos[1]);
else
 dadCamPosX = dadPos[1] + (dadOffsetPos[1] == nil and 0 or dadOffsetPos[1]);
end
if dadPos[2] == nil then
 dadCamPosY = getMidpointY('dad') - 100 + (getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')) + (dadOffsetPos[2] == nil and 0 or dadOffsetPos[2]);
else
 dadCamPosY = dadPos[2] + (dadOffsetPos[2] == nil and 0 or dadOffsetPos[2]);
end

if gfPos[1] == nil then
 gfCamPosX = getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')) + (gfOffsetPos[1] == nil and 0 or gfOffsetPos[1]);
else
 gfCamPosX = gfPos[1] + (gfOffsetPos[1] == nil and 0 or gfOffsetPos[1]);
end
if gfPos[2] == nil then
 gfCamPosY = getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')) + (gfOffsetPos[2] == nil and 0 or gfOffsetPos[2]);
else
 gfCamPosY = gfPos[2] + (gfOffsetPos[2] == nil and 0 or gfOffsetPos[2]);
end

if not gfSection then
 if mustHitSection then
	 if bfZoom ~= nil then setProperty("defaultCamZoom", bfZoom); end
	 setCameraFollow(bfCamPosX, bfCamPosY);
	if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
	 setCameraFollow(bfCamPosX - (bfOffsetFollow == nil and (bfOffsetFollow == nil and ofs or bfOffsetFollow) or bfOffsetFollow), bfCamPosY);
	elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
	 setCameraFollow(bfCamPosX, bfCamPosY - (bfOffsetFollow == nil and ofs or bfOffsetFollow));
	elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
	 setCameraFollow(bfCamPosX, bfCamPosY + (bfOffsetFollow == nil and ofs or bfOffsetFollow));
	elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
	 setCameraFollow(bfCamPosX + (bfOffsetFollow == nil and ofs or bfOffsetFollow), bfCamPosY);
	end

 else

	 if dadZoom ~= nil then setProperty("defaultCamZoom", dadZoom); end
	 setCameraFollow(dadCamPosX, dadCamPosY);
	if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
	 setCameraFollow(dadCamPosX - (dadOffsetFollow == nil and ofs or dadOffsetFollow), dadCamPosY);
	 if dadName == 'nikku-jojo' then setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.002 * getProperty("camGame.zoom")); end
	elseif getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
	 setCameraFollow(dadCamPosX, dadCamPosY - (dadOffsetFollow == nil and ofs or dadOffsetFollow));
	 if dadName == 'nikku-jojo' then setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.003 * getProperty("camGame.zoom")); end
	elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
	 setCameraFollow(dadCamPosX, dadCamPosY + (dadOffsetFollow == nil and ofs or dadOffsetFollow));
	 if dadName == 'nikku-jojo' then setProperty("camGame.zoom", getProperty("camGame.zoom") - 0.0015 * getProperty("camGame.zoom")); end
	elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
	 setCameraFollow(dadCamPosX + (dadOffsetFollow == nil and ofs or dadOffsetFollow), dadCamPosY);
	 if dadName == 'nikku-jojo' then setProperty("camGame.zoom", getProperty("camGame.zoom") - 0.001 * getProperty("camGame.zoom")); end
	end
 end

else
 if gfZoom ~= nil then setProperty("defaultCamZoom", gfZoom); end
 setCameraFollow(gfCamPosX, gfCamPosY);
	if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' then
	 setCameraFollow(gfCamPosX - (gfOffsetFollow == nil and ofs or gfOffsetFollow), gfCamPosY);
	elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
	 setCameraFollow(gfCamPosX, gfCamPosY - (gfOffsetFollow == nil and ofs or gfOffsetFollow));
	elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' then
	 setCameraFollow(gfCamPosX, gfCamPosY + (gfOffsetFollow == nil and ofs or gfOffsetFollow));
	elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' then
	 setCameraFollow(gfCamPosX + (gfOffsetFollow == nil and ofs or gfOffsetFollow), gfCamPosY);
	end
	end
end

function setCameraFollow(x, y)
	triggerEvent("Camera Follow Pos", x, y);
end