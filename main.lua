
-- takes a multi dim table and compares a column value against a value returns true or false   
local function tableCheck(table, column, value)
  for i, innerTable in ipairs(table) do
    local currentValue = innerTable[column]
    if currentValue == value then 
    return true                     -- Found a match, exit early
    end
  end
  return false                      -- no match
end

-- takes in a table and a new value (or table) and puts it on the end of the table returns new table
local function tableGrow(table,value)
    table[#table + 1] = value
    return table
end

-- Generates a list of existing timers and returns them as a table {{'name',number},{},..} Requires tableGrow() to work.
local function tmrsTable()

  local tmrsTable = {}
  local tmrObject = {}
  local tmrName = nil

  for tmrNum = 0, 20 do                  -- Check all the possible timers
    tmrObject = model.getTimer(tmrNum)
    if tmrObject then                    -- If a timer exists add it to the table
      tmrName = tmrObject:name()         -- Get the timer name
      if tmrName == "" then tmrName = "Timer "..(tmrNum +1) end -- put a name on it if no exist
      tmrsTable = tableGrow(tmrsTable, {tmrName, tmrNum})       -- bulid the table
    else break      -- exit cycle when out of timers
    end
  end 
  return tmrsTable -- return the table
end

-- Takes in a timer name string, returns that timer number or the last open timer if not found.
local function tmrChecker(name)

  local count = 0
  local number = nil
  local tmrObject = {}

  for tmrNum = 0, 20 do                  -- Check all the possible timers
    tmrObject = model.getTimer(tmrNum)
    if tmrObject then                   -- If a timer exists count it and get its number
      number = tmrNum
      if tmrObject:name() == name then return tmrNum end  -- If its name is right return its number
      count = count + 1 
    else break            -- exit when out of timers
    end
  end 
  
  if count < 8 then return true  -- If the name is not found but there are empty spots to use
    else return false       -- If there are no timers available
  end
end
-- takes in timer in seconds and returns a MM:SS string or a H:mm:ss string
local function tmrStrg(value)
  
  local hour, minute, second, tmrStrg

  -- protect agianst nill
  if value == nil then
    tmrStrg = "-:-"
    return (tmrStrg)
    
  elseif value < 3600 then                            --for times less than 1 hour
  --Process the timer value from seconds integer
    hour = 0
    minute = math.floor(value /60)
    second	= math.floor(value - minute*60)
    
  --Process the timer value from seconds integer    
  else                                                --for times 1 hour or more 
    hour = math.floor(value /3600)
    minute = math.floor((value - hour*3600) /60)
    second =math.floor(value - hour*3600 - minute*60)
  end

-- Build the string numbers
    hour    = string.format("%.1d", hour)
    if value > 3600 then
    minute 	= string.format("%.2d", minute) 
    else
    minute 	= string.format("%.1d", minute)
    end
    second 	= string.format("%.2d", second)
  
  if value < 3600 then
    tmrStrg = minute ..":".. second
  else
    tmrStrg = hour ..":".. minute ..":".. second
  end
  return (tmrStrg)
end

-- takes in a table of values returns maximum value or nil for empty table
local function maxValue(table)

  --protect against nil
  if not table or #table == 0 then
    return nil -- Return nil for an empty or invalid table
  end
  
  --find the greatest value
  local greatest = table[1] -- Assume the first element is the greatest initially

  for i = 2, #table do
    if table[i] > greatest then -- do the comparisons
      greatest = table[i]
    end
  end
    return greatest
end

-- takes in a table of values returns minimum value or nil for empty table
local function minValue(table)
  
  --protect against nil
  if not table or #table == 0 then
    return nil -- Return nil for an empty or invalid table
  end
  
  --find the minimum value
  local minimum = table[1] -- Assume the first element is the minimum initially

  for i = 2, #table do              
    if table[i] < minimum then    --do the comparisons
      minimum = table[i]
    end
  end
    return minimum
end

-- takes in a table of integers returns average value or nil for empty table
local function avgValue(table)
  
  -- protect against nil
  if not table or #table == 0 then
    return nil -- Return nil for an empty or invalid table
  end

  --find the average value
  local avgValue = 0
  local sum = 0
  local count = 0 -- Keep track of the number of valid numeric values

  for index, value in ipairs(table) do
    if type(value) == "number" then
      sum = sum + value
      count = count + 1
    end
  end

  if count > 0 then
    avgValue = sum / count
    return avgValue
  else
    return nil -- Return nil if the table contains no numeric values
  end
end

-- takes in a table of integers returns sum of values or nil for empty table
local function sumValues(table)

  local sum = 0 
  
-- Return 0 for an empty or invalid table
  if not table or #table == 0 then
    return 0                          
  end
  
  for index, value in ipairs(table) do
    if type(value) == "number" then  -- add up all the number types
      sum = sum + value
    end
  end
    return sum      -- if there was something to add return the sum
end

-- create widget object runs first
local function create()
    
  	local fltTimer 	= {}
      fltTimer.nmbr = tmrChecker('Flight Time') -- check for flight timer source
      if type(fltTimer.nmbr) == 'number' 
        then fltTimer.src = model.getTimer(fltTimer.nmbr) --fill the source
      end	
  
      fltTimer.state = false          -- timer running bool
		  fltTimer.val		= 0						  -- actual value      
		  fltTimer.oldVal		= 0						-- last value
      fltTimer.times		= {}          -- old fligt times
      fltTimer.best		= 0             -- best flight time
      fltTimer.avg		= 0	            -- avg flight time

  	local wrkTimer = {}
      wrkTimer.nmbr = tmrChecker("Work Time")         -- check fo rwork timer
      if type(wrkTimer.nmbr) == 'number' then 
        wrkTimer.src = model.getTimer(wrkTimer.nmbr)	-- source Work Timer
      else 
        wrkTimer.src = nil                            -- no work timeer exists
      end      
       
		  wrkTimer.val		= 0						-- actual value       
      
  	local altitude 	= {}
      altitude.lnchMin = 20         -- launch value to record a flight (meters here)
		  altitude.src = system.getSource({category=CATEGORY_TELEMETRY_SENSOR, name="Altitude"})-- source altitude
		  altitude.val		= 0						-- actual value 
      altitude.lnch		= 0           -- Launch heght
      altitude.lnchDrp  = 0         -- launch drop
      altitude.max		= 0           -- fligt maximimum      
      altitude.maxT		= {}          -- old flight msximima
      altitude.lnchT		= {}        -- old Launch heghts
      altitude.lnchDrpT  = {}       -- old launch drops 
      altitude.lnchDrpAvg  = 0      -- launch drop average
      altitude.lnchDrpMin  = 0      -- launch drop minimum
      altitude.lnchAvg	= 0	        -- avg launch height
      altitude.lnchMax	= 0	        -- max launch height
      altitude.totMax	= 0	          -- max overall altitude      
      
    local fltMode = {}
      fltMode.src = system.getSource({category=CATEGORY_FLIGHT, member=FLIGHT_CURRENT_MODE}) -- source flight mode
      fltMode.name = nil            -- curent FM name
      fltMode.new = nil             -- current FM number
      fltMode.old = nil             -- last FM number
      fltMode.trig = 5              -- last FM before normal flight
      fltMode.launch = 4            -- launch flight mode

    local rxBatt = {}                       
      rxBatt.src = system.getSource({category=CATEGORY_TELEMETRY_SENSOR, name="RxBatt"})  --source reciever battery
      rxBatt.val = 0      --actual value
  
  --other non tabled variables
  local minCount, fltCount, wkupCycle, playMinute, firstPass, launch, flite, lnchTopTime =  0,0,0,1,true,false,false,nil 
  
	local widget = 
  { firstPass = firstPass, launch = launch, flite = flite, config = config,      --bools
    
    minCount = minCount,          -- # of minutes to make suere seconds are not played
    
    fltCount = fltCount,          -- # of flights
    
    wkupCycle = wkupCycle,        -- # of passes thru wakeup for timing
    
    playMinute = playMinute,       -- play or silent
    
    fltTimer = fltTimer,          -- timer items
    
    altitude = altitude,          -- altitude stuff
    
    fltMode = fltMode,            -- flight mode stuff
    
    wrkTimer = wrkTimer,            -- work time stuff
    
    rxBatt = rxBatt,              -- Rx battery stuff
    
    lnchTopTime = lnchTopTime,    -- launch top timer
    
    -- screen layout locations
    W = nil, H = nil, center = nil, W5 = nil,   --top bar locations
    tpBreak = nil, lftPanW = nil, lftPanC = nil, cntPanW = nil, cntPan4 = nil, rtPanC = nil, --main panels locations
    tpTitle = nil   --top of title bar
   }     
    return widget 
end

--read configuration settings - runs after create - replaces values if >= second opening of widget
local function read(widget)
    widget.fltTimer.nmbr = storage.read("fltTimer")
      widget.fltTimer.src = model.getTimer(widget.fltTimer.nmbr)
    widget.wrkTimer.nmbr = storage.read("wrkTimer")
      widget.wrkTimer.src = model.getTimer(widget.wrkTimer.nmbr)
    widget.altitude.src = storage.read("altimeter") 
    widget.fltMode.trig = storage.read("FMTrig")
    widget.fltMode.launch = storage.read("FMLaunch")
    widget.playMinute = storage.read("sound")             
    widget.altitude.lnchMin = storage.read("lnchMin")
end

--write configuration settings - Runs when config changes something or the model is closed
local function write(widget)
    storage.write("fltTimer", widget.fltTimer.nmbr)
    storage.write("wrkTimer", widget.wrkTimer.nmbr)
    storage.write("altimeter", widget.altitude.src) 
    storage.write("FMTrig", widget.fltMode.trig)
    storage.write("FMLaunch", widget.fltMode.launch)
    storage.write("sound", widget.playMinute)
    storage.write("lnchMin", widget.altitude.lnchMin)
end

-- Configure nice menue for config system - runs at useres request
local function configure(widget)
  local table = {}
  
  -- set flight timer field
  local line = form.addLine("Flight Timer Choice")
  
    table = tmrsTable()
    if #table == 0 then table = tableGrow(table, {'Please make a timer', 23}) end

  local myField = form.addChoiceField(line, nil, table, 
    
    function() return widget.fltTimer.nmbr end, --return current choice
    
    function(newValue) 
      widget.fltTimer.nmbr = newValue
      widget.fltTimer.src = model.getTimer(newValue)                -- set new choice
    end)		
  
  -- set work timer field
  line = form.addLine("Work Timer Choice")
  
    table = tmrsTable()
    
    table = tableGrow(table, {'Use sum of flight times', 22})
    if not tableCheck(table, 1, 'Work Time') then 
      table = tableGrow(table, {'Create "Work Time"', 23})
    end
    
  myField = form.addChoiceField(line, nil, table, 
    
    function() return widget.wrkTimer.nmbr end, -- return current choice
    
    function(newValue) 
      widget.wrkTimer.nmbr = newValue           -- set new value
      if widget.wrkTimer.nmbr == 22 or widget.wrkTimer.nmbr == 23 then 
        widget.wrkTimer.src = nil    -- lets sum of flight timers work
      else widget.wrkTimer.src = model.getTimer(widget.wrkTimer.nmbr) -- set new choice
      end      
    end)
  
    -- set launch flight mode
  line = form.addLine("Launch flight mode")

  form.addSourceField(line, nil, 
    
    function() return system.getSource({category = 24, member = widget.fltMode.launch}) end,  -- get current
    function(newValue) widget.fltMode.launch = newValue:member() end)                         -- set new source  
  
  -- set last flight mode before nomal flight
  line = form.addLine("Last flight mode before normal flight")

  form.addSourceField(line, nil, 
    
    function() return system.getSource({category = 24, member = widget.fltMode.trig}) end,  -- get current
    function(newValue) widget.fltMode.trig = newValue:member() end)                         -- set new source

  -- altimeter sensor  
  line = form.addLine("Altimeter Choice")

  form.addSourceField(line, nil, 
    
    function() return widget.altitude.src end,                -- get current source
    function(newValue) widget.altitude.src = newValue end)    -- set new source
  
  -- set launch height for good flight
  line = form.addLine("Minimum altitude for good launch") 
  
  myField = form.addNumberField(line, nil, 0, 200, 
    function() return widget.altitude.lnchMin end, 
    function(newValue) widget.altitude.lnchMin = newValue end)
  
      myField:suffix(" m")
      myField:default(0)
      myField:step(1)
  
  -- set play minutes during flight
  line = form.addLine("Play Minutes Choice")
  
    table = {{"Play", 1},{"Silent", 0}}
    
  myField = form.addChoiceField(line, nil, table, 
    
    function() return widget.playMinute end, -- return current choice
    function(newValue) 
      widget.playMinute = newValue           -- set new value      
    end)      
end
-- LCD painter Handles full width screens best in full very good in single window
local function paint(widget)
  
  local x,y,w,h,i,z,boHead,fgW,fgH
  
-- First loop  -- first pass fills screen location data to be used on subsequent invalidate calls --
	if widget.firstPass then
    
    --read window size
    widget.W, widget.H = lcd.getWindowSize()										
       
    -- Important width locations for text and top of title
    widget.center = widget.W / 2      --1/2 screen width
    widget.W5 = widget.W / 5          --1/5 screen width for main info
    widget.tpTitle = widget.H - 25    --toop of title bar

    -- Arbitray center panel breaks
    widget.tpBreak = 60                     --top of center panel
    widget.lftPanW = (widget.W /3) - 30    --left edge of center panel
    widget.cntPanW =  (widget.W /3) + 60    --width of center panel
    widget.cntPan4 = widget.cntPanW/4   -- Center panel 1/4 span    
    widget.lftPanC = widget.lftPanW/2      -- Left panel center    
    widget.rtPanC = (widget.W + widget.lftPanW + widget.cntPanW)/2   -- Right panel center
    
    widget.firstPass = false
  end    
    
		-- Background
		lcd.color(lcd.RGB(0,102,0))
		lcd.drawFilledRectangle(widget.lftPanW, widget.tpBreak, widget.cntPanW, widget.H)
    
    -- Window Main Info header bar
    boHead = 2               --set header y line value grows as layers are added       
    lcd.font(FONT_XXS)
    lcd.color(COLOR_WHITE)
    
    local headLable = {"flight Time","Launch Height","Launch Drop","Altitude","Max Altitude"} --labels
    x = widget.W5 /2                              --Text x start line
    
    for index, value in ipairs(headLable) do      -- print head labels
     lcd.drawText(x,boHead,value, CENTERED)
     x = x + widget.W5
    end
  
    w,h = lcd.getTextSize("0")  --move header y line                    
    boHead = boHead + h
    
    -- Window Main Info bar
    lcd.font(FONT_XXL)
    lcd.color(COLOR_WHITE)
    
    headLable = {tmrStrg(widget.fltTimer.val),    -- flight time
                  string.format("%.1f", widget.altitude.lnch).." m",     -- launch height
                  string.format("%.1f", widget.altitude.lnchDrp).." m",  -- launch drop
                  string.format("%.1f", widget.altitude.val).." m",      -- current altitude
                  string.format("%.1f", widget.altitude.max).." m"       -- maximum altitude
                }

    x = widget.W5 /2                                -- text x start line
    
    for index, value in ipairs(headLable) do        --print data    
     lcd.drawText(x,boHead,value, CENTERED)
     x = x + widget.W5
    end
    
    w,h = lcd.getTextSize("0")    -- final, actual bottom of header bar
    boHead = boHead + h + 5
    
    -- print the footer
    lcd.font(FONT_BOLD)
    lcd.color(COLOR_BLACK)
    lcd.drawText(widget.center, widget.tpTitle,"F3K Fluff", CENTERED)
    
    --center flight history
    lcd.font(FONT_XXS)
    lcd.color(COLOR_WHITE)

    headLable = {"Flt Time","Lnch Height","Lnch Drop","Max Alt"} --labels
    x = widget.lftPanW + widget.cntPan4/2              --Text x start line
    
    for index, value in ipairs(headLable) do      -- print head labels
     lcd.drawText(x,boHead,value, CENTERED)
     x = x + widget.cntPan4                            -- next column
    end

    w,h = lcd.getTextSize("0")    --set y start for historical data
    y = boHead + h
    
    lcd.font(FONT_L)              --get line height for historic data
    w,h = lcd.getTextSize("0")     
    
    local i = 0                                   -- set counter start (start of center lists)
    local indNum = #widget.fltTimer.times         -- set the starting index to show
    local indZ = indNum                           -- set rows of data availiable to be shown
    local scrnZ = math.floor((widget.tpTitle - y)/h)  -- set rows of data that the screen can take
    
    repeat
      i = i + 1
      
      if widget.altitude.lnchT[indNum] then
      headLable = {tmrStrg(widget.fltTimer.times[indNum]),  -- flight timer
                  string.format("%.1f", widget.altitude.lnchT[indNum]).." m",      -- launch altitude
                  string.format("%.1f", widget.altitude.lnchDrpT[indNum]).." m",   -- launch drop
                  string.format("%.1f", widget.altitude.maxT[indNum]).." m"        -- maximum altitude
                }
      else headLable = {tmrStrg(widget.fltTimer.times[indNum]), "----m", "----m", "----m"} -- deal with empty tables
      end
      
      x = widget.lftPanW + widget.cntPan4/2       -- Text x start 
    
      for index, value in ipairs(headLable) do    -- print row of values
       lcd.drawText(x,y,value, CENTERED)
       x = x + widget.cntPan4                     -- next column  
      end 
        y = y + h                                 -- next row  
        indNum = indNum - 1
    until (i == scrnZ or i == indZ)
    
    --left panel
    fgH = 20         --fudge height
    fgW = 0           --fudge width
    x,y =  widget.lftPanC + fgW ,boHead + fgH     --add fudge space for this column and row set
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Best Fligt Time",CENTERED)  -- label
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,tmrStrg(widget.fltTimer.best),CENTERED)  --best flight time
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Best Launch",CENTERED)
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,string.format("%.1f", widget.altitude.lnchMax).." m",CENTERED)  -- highest launch
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Least Drop",CENTERED)
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,string.format("%.1f", widget.altitude.lnchDrpMin).." m",CENTERED)  --minimu launch drop
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    
    if widget.H > (y + h) then     --full screen only
      lcd.font(FONT_XXS)
      lcd.drawText(x,y,"Best Altitude",CENTERED)
      w,h = lcd.getTextSize("0")
      y = y + h
      lcd.font(FONT_XL)
      lcd.drawText(x,y,string.format("%.1f", widget.altitude.totMax).." m",CENTERED)  -- maximum altitude for session
      w,h = lcd.getTextSize("0")   
      
      y = y + h + fgH                  --next item location
      lcd.font(FONT_XXS)
      lcd.drawText(x,y,"Work Time",CENTERED)
      w,h = lcd.getTextSize("0")
      y = y + h
      lcd.font(FONT_XXL)
      lcd.drawText(x,y,tmrStrg(widget.wrkTimer.val),CENTERED)  --work time
    end
    
   --Right Panel 
    fgH = 20
    fgW = 0
    x,y =  widget.rtPanC + fgW ,boHead + fgH --add fudge space for this column and row set
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Avg Fligt Time",CENTERED)
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,tmrStrg(widget.fltTimer.avg),CENTERED)  --average flight time
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Avg Launch",CENTERED)
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,string.format("%.1f", widget.altitude.lnchAvg).." m",CENTERED)  --average launch height
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    lcd.font(FONT_XXS)
    lcd.drawText(x,y,"Avg Drop",CENTERED)
    w,h = lcd.getTextSize("0")
    y = y + h
    lcd.font(FONT_XL)
    lcd.drawText(x,y,string.format("%.1f", widget.altitude.lnchDrpAvg).." m",CENTERED)  --average launch drop
    w,h = lcd.getTextSize("0")
    
    y = y + h + fgH                  --next item location
    
    if widget.H > (y + h) then        -- only for full screen
            lcd.font(FONT_XXS)
      lcd.drawText(x,y,"Flight Mode",CENTERED)
      w,h = lcd.getTextSize("0")
      y = y + h
      lcd.font(FONT_XL)
      lcd.drawText(x,y,widget.fltMode.name,CENTERED)  --current flightmode
      w,h = lcd.getTextSize("0")   
      
      y = y + h + fgH                  --next item location
            lcd.font(FONT_XXS)
      lcd.drawText(x,y,"Rx Battery",CENTERED)
      w,h = lcd.getTextSize("0")
      y = y + h
      lcd.font(FONT_XXL)
      lcd.drawText(x,y,widget.rxBatt.val.." v",CENTERED)  --Rx battery level
    end
end

--menu  
 
--event handles key and screen hits
local function event(widget, category) 
  
	if category == EVT_TOUCH then
    lcd.invalidate()                 -- for screen bump on real radio
		return true
	end
end

--main loop runs after read and then every few  
local function wakeup(widget)

  -- Build a work timer if chosen in the 'configure' screen
    if lcd.isVisible() and widget.wrkTimer.nmbr == 23 then --seems to stop problems with bulding the timer in configure()
        widget.wrkTimer.src = model.createTimer():name("Work Time")		-- create Work Timer and name it
        widget.wrkTimer.nmbr = tmrChecker('Work Time')                -- get the number
        widget.wrkTimer.src = model.getTimer(widget.wrkTimer.nmbr)    -- use getTimer() for source definition
        widget.wrkTimer.src:startCondition(system.getSource({category=CATEGORY_TELEMETRY_SENSOR, name="RSSI"})) --set trigger
    end
   
  -- fill new data
  widget.rxBatt.val = widget.rxBatt.src:value()                --RX battery level  
    if widget.rxBatt.val == nil then widget.rxBatt.val = 0 end
  
  widget.fltMode.name = widget.fltMode.src:stringValue()                --flight modes by name  
    if widget.fltMode.name == nil then widget.fltMode.name = "nil" end
    
  widget.fltMode.new = widget.fltMode.src:value()                       --flight mode number
    if widget.fltMode.new == nil then widget.fltMode.new = "nil" end    
    
  if widget.fltTimer.src then widget.fltTimer.val = widget.fltTimer.src:value() end   --flite timer
    if widget.fltTimer.val == nil then widget.fltTimer.val = 0 end 
    
  if widget.fltTimer.src then widget.fltTimer.state = widget.fltTimer.src:startCondition():state() end --flite timer running boolean
    
  widget.altitude.val = widget.altitude.src:value()                     --altitude
    if widget.altitude.val == nil then widget.altitude.val = 0 end  
    
  widget.altitude.max = widget.altitude.src:value({options=OPTION_SENSOR_MAX})    --max altitude
    if widget.altitude.max == nil then widget.altitude.max = 0 end 
    
  if widget.wrkTimer.src then     --work timer
    widget.wrkTimer.val = widget.wrkTimer.src:value() -- dedicated workitmer
  elseif widget.fltTimer.state then                   -- provide sum of flight times
    widget.wrkTimer.val = sumValues(widget.fltTimer.times) + widget.fltTimer.val  -- sum of flight time + active flt timer
  else widget.wrkTimer.val = sumValues(widget.fltTimer.times)                     -- sum of flight times
  end
    
  -- Start work time coming soon --
       
  -- Start or end flight, fill tables  
  if ((widget.fltMode.old == widget.fltMode.launch and 
      widget.fltMode.new ~= widget.fltMode.launch) or not 
      widget.fltTimer.state) and widget.flite then   
 
    widget.flite = false    --end flight status
    
   -- flight time table fill
    widget.fltTimer.times = tableGrow(widget.fltTimer.times, widget.fltTimer.oldVal) 
   -- launch height table fill
    widget.altitude.lnchT = tableGrow(widget.altitude.lnchT, widget.altitude.lnch)
   -- launch drop table fill
    widget.altitude.lnchDrpT = tableGrow(widget.altitude.lnchDrpT, widget.altitude.lnchDrp)
   -- max altitude table fill
    widget.altitude.maxT = tableGrow(widget.altitude.maxT, widget.altitude.max)
    
      --process the tables--
    
    widget.fltTimer.best = maxValue(widget.fltTimer.times)  -- best flight

    widget.fltTimer.avg = avgValue(widget.fltTimer.times)   -- average flight
    
    widget.altitude.lnchMax = maxValue(widget.altitude.lnchT)   -- Highest launch
    
    widget.altitude.lnchAvg = avgValue(widget.altitude.lnchT)  -- average launch
      
    widget.altitude.lnchDrpAvg = avgValue(widget.altitude.lnchDrpT)   -- average launch drop
    
    widget.altitude.lnchDrpMin = minValue(widget.altitude.lnchDrpT)   -- minimum launch drop
    
    widget.altitude.totMax = maxValue(widget.altitude.maxT)   -- Highest flight altitude

  end  
    
  -- is it really a launch        
  if (widget.fltMode.old == widget.fltMode.trig and   -- real radio
      widget.fltMode.new ~= widget.fltMode.trig and 
      widget.altitude.val > widget.altitude.lnchMin) 
  then 
--  if widget.fltMode.old == widget.fltMode.trig and widget.fltode.new ~= widget.fltMode.trig then --sim line    
    widget.launch = true  
    widget.minCount = 0
    widget.lnchTopTime = os.clock()
  end
  
  -- get launch height and drop
    if widget.launch and (os.clock() - widget.lnchTopTime) >= 3 then --real radio
--  if widget.launch then                                            --sim line   
    widget.launch = false
    widget.flite = true
    widget.altitude.lnch = widget.altitude.max 
    widget.altitude.lnchDrp = widget.altitude.max - widget.altitude.val     
  end   
  
  -- play the minutes of the flight tme duration. 
  if widget.playMinute == 1 then            -- the on off switch for this sound
    if widget.fltTimer.val > (widget.minCount* 60) and (widget.fltTimer.val % 60) >= 59 then --play at 59 seconds 
      widget.minCount = widget.minCount + 1             -- avoid playing seconds
      system.playNumber(widget.minCount, UNIT_MINUTE)
    end
  end
    
    -- call the painter once in a while 
  if lcd.isVisible() then       -- turn on the screen refreshes 
      widget.wkupCycle = widget.wkupCycle + 1
      
    if widget.wkupCycle / 20 == 1 then    -- about 50cycle/second
      widget.wkupCycle = 0
      
      lcd.invalidate()
      --lcd.invalidate(invRect)  --coming soon
    end
  else 
    widget.firstPass = true     -- prepare for something major to have changed
	end
  
  -- Fill the old slots
  widget.fltTimer.oldVal = widget.fltTimer.val 
  widget.fltMode.old = widget.fltMode.new

end

-- this is where we set up what components the widget uses
local function init()	
	
	local key = "PB01"			  -- unique key - keep it less that 8 chars
	local name = "F3K Fluff"	-- name of widget

    system.registerWidget(
        {
            key = key,					  -- unique project id
            name = name,				  -- name of widget
            create = create,			-- function called when creating widget
            configure = configure,		-- function called when configuring the widget (use ethos forms)
            paint = paint,				-- function called when lcd.invalidate() is called
            wakeup = wakeup,			-- function called as the main loop
            read = read,				  -- function called when starting widget and reading configuration params
            write = write,				-- function called when saving values / changing values in the configuration menu
            event = event,				-- function called when buttons or screen clips occur
--			menu = menu,				   -- function called to add items to the menu
            persistent = false,		-- true or false to make the widget carry values between sessions and models (not safe imho)
        }
    )

end

return {init = init}

--    cd C:\Program Files (x86)\FrSky\Ethos\X20S  
