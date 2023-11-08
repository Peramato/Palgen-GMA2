-- Plugin by LUISMA PERAMATO
-- Plugin name: PALGEN
-- GrandMA2
-- Create random colors to some fixture groups
-- with various selectables kinds of color armony
-- Version 1.0
-- File: Palgen_gam2_v1.lua

---------------------------------------------------------------------------

-- PLUGIN OPTIONS:

-- nil --> Create Macros
-- Generate --> Generate palette
-- SetupAll --> Setup all variables
-- PalMode --> Setup only mode options
-- PalGroups --> Setup groups variables
-- PalColor --> Setup all color variables
-- PalHUE --> Setup only HUE
-- PalMacro --> Generate Macro
-- MenuGen --> Genera menu

-------------------------------------------------------------------------

local function selection(UserSelection)
-- local UserSelection = gma.show.getvar('userselection') -- Variable HUE
    
    -- Init
    if (UserSelection == nil)
    then
    gma.feedback("No option selected")
    gma.feedback("Initialize plugin")
    genpluginmacros()
    return
    end
    
    -- Generate menu executor
    if (UserSelection == "MenuGen")
    then
    gma.feedback("Generate executor menu")
    createexec()
    return
    end

    
    -- Generate palette
    if (UserSelection == "Generate")
    then
    gma.feedback("Generate palette")
    generatepalette()
    return
    end

    -- Group selection
    
    if (UserSelection == "PalGroups")
    then
    gma.feedback("Setup groups")
    askforgroupini()
    askforgroupend()
    askformovegroups()
    end
    
    -- ALL selection
    if (UserSelection == "SetupAll")
    then
    gma.feedback('Setup ALL')
    askforgroupini()
    askforgroupend()
    askforhue ()
    askforrndhue ()
    askforsat ()
    askforrndsat()
    askformode()
    askformovegroups()
    end

    -- Only mode
    if (UserSelection == "PalMode")
    then
    gma.feedback('Setup Mode')
    askformode()
    end
    
    -- Only color parameters
    if (UserSelection == "PalColor")
    then
    gma.feedback('Setup Color')
    askforhue ()
    askforrndhue ()
    askforsat ()
    askforrndsat()
    end
    
    -- Only HUE
    if (UserSelection == "PalHUE")
    then
    gma.feedback('Select HUE')
    askforhue ()
    end

    -- Generate Macro
    if (UserSelection == "PalMacro")
    then
    gma.feedback("Creating macro...")
    CreateMacro(GetMacroNum())
    end
    
        
gma.feedback('Selection: ' .. UserSelection)

end

local function askforgroupini()
-- Ask for inital group

InputIni = tonumber(gma.textinput ("Insert first group", "Only values between 1 and 997"))

    if (InputIni == nil or InputIni < 1)
    then
    InputIni = 101 -- Default initial group
    gma.feedback('ERROR number must be between 1 and 997')
    gma.show.setvar('PalGroupIni', InputIni) 
    end
    
    if (InputIni > 997)
    then
    InputIni = 101 -- Default initial group
    gma.feedback('ERROR number must be between 1 and 997. Set as ' .. InputIni)
    gma.show.setvar('PalGroupIni', InputIni) 
    else
    gma.show.setvar('PalGroupIni', InputIni)
    end

end

local function askforgroupend()
-- Ask for inital group

local InputEnd = tonumber(gma.textinput ("Insert last group", "Only values between 4 and 1000"))
    
    
    if (InputEnd == nil or InputEnd < 4)
    then
    InputEnd = 109 -- Default initial group
    gma.feedback('ERROR number must be between 1 and 997. Set as ' .. InputEnd)
    gma.show.setvar('PalGroupEnd', InputEnd) 
    end
    
    if ((InputEnd - InputIni) < 4)
    then
    InputEnd = InputIni + 4
    end
    
    if (InputEnd > 1000)
    then
    gma.feedback('ERROR number must be between 1 and 997. Set as ' .. InputEnd)
    gma.show.setvar('PalGroupEnd', InputEnd) -- Default initial group
    else
    gma.show.setvar('PalGroupEnd', InputEnd)
    end

end

local function askforhue()
-- Ask for HUE

local InputHue = tonumber(gma.textinput ("Insert HUE", "Only values between 0 and 360"))

    if (InputHue == nil)
    then
    InputHue = 0 -- Default
    gma.feedback('ERROR Value must be between 0 and 360. Set as ' .. InputHue)
    gma.show.setvar('PalSelectHue', InputHue)
    
    else
    gma.show.setvar('PalSelectHue', InputHue)
    end

end

local function askforrndhue()

-- Ask for Random Size HUE
local InputRandomHue = tonumber(gma.textinput ("Insert Random HUE Size", "Only numbers"))

    if (InputRandomHue == nil)
    then
    InputRandomHue = 60     -- Default value
    gma.feedback('ERROR value must be a number. Set as ' .. InputRandomHue)
    gma.show.setvar('PalRandHueSize', InputRandomHue)
    
    else
    gma.show.setvar('PalRandHueSize', InputRandomHue)
    end

end

local function askforsat()

-- Ask for Random Size HUE
local InputSat = tonumber(gma.textinput ("Insert Saturation value", "Only values between 0 and 100"))

    if (InputSat == nil)
    then
    InputSat = 100  -- Default
    gma.feedback('ERROR value must be a number. Set as ' .. InputSat)
    gma.show.setvar('PalSelectSat', InputSat)
    end
    
    if (InputSat < 0)
    then
    gma.show.setvar('PalSelectSat', 0)
    end
    
    if (InputSat > 100)
    then
    gma.show.setvar('PalSelectSat', 100)
    else
    gma.show.setvar('PalSelectSat', InputSat)
    end
    
end

local function askforrndsat()

-- Ask for Random Size Saturation
local InputRandomSat = tonumber(gma.textinput ("Insert Random Saturation Size", "Only numbers"))

    if (InputRandomSat == nil)
    then
    InputRandomSat = 60     -- Default value
    gma.feedback('ERROR value must be a number. Set as ' .. InputRandomSat)
    gma.show.setvar('PalRandSatSize', InputRandomSat)
    
    else
    gma.show.setvar('PalRandSatSize', InputRandomSat)
    end

end

local function clearcmdscreen()
-- Clear grandma cmd Screen
    for i = 1, 20, 1
    do
        gma.feedback("")
    end
end

local function askformode()
-- Ask for kind of palette
gma.cmd('Menu On "CommandlineResponse"')

clearcmdscreen()

gma.feedback("***********************************************************************")
gma.feedback("***********************************************************************")
gma.feedback(" 1. Analogous")
gma.feedback(" 2. Monochromatic")
gma.feedback(" 3. Tone")
gma.feedback(" 4. Complementary")
gma.feedback(" 5. Triad")
gma.feedback(" 6. Square")
gma.feedback(" 7. Split Complementary")
gma.feedback(" 8. Compound")
gma.feedback("***********************************************************************")
gma.feedback("***********************************************************************")

clearcmdscreen()
local InputPaletteMode = gma.textinput("Select mode", "Numbers 1 thru 8")
gma.cmd('Menu Off "CommandlineResponse"')

-- Assign values
    InputPaletteMode = tonumber(InputPaletteMode)
    
    if (InputPaletteMode == nil or InputPaletteMode < 1 or InputPaletteMode > 8 )
    then
    InputPaletteMode = 1
    end

    gma.show.setvar('PalPaletteMode', InputPaletteMode)
    

end

local function askformovegroups()
-- Ask for move groups
    local InputMoveGroups = gma.textinput("Move groups?", "0 No // 1 Yes")
    
    if (InputMoveGroups == "1")
    then
        gma.show.setvar('PalMoveGroups','true')
    else
        gma.show.setvar('PalMoveGroups','false')
    end
end

local function generatepalette()

 -- Main local function
    gma.feedback("************************ Start Generate Palette ****************************")
    
    -- Get all the necesary show variables and import to lua variables

    -- Try to get preference variables values else apply defaut
    PaletteMode = gma.show.getvar( "PalPaletteMode")
    PaletteMode = tonumber(PaletteMode)
    if PaletteMode == nil then
        PaletteMode = 1
    end    


    -- Try to get HUE variables values else apply defaut
    SelectHue = gma.show.getvar("PalSelectHue")    
    SelectHue = tonumber(SelectHue)
    if SelectHue == nil then
        SelectHue = 0
    end    

    
    RandHueSize = gma.show.getvar("PalRandHueSize")   
    RandHueSize = tonumber(RandHueSize)    
    if RandHueSize == nil then
        RandHueSize = 0
    end    

      
    -- Try to get saturation variables values else apply defaut
    SelectSat = gma.show.getvar("PalSelectSat")    
    SelectSat = tonumber(SelectSat)
    if SelectSat == nil then
        SelectSat = 100
    end    

    
    RandSatSize = gma.show.getvar( "PalRandSatSize")   
    RandSatSize = tonumber(RandSatSize)    
    if RandSatSize == nil then
        RandSatSize = 0
    end    


    -- Try to get group variable values else aply defaut
    GroupIni = gma.show.getvar( "PalGroupIni")    
    GroupIni = tonumber(GroupIni)   
    if GroupIni == nil then
        GroupIni = 101
    end    
 
    
    GroupEnd = gma.show.getvar( "PalGroupEnd")   
    GroupEnd = tonumber(GroupEnd)    
    if GroupEnd == nil then
        GroupEnd = 109
    end    

    
    -- Try to get variable for change groups position
    local MoveGroups = gma.show.getvar( "PalMoveGroups")    
    if MoveGroups == nil
    then
    MoveGroups = false
        else if MoveGroups == "false"
        then
        MoveGroups = false
            else
            MoveGroups = true
        end
    end
    
    -- Check values and convert to RGB
    checkhsb (SelectHue, SelectSat)
    
    -- Magic starts here...
    sendvalues ()
    
    -- Invierte groups
    if MoveGroups == true
    then
        movegroups ()
    end
    
    -- Clear group selection
    gma.cmd("ClearSelection")

end

local function checkhsb (SHue, SSat)
-- Check if values are OK
    
    -- Check HUE    
    -- Convert to positive
    if (SHue < 0 and SHue >= -360)
    then
    SHue = (SHue + 360)
    end
    
    if (SHue < -360)
    then
    SHue = ((SHue % 360) * -1)
    end
    
    -- Check if its bigger than 360
    if (SHue > 360)
    then
    SHue = (SHue % 360)
    end

    converthuetorgb(SHue)
    gma.feedback("Only HUE without saturation: ")
    gma.feedback("Red: " .. Red .. "  Green: " .. Green .. "  Blue: " .. Blue)
    
    Red = aplisat(Red,SSat) -- Aply saturation to Red
    Green = aplisat(Green,SSat) -- Aply saturation to Green
    Blue = aplisat(Blue,SSat) -- Aply saturation to Blue
    
    gma.feedback("With saturation applied:")
    gma.feedback("Red: " .. Red .. "  Green: " .. Green .. "  Blue: " .. Blue)

end

local function converthuetorgb(SHue)
--- Convert to RGB
    Red = convertredhue (SHue)
    Green = convertgreenhue (SHue)
    Blue = convertbluehue (SHue)
    
end

local function convertredhue (SHue)
-- Generate Red value
    if (SHue >= 0 and SHue <=60)
    then
    return 100    
        else if (SHue >= 300 and SHue <= 360)
        then
        return 100
            else if (SHue >= 120 and SHue <= 240)
            then
            return 0
                else if (SHue > 60 and SHue < 120)
                then
                    return normalize100 (SHue, 60, 120)
                    else
                        return normalize100 (SHue, 300, 240)
                    end    
                end
            end
        end    
end

local function convertgreenhue (SHue)
-- Generate green value
    if (SHue >= 60 and SHue <=180)
    then
    return 100    
        else if (SHue >= 240 and SHue <= 360)
        then
        return 0
            else if (SHue >= 0 and SHue < 60)
            then
                return normalize100 (SHue, 60, 0)
                else
                    return normalize100 (SHue, 180, 240)
                end    
            end
    end    
end

local function convertbluehue (SHue)
-- Generate blue value
    if (SHue >= 180 and SHue <=300)
    then
    return 100    
        else if (SHue >= 0 and SHue <= 120)
        then
        return 0
            else if (SHue > 120 and SHue < 180)
            then
                return normalize100 (SHue, 180, 120)
                else
                    return normalize100 (SHue, 300, 360)
                end    
            end
    end    
end

local function normalize100 (SHue, Max, Min)
-- Scale values betwen 0 and 100
ValueSHue = 100*(SHue - Min)/(Max - Min)
return ValueSHue
end

local function aplisat (Color, SSat)
-- Aply saturation
    
    local ColSat = Color
    local Factor = 100 - SSat    
    
    if (Color == 100)
    then
    ColSat = Color
        else if (ColSat == 0)
        then
        ColSat = Color + Factor
            else
            local proportional = Factor * (100 - Color)/100
            ColSat = Color + proportional
        end
    end    

    return ColSat
    
end

local function sendvalues()

gma.feedback("Sending vaules... ")
gma.feedback("PaletteMode: " .. PaletteMode)

    colorize (GroupIni, Red, Green, Blue) -- El primer grupo al color seleccionado
    
    -- Only one group Analogous
    if (PaletteMode == 1)
    then    
        gma.feedback("1 Group - Analogous")
        for g = (GroupIni + 1), GroupEnd, 1
        do  
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)    
            colorize (g, Red, Green, Blue)             
        end    
    end
    
    -- Only one group Monochromatic
    if (PaletteMode == 2)
    then    
        gma.feedback("1 Group - Monochromatic")
        for g = (GroupIni + 1), GroupEnd, 1
        do  
            local NewSat = randomsat(SelectSat)
            checkhsb (SelectHue, NewSat)    
            colorize (g, Red, Green, Blue)             
        end    
    end
    
    -- Only one group Tone
    if (PaletteMode == 3)
    then    
        gma.feedback("1 Group - Tone")
        for g = (GroupIni + 1), GroupEnd, 1
        do  
            local NewHue = randomhue(SelectHue)
            checkhsb (NewHue, SelectSat)    
            colorize (g, Red, Green, Blue)             
        end    
    end
    
    
    -- Two Groups - Complementary
    if (PaletteMode == 4)
    then
    gma.feedback("2 Group - Complementary ")
    local Resto = math.floor((GroupEnd - GroupIni + 1) % 2)
    local Half = math.floor((GroupEnd - GroupIni + 1) / 2)
    
        for g = (GroupIni + 1), (GroupIni + Half + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end
        
        for g = (GroupEnd - Half), (GroupEnd), 1
        do
            local NewHue = randomhue(SelectHue + 180)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end        
    end
    
    
    
    -- Three Groups - Triad
    if (PaletteMode == 5)
    then
    local Resto = math.floor((GroupEnd - GroupIni + 1) % 3)    
    local Part = math.floor((GroupEnd - GroupIni + 1) / 3)
    
        for g = (GroupIni + 1), (GroupIni + Part + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end
        
        for g = (GroupIni + Part + Resto), (GroupEnd - Part), 1
        do
            local NewHue = randomhue(SelectHue + 120)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g = (GroupEnd - Part + 1), (GroupEnd), 1
        do
            local NewHue = randomhue(SelectHue - 120)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end                
    end
    
    -- Four Groups - Square
    if (PaletteMode == 6)
    then
    local Resto = math.floor((GroupEnd - GroupIni + 1) % 4)
    local Part = math.floor((GroupEnd - GroupIni + 1) / 4)
    
        for g = (GroupIni + 1), (GroupIni + Part + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end
        
        for g = (GroupIni + Part + Resto), (GroupIni + (2*Part) + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue + 90)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g = (GroupIni + (2*Part) + Resto), (GroupEnd - Part), 1
        do
            local NewHue = randomhue(SelectHue + 180)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g =  (GroupEnd - Part + 1), GroupEnd , 1
        do
            local NewHue = randomhue(SelectHue + 270)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end                
    end
    
    -- Three Groups - Split Complementary
    if (PaletteMode == 7)
    then
    local Resto = math.floor((GroupEnd - GroupIni + 1) % 3)
    gma.feedback("Resto: " .. Resto)
    local Part = math.floor((GroupEnd - GroupIni + 1) / 3)
    gma.feedback("Part: " .. Part)
    
        for g = (GroupIni + 1), (GroupIni + Part + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end
        
        for g = (GroupIni + Part + Resto), (GroupEnd - Part), 1
        do
            local NewHue = randomhue(SelectHue + 155)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g = (GroupEnd - Part + 1), (GroupEnd), 1
        do
            local NewHue = randomhue(SelectHue - 155)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end                
    end

    -- Four Groups - Compound
    if (PaletteMode == 8)
    then
    local Resto = math.floor((GroupEnd - GroupIni + 1) % 4)
    local Part = math.floor((GroupEnd - GroupIni + 1) / 4)
    
        for g = (GroupIni + 1), (GroupIni + Part + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end
        
        for g = (GroupIni + Part + Resto), (GroupIni + (2*Part) + Resto - 1), 1
        do
            local NewHue = randomhue(SelectHue - 30)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g = (GroupIni + (2*Part) + Resto), (GroupEnd - Part), 1
        do
            local NewHue = randomhue(SelectHue + 190)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end

        for g =  (GroupEnd - Part + 1), GroupEnd , 1
        do
            local NewHue = randomhue(SelectHue + 210)
            local NewSat = randomsat(SelectSat)
            checkhsb (NewHue, NewSat)
            colorize (g, Red, Green, Blue)
        end                
    end
end

local function colorize (group, R, G, B)

callgroup(group)
gma.cmd('Attribute "COLORRGB1" at ' .. R)
gma.cmd('Attribute "COLORRGB2" at ' .. G)
gma.cmd('Attribute "COLORRGB3" at ' .. B)
-- gma.cmd('Clear Selection')

end

local function callgroup (group)
gma.cmd('Clear Selection')
gma.cmd('Group ' .. group)
end

local function randomhue  (SHue)
-- Return a new random Hue value

    if (RandHueSize == 0)
    then
    gma.feedback('HUE fixed:' .. SelectHue)
    RandomSHue = SHue
    else
    RandomSHue = math.random(SHue - RandHueSize, SHue + RandHueSize)
    end

return RandomSHue

end

local function randomsat(SSat)

    if (RandSatSiz == 0)
    then 
    gma.feedback('Saturation fixed')
    RandomSSat = SSat
    else
    RandomSSat = math.random(SSat - RandSatSize, SSat + RandSatSize)
    end

if (RandomSSat > 100)
then
RandomSSat = 100
end

if (RandomSSat < 0)
then
RandomSSat = 0
end

return RandomSSat

end

local function movegroups()
    gma.cmd("Move group " .. GroupIni .. " at group " .. "9999") 
    local finalgroup = GroupEnd
    local Half = GroupIni + ( math.floor((GroupEnd - GroupIni + 1) / 2))
    for g = GroupIni, (GroupEnd-1), 1
    do    
     --   gma.cmd("Move group " .. g .. "at group " .. "9999")
        gma.cmd("Move group " .. (g + 1) .. " at group " .. g)
    --    finalgroup = (finalgroup - 1)    
    end
    gma.cmd("Move group " .. "9999" .. " at group " .. GroupEnd) 
end

local function main(UserSelection)

selection(UserSelection)

end

local function GetMacroNum()
    local macroNum = gma.textinput("Set Macro Number", "Insert a valid number")
    return macroNum
end

local function GetMacroLabel(PaletteMode, SSat, SHue)
    -- Generate Label
    local MacroLabel = "PALETTE"
    
    -- Kind
    if PaletteMode == 1
    then
    MacroLabel = "ANALOG"
    end
    
    if PaletteMode == 2
    then
    MacroLabel = "MONOCHROM"
    end
    
    if PaletteMode == 3
    then
    MacroLabel = "TONE"
    end
    
    if PaletteMode == 4
    then
    MacroLabel = "COMPLEMENT"
    end
    
    if PaletteMode == 5
    then
    MacroLabel = "TRIAD"
    end
    
    if PaletteMode == 6
    then
    MacroLabel = "QUAD"
    end

    if PaletteMode == 7
    then
    MacroLabel = "SPLIT"
    end
    
    if PaletteMode == 8
    then
    MacroLabel = "COMP"
    end
    
    
    -- Saturation
    if (SSat <= 50)
    then
    MacroLabel = MacroLabel .. " LIGHT"
    end
    
    
    -- Color
    if (SHue >= 15 and SHue < 45)
    then
    MacroLabel = MacroLabel .. " ORANGE"
        else if (SHue >= 45 and SHue < 75)
        then
        MacroLabel = MacroLabel .. " YELLOW"
            else if (SHue >= 75 and SHue < 105)
            then
            MacroLabel = MacroLabel .. " FERN GREEN"
                else if (SHue >= 105 and SHue < 135)
                then
                MacroLabel = MacroLabel .. " GREEN"
                    else if (SHue >= 135 and SHue < 165)
                    then
                    MacroLabel = MacroLabel .. " SEA GREEN"
                        else if (SHue >= 165 and SHue < 195)
                        then
                        MacroLabel = MacroLabel .. " CYAN"
                            else if (SHue >= 195 and SHue < 225)
                            then
                            MacroLabel = MacroLabel .. " BLUE"
                                else if (SHue >= 225 and SHue < 255)
                                then
                                MacroLabel = MacroLabel .. " DARK BLUE"
                                    else if (SHue >= 255 and SHue < 285)
                                    then
                                    MacroLabel = MacroLabel .. " PURPLE"
                                        else if (SHue >= 285 and SHue < 315)
                                        then
                                        MacroLabel = MacroLabel .. " MAGENTA"
                                            else if (SHue >= 315 and SHue < 345)
                                            then
                                            MacroLabel = MacroLabel .. " PINK"
                                                else
                                                MacroLabel = MacroLabel .. " RED"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

    end
    
    -- Add groups number to label

    MacroLabel = MacroLabel .. " (" .. GroupIni .. " - " .. GroupEnd .. ")"
    
    
    -- Move groups
    if MoveGroups == true
    then
    MacroLabel = MacroLabel .. " RND"
    end
    
    return MacroLabel
end

local function CreateMacro(macroId)
    gma.feedback("Creando Macro: " .. macroId)
    
    -- Create Macro
    gma.cmd('Store Macro 1.' .. macroId)
    gma.sleep(0.02)

    
    -- Create Macro Lines
    for i = 1, 8, 1
    do
    gma.cmd('Store Macro 1.' .. macroId .. "." .. i)
    gma.sleep(0.02)
    end
    
    -- Move groups
    local MoveGroups = gma.show.getvar('PalMoveGroups')
    if MoveGroups == nil
    then
    MoveGroups = false
        else if MoveGroups == "false"
        then
        MoveGroups = false
            else
            MoveGroups = true
        end
    end    
    gma.cmd('Assign Macro 1.' .. macroId .. ".1" .. "/cmd=\"SetVar $PalMoveGroups = " .. tostring(MoveGroups) .. "\"")
    
    -- Kind
    local PaletteMode = gma.show.getvar('PalPaletteMode')
    if PaletteMode == nil then
        PaletteMode = 1
    end  
    PaletteMode = tonumber(PaletteMode)
    gma.cmd('Assign Macro 1.' .. macroId .. ".2" .. "/cmd=\"SetVar $PalPaletteMode = " .. PaletteMode .. "\"")
    
    -- Hue
    local SelectHue = gma.show.getvar('PalSelectHue')
    if SelectHue == nil then
        SelectHue = 0
    end    
    SelectHue = tonumber(SelectHue)
    gma.cmd('Assign Macro 1.' .. macroId .. ".3" .. "/cmd=\"SetVar $PalSelectHue = " .. SelectHue .. "\"")
    
    -- Saturation
    local SelectSat = gma.show.getvar('PalSelectSat')
    if SelectSat == nil then
        SelectSat = 100
    end    
    SelectSat = tonumber(SelectSat)
    gma.cmd('Assign Macro 1.' .. macroId .. ".4" .. "/cmd=\"SetVar $PalSelectSat = " .. SelectSat .. "\"")
        
    -- Random Hue
    local RandHueSize = gma.show.getvar('PalRandHueSize')
    if RandHueSize == nil then
        RandHueSize = 0
    end
    RandHueSize = tonumber(RandHueSize)
    gma.cmd('Assign Macro 1.' .. macroId .. ".5" .. "/cmd=\"SetVar $PalRandHueSize = " .. RandHueSize .. "\"")
    
    -- Random Saturation
    local RandSatSize = gma.show.getvar('PalRandSatSize')
    if RandSatSize == nil then
        RandSatSize = 0
    end    
    RandSatSize = tonumber(RandSatSize)
    gma.cmd('Assign Macro 1.' .. macroId .. ".6" .. "/cmd=\"SetVar $PalRandSatSize = " .. RandSatSize .. "\"")
    
    -- Initial group
    local GroupIni = gma.show.getvar('PalGroupIni')
    if GroupIni == nil then
        GroupIni = 101
    end    
    GroupIni = tonumber(GroupIni)
    gma.cmd('Assign Macro 1.' .. macroId .. ".7" .. "/cmd=\"SetVar $PalGroupIni = " .. GroupIni .. "\"")
    
    -- Final group
    local GroupEnd = gma.show.getvar('PalGroupEnd')
    if GroupEnd == nil then
        GroupEnd = 109
    end    
    GroupEnd = tonumber(GroupEnd)
    gma.cmd('Assign Macro 1.' .. macroId .. ".8" .. "/cmd=\"SetVar $PalGroupEnd = " .. GroupEnd .. "\"")
    

        
    -- label Macro
    gma.cmd('Label Macro 1.' .. macroId  .. ' \"' .. GetMacroLabel(PaletteMode, SelectSat, SelectHue) .. '" ')
    
    -- Colorize Macro
    
    checkhsb(SelectHue, SelectSat)
    
    

    gma.cmd('Appearance Macro 1.' .. macroId .. ' /r=' .. Red .. ' /g=' .. Green .. ' /b=' .. Blue .. '')

    
end

local function createexec()
-- Create menu for palette plugin
    -- Select executor
    local Menuexec = tonumber(gma.textinput("Menu executor number", "Select an empty exector number"))
    
    -- Create exec
    gma.cmd('Blind')
    gma.cmd('ClearAll')
    
    for i = 1, 11, 1
    do
    gma.cmd('Store exec ' .. Menuexec .. ' cue ' .. i)
    end
    
    -- label cues
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 1 "ANALOGOUS"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 2 "MONOCHROMATIC"')    
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 3 "TONE"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 4 "COMPLEMENTARY"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 5 "TRIAD"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 6 "QUAD"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 7 "SPLIT COMPLEMENTARY"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 8 "COMPOUND"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 9 "GROUPS"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 10 "COLOR"')
    gma.cmd('Label Executor ' .. Menuexec .. ' cue 11 "CONFIG ALL"')    
    
    -- Assign CMD to cues
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 1 /cmd="SetVar $PalPaletteMode = 1; Plugin PALGEN Generate')
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 2 /cmd="SetVar $PalPaletteMode = 2; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 3 /cmd="SetVar $PalPaletteMode = 3; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 4 /cmd="SetVar $PalPaletteMode = 4; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 5 /cmd="SetVar $PalPaletteMode = 5; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 6 /cmd="SetVar $PalPaletteMode = 6; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 7 /cmd="SetVar $PalPaletteMode = 7; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 8 /cmd="SetVar $PalPaletteMode = 8; Plugin PALGEN Generate')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 9 /cmd="Plugin PALGEN Groups')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 10 /cmd="Plugin PALGEN PalColor')    
    gma.cmd('Assign Executor ' .. Menuexec .. ' Cue 11 /cmd="Plugin PALGEN SetupAll')    
    
    gma.cmd('Appearance Executor ' .. Menuexec .. ' At Gel 1.13')
    gma.cmd('Appearance Executor ' .. Menuexec .. ' Cue 9 thru 10 At Gel 1.11')
    gma.cmd('Appearance Executor ' .. Menuexec .. ' Cue 11 At Gel 1.2')
    gma.cmd('Label Executor ' .. Menuexec .. ' "SETUP PALETTE"')
    gma.cmd('Assign Goto ExecButton1 ' .. Menuexec)
        
    gma.cmd('Blind')

end

local function genpluginmacros()
    -- Generate all plugin macros
    gma.cmd('Menu Macro')
    local MacroIni = tonumber(gma.textinput("Set initial Macro number", "You need eight empty macro pools"))
    
    -- Generate macro for MENU
    gma.feedback("Creating macros...")
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN MenuGen\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"GENERATE EXECUTOR PALETTE MENU"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.13')
    
    -- Generate macro for SETUP ALL
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN SetupAll\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE SETUP ALL"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.10')
    
    
    -- Generate macro for MODE
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN PalMode\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE MODE"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.10')   
    
    -- Generate macro for GROUPS
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN PalGroups\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE GROUPS"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.10') 
    
    -- Generate macro for COLOR
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN PalColor\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE COLOR"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.10')
    
    -- Generate macro for HUE
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN PalHUE\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE HUE"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.13')
    
    -- Generate macro for VALUES MACRO
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN PalMacro\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE STORE MACRO"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.13')

    -- Generate macro for GENERATE PALLETE
    MacroIni = (MacroIni + 1)
    gma.cmd('Store Macro 1.' .. MacroIni)
    gma.sleep(0.02)
    
    gma.cmd('Store Macro 1.' .. MacroIni .. ".1")
    gma.sleep(0.02)
    
    gma.cmd('Assign Macro 1.' .. MacroIni .. ".1" .. "/cmd=\"Plugin PALGEN Generate\"")    
    gma.cmd('Label Macro 1.' .. MacroIni .. '"PALETTE GENERATE"')
    gma.cmd('Appearance Macro 1.' .. MacroIni .. ' at Gel 1.12')

end

return main


