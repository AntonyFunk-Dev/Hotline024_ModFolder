function onCreatePost()
  makeLuaSprite("UpperBar");
  makeGraphic("UpperBar", screenWidth * 2, screenHeight, '000000');
  screenCenter("UpperBar", 'x');
  setObjectCamera("UpperBar", 'camHUD');
  addLuaSprite("UpperBar");
  setProperty("UpperBar.y", getProperty("UpperBar.y") - getProperty("UpperBar.height") + 70);

  makeLuaSprite("LowerBar");
  makeGraphic("LowerBar", screenWidth * 2, screenHeight, '000000');
  screenCenter("LowerBar", 'x');
  setObjectCamera("LowerBar", 'camHUD');
  addLuaSprite("LowerBar");
  setProperty("LowerBar.y", (getProperty("LowerBar.y") + getProperty("LowerBar.height")) - 70);
end