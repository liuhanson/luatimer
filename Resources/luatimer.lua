require "AudioEngine" 

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

    -- creat timer
    
    counter = 60

    local function createLayerTimer()
    
    local visibleSize = CCDirector:getInstance():getVisibleSize()
    local origin = CCDirector:getInstance():getVisibleOrigin()


        local layerTimer = CCLayer:create()
        
        local labelTimer = CCLabelTTF:create("60", "Arial", 120)
            labelTimer:setPosition(320, 500)
            
        layerTimer:addChild(labelTimer)

        local function update(dt)
            counter = counter - 1
            labelTimer:setString(counter)
        end

        local function menuCallbackStart()
            counter = 60
            labelTimer:setVisible(false)
            entry =  CCDirector:getInstance():getScheduler():scheduleScriptFunc(update, 1, false)
        end

        local function menuCallbackStop()
            labelTimer:setVisible(true)
            CCDirector:getInstance():getScheduler():unscheduleScriptEntry(entry)
        end


        local menuStart = CCMenuItemImage:create("menu3.png", "menu3.png")
        menuStart:setPosition(origin.x + 200, origin.y + 200)
        menuStart:registerScriptTapHandler(menuCallbackStart)

        local menuStop = CCMenuItemImage:create("menu4.png", "menu4.png")
        menuStop:setPosition(origin.x + 500, origin.y + 200)
        menuStop:registerScriptTapHandler(menuCallbackStop)

        local menu = CCMenu:create()
            menu:setPosition(0, 0)
            menu:addChild(menuStart)
            menu:addChild(menuStop)

        layerTimer:addChild(menu)

        return layerTimer
    end

 

    -- run
    local sceneGame = CCScene:create()
    sceneGame:addChild(createLayerTimer())
    CCDirector:getInstance():runWithScene(sceneGame)
end

xpcall(main, __G__TRACKBACK__)
