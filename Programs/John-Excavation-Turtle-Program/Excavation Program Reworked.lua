--[[
Version
  0.02 30/1/2015
Changelog
  0.01 - Starting Of Rewriting
  0.02 - More Writing
To Do List
  Fixing Bugs
--]]

-- Local Variables
-- Starting
local wide = 0
local wideCount = 0
local long = 0
local longCount = 0
local deep = 0
local deepCount = 0
local totalBlocks = 0
local coalNeeded = 0
local corrent = n
-- Inventory This Will Check At Start Code
local chest = 0
local fuelCount = 0
local fuelCount1 = 0
local noFuelNeed = 0 -- if Config has fuel no need on
local error = 0 -- Error Code
local reCheck = 0 -- Recheck Code
-- Others
local totalBlockDone = 0 -- How many Block Mined
local LSorWS = 0 -- Go Left or Go Right This is for Wide Code
local ALorAR = 0 -- align left Or align Right
local processRaw = 0
local process = 0
local enderChest = 0 -- TODO
local blockUp = 0 -- Fixing to Chest Probleem and moving probleem
local processRaw = 0
local process = 0

-- Checking
local function check()
    if noFuelNeed == 0 then
        if fuelCount == 0 then
            print("Turtle has no fuel")
            print("Put fuel in Second and Thrid slot")
            error = 1
        else
            print("Turtle has Fuel")
        end
        if fuelCount1 == 0 then
            print("Turtle has no extra fuel but if is short job it okey")
        end
    end
    if chest == 0 then
        print("No chest in Turtle")
        print("Put chest in 1 slot")
        error = 1
    else
        print("Turtle has chest")
    end
    if error == 1 then
        print("Items are missing please try again")
        print("Turtle will recheck in 8 sec")
    end
end

-- Recheck if user forget something turtle will check after 6 sec
local function reCheck()
    chest = turtle.getItemCount(1)
    fuelCount = turtle.getItemCount(2)
    fuelCount1 = turtle.getItemCount(3)
    error = 0
end

local function chestDump()
    repeat -- The Fix to Gravel Chest Bug. It check if gravel above then it dig till it gone
        turtle.digUp()
        sleep(0.6)
        if turtle.detectUp() then
            turtle.digUp()
            blockUp = 1
        else
            blockUp = 0
        end
    until blockUp == 0
    turtle.select(1)
    turtle.placeUp()
    chest = chest - 1
    for slot = 4, 16 do
        turtle.select(slot)
        sleep(0.6) -- Small fix for slow pc because i had people problem with this
        turtle.dropUp()
    end
    turtle.select(4)
    if Chest == 0 then
        print("Out Of Chest")
        os.shutdown()
    end
end

local function mineLong()
    if turtle.detect() then
        turtle.dig()
    end
    if turtle.forward() then
        longCount = longCount + 1
    else
        repeat
            turtle.dig()
            sleep(0.6)
            if turtle.forward() then
                blockUp = 0
            else
                blockUp = 1
            end
        until blockUp == 0
        longCount = longCount + 1
        print(totalBlocks - totalBlockDone)
    end
    if turtle.detectUp() then
        turtle.digUp()
    end
    if turtle.detectDown() then
        turtle.digDown()
    end
    totalBlockDone = totalBlockDone + 3
end

local function wideMineLeft() -- TODO
    turtle.turnLeft()
    if turtle.detect() then
        turtle.dig()
        sleep(0.6) -- Minor bug fix if there is gravel
    end
    if turtle.forward() then
        --notting
    else
        repeat
            turtle.dig()
            sleep(0.6)
            if turtle.forward() then
                blockUp = 0
            else
                blockUp = 1
            end
        until blockUp == 0
    end
    if turtle.detectUp() then
        turtle.digUp()
    end
    if turtle.detectDown() then
        turtle.digDown()
    end
    turtle.turnLeft()
    LSorWS = 0
    longCount = 0
    wideCount = wideCount + 1
    totalBlockDone = totalBlockDone + 3
end

local function wideMineRight() -- TODO
    turtle.turnRight()
    if turtle.detect() then
        turtle.dig()
        sleep(0.6)
    end
    if turtle.forward() then
        --Notting
    else
        repeat
            turtle.dig()
            sleep(0.6)
            if turtle.forward() then
                blockUp = 0
            else
                blockUp = 1
            end
        until blockUp == 0
    end
    if turtle.detectUp() then
        turtle.digUp()
    end
    if turtle.detectDown() then
        turtle.digDown()
    end
    turtle.turnRight()
    LSorWS = 1
    longCount = 0
    wideCount = wideCount + 1
    totalBlockDone = totalBlockDone + 3
end

local function deep()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    if ALorAR == 1 then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
    wideCount = 0
    longCount = 0
    totalBlockDone = totalBlockDone + 3
end

local function main()
    repeat -- Repeat for Deep
        repeat --Repeat for each level
            mineLong()
            reFuel()
            if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
                chestDump()
            end
            if Long == Lc then
                if wide ~= wideCount then
                    process = TotalBlockDone / TotalBlocks * 100
                    processRaw = TotalBlocks - TotalBlockDone
                    print("How Much Is Done: " .. math.floor(process+0.5) .. " %")
                    print("TotalBlocks Still Need To Dig Is " .. processRaw)
                    if LSorWS == 0 then
                        wideMineRight()
                    else
                        wideMineLeft()
                    end
                end
            end
        until wideCount == wide and longCount == long
    until deepCount == deep
end

local function Start()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    wideCount = 0
    longCount = 0
    totalBlockDone = totalBlockDone + 3
end

local function start()
    print("Welcome To Excavation Turtle Program")
    print("Slot 1: Chest, Slot 2: Fuel, Slot 3: Fuel")
    print("Note: If now put item in then it say error just wait it fix it self")
    print("How long(Lenght) you want")
    input = io.read()
    long = tonumber(input)
    long = long - 1
    print("How wide(Width) you want")
    input2 = io.read()
    wide = tonumber(input2)
    wide = wide - 1
    print("How Deep(Depth) You Want")
    input3 = io.read()
    deep = tonumber(input3)
    print("Is This Corrent Lenght " .. "Lenght = " .. (long + 1) .. " Width = " .. (wide + 1) .. " Depth = " .. (deep))
    print("Type y Or Y  if it is corrent and if not then n or N")
    input4 = io.read()
    corrent = input4
    if corrent == n or N then
        os.reboot()
    elseif corrent == y or Y then
        print("Okey Program Will Do Calculations")
    end
    totalBlocks = (wide + 1) * (long + 1) * deep -- 1 is add because above it removed for wide and long code
    print("Total amount for block to mine is " .. totalBlocks)
    coalNeeded = totalBlocks / 3 / 80
    print("Total amount for Coal needed is " .. math.floor(coalNeeded+0.5))
    if turtle.getFuelLevel() == "unlimited" then
        print("Your turtle config does need fuel")
        noFuelNeed = 1
    elseif turtle.getFuelLevel() < 160 then
        turtle.select(2)
        turtle.refuel(2)
    end
    chest = turtle.getItemCount(1)
    fuelCount = turtle.getItemCount(2)
    fuelCount1 = turtle.getItemCount(3)
    check()
    if error == 1 then
        repeat
            sleep(8)
            reCheck()
            check()
        until error == 0
    end
    print("Turtle will now start!")
    Start()
    main()
end

Start()