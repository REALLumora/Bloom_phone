--!nocheck
--!nolint
-- bloom.gg 🌸

if getgenv and type(getgenv) == "function" and getgenv().meow_cleanup then pcall(function() getgenv().meow_cleanup() end) end
if getgenv and type(getgenv) == "function" and getgenv().bloom_cleanup then pcall(function() getgenv().bloom_cleanup() end) end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
local InsertService = cloneref and cloneref(game:GetService("InsertService")) or game:GetService("InsertService")

local LocalPlayer = Players.LocalPlayer

getgenv().bloom_flags = getgenv().bloom_flags or {}
local flags = getgenv().bloom_flags

local UI_ONLY = getgenv and getgenv().bloom_ui_only == true

local NFL_PLACE_ID = 2338325648
local NFL_UNIVERSE_ID = 184199275
if not UI_ONLY then
    do
        local allowed = (game.PlaceId == NFL_PLACE_ID) or (game.GameId == NFL_UNIVERSE_ID)
        if not allowed then
            pcall(function() LocalPlayer:Kick("WRONG GAME!") end)
            return
        end
    end
end

local Library
do
    local function loadEmbeddedBloom()
--[[

    Milenium Library
    -> Made by @finobe 
    -> Kind of got bored idk what to do with life
    -> Idk who or why this got leaked, ui was VERY popular and high in demand with customers

    -> [MOBILE] Patched for touch devices (Toggle UI button removed — create it in your script)
    -> [MOBILE] Fixed double-toggle on mobile (removed duplicate TouchTap handlers)
]]

-- Variables 
    local uis = game:GetService("UserInputService") 
    local players = game:GetService("Players") 
    local ws = game:GetService("Workspace")
    local rs = game:GetService("ReplicatedStorage")
    local http_service = game:GetService("HttpService")
    local gui_service = game:GetService("GuiService")
    local lighting = game:GetService("Lighting")
    local run = game:GetService("RunService")
    local stats = game:GetService("Stats")
    local coregui = game:GetService("CoreGui")
    local debris = game:GetService("Debris")
    local tween_service = game:GetService("TweenService")
    local sound_service = game:GetService("SoundService")

    -- [MOBILE] Detect touch device
    local is_mobile = uis.TouchEnabled and not uis.KeyboardEnabled
    local viewport_size = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local point_object_space = empty_cfr.PointToObjectSpace
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 
    local gui_offset = gui_service:GetGuiInset().Y

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local noise = math.noise
    local rad = math.rad 
    local random = math.random 
    local pow = math.pow 
    local sin = math.sin 
    local pi = math.pi 
    local tan = math.tan 
    local atan2 = math.atan2 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat
-- 

-- Library init
    getgenv().library = {
        directory = "bloom",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},
        connections = {},   
        notifications = {notifs = {}},
        current_open; 
    }

    local themes = {
        preset = {
            accent = rgb(255, 110, 190),
        }, 

        utility = {
            accent = {
                BackgroundColor3 = {}, 	
                TextColor3 = {}, 
                ImageColor3 = {}, 
                ScrollBarImageColor3 = {} 
            },
        }
    }

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end

    local flags = library.flags 
    local config_flags = library.config_flags
    local notifications = library.notifications 

    local fonts = {}
    pcall(function()
        fonts.small = Font.fromEnum(Enum.Font.Gotham)
        fonts.font = Font.fromEnum(Enum.Font.GothamBold)
    end)
    if not (fonts.small and fonts.font) then
        pcall(function()
            fonts.small = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            fonts.font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        end)
    end
    if not (fonts.small and fonts.font) then
        pcall(function()
            fonts.small = Font.fromEnum(Enum.Font.SourceSans)
            fonts.font = Font.fromEnum(Enum.Font.SourceSansBold)
        end)
    end
--

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties, easing_style, time) 
            local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end

        function library:resizify(frame) 
            local Frame = Instance.new("TextButton")
            Frame.Position = dim2(1, -10, 1, -10)
            Frame.BorderColor3 = rgb(0, 0, 0)
            Frame.Size = dim2(0, 10, 0, 10)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = rgb(255, 255, 255)
            Frame.Parent = frame
            Frame.BackgroundTransparency = 1 
            Frame.Text = ""

            local resizing = false 
            local start_size 
            local start 
            local og_size = frame.Size  

            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = true
                    start = input.Position
                    start_size = frame.Size
                end
            end)

            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_size = dim2(
                        start_size.X.Scale,
                        math.clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            og_size.X.Offset,
                            viewport_x
                        ),
                        start_size.Y.Scale,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            og_size.Y.Offset,
                            viewport_y
                        )
                    )

                    library:tween(frame, {Size = current_size}, Enum.EasingStyle.Linear, 0.05)
                end
            end)
        end 

        function fag(tbl)
            local Size = 0
            
            for _ in tbl do
                Size = Size + 1
            end
        
            return Size
        end
        
        function library:next_flag()
            local index = fag(library.flags) + 1;
            local str = string.format("flagnumber%s", index)
            
            return str;
        end 

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        function library:draggify(frame)
            local dragging = false 
            local start_size = frame.Position
            local start 

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    start = input.Position
                    start_size = frame.Position
                end
            end)

            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
                    or input.UserInputType == Enum.UserInputType.Touch) then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_position = dim2(
                        0,
                        clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            0,
                            viewport_x - frame.Size.X.Offset
                        ),
                        0,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            0,
                            viewport_y - frame.Size.Y.Offset
                        )
                    )

                    library:tween(frame, {Position = current_position}, Enum.EasingStyle.Linear, 0.05)
                    library:close_element()
                end
            end)
        end 

        function library:convert(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                insert(values, tonumber(value))
            end
            
            if #values == 4 then              
                return unpack(values)
            else 
                return
            end
        end
        
        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        local config_holder;
        function library:update_config_list() 
            if not config_holder then 
                return 
            end
            
            local list = {}
            
            for idx, file in listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
                list[#list + 1] = name
            end

            config_holder.refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
            
            for _, v in next, flags do
                if type(v) == "table" and v.key then
                    Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
                elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                    Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
                else
                    Config[_] = v
                end
            end 
            
            return http_service:JSONEncode(Config)
        end

        function library:load_config(config_json) 
            local config = http_service:JSONDecode(config_json)
            
            for _, v in config do 
                local function_set = library.config_flags[_]
                
                if _ == "config_name_list" then 
                    continue 
                end

                if function_set then 
                    if type(v) == "table" and v["Transparency"] and v["Color"] then
                        function_set(hex(v["Color"]), v["Transparency"])
                    elseif type(v) == "table" and v["active"] then 
                        function_set(v)
                    else
                        function_set(v)
                    end
                end 
            end 
        end 
        
        function library:round(number, float) 
            local multiplier = 1 / (float or 1)

            return floor(number * multiplier + 0.5) / multiplier
        end 

        local function colors_match(c1, c2)
            if not c1 or not c2 then return false end
            return math.abs(c1.R - c2.R) < 0.04 and math.abs(c1.G - c2.G) < 0.04 and math.abs(c1.B - c2.B) < 0.04
        end

        function library:apply_theme(instance, theme, property) 
            if themes.preset[theme] then
                pcall(function() instance[property] = themes.preset[theme] end)
            end
            if themes.utility[theme] and themes.utility[theme][property] then
                insert(themes.utility[theme][property], instance)
            end
        end

        function library:update_theme(theme, color)
            local old_color = themes.preset[theme]
            themes.preset[theme] = color 

            if themes.utility[theme] then 
                for propName, instances in pairs(themes.utility[theme]) do 
                    for _, object in ipairs(instances) do 
                        pcall(function()
                            if old_color and object[propName] then
                                if colors_match(object[propName], old_color) then
                                    object[propName] = color
                                end
                            else
                                object[propName] = color
                            end
                        end)
                    end 
                end 
            end 

            if theme == "accent" and library.window_items and library.window_items["title"] and library.window_cfg then
                pcall(function()
                    local r = math.floor(color.R * 255)
                    local g = math.floor(color.G * 255)
                    local b = math.floor(color.B * 255)
                    library.window_items["title"].Text = string.format('<font color="rgb(%d, %d, %d)">%s</font><font color="rgb(255, 255, 255)">%s</font>', r, g, b, library.window_cfg.name, library.window_cfg.suffix)
                end)
            end
            if theme == "accent" and library.window_items and library.window_items["accent_bar"] then
                pcall(function()
                    library.window_items["accent_bar"].BackgroundColor3 = color
                end)
            end
            if theme == "accent" and library.window_items and library.window_items["other_info"] and library.window_cfg then
                pcall(function()
                    local r = math.floor(color.R * 255)
                    local g = math.floor(color.G * 255)
                    local b = math.floor(color.B * 255)
                    library.window_items["other_info"].Text = string.format('<font color="rgb(72, 72, 73)">%s</font><font color="rgb(%d, %d, %d)">%s%s</font>', library.window_cfg.sub_info or "lifetime, ", r, g, b, library.window_cfg.name, library.window_cfg.suffix)
                end)
            end
        end
        library.set_theme = library.update_theme 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:close_element(new_path) 
            local open_element = library.current_open

            if open_element and new_path ~= open_element then
                open_element.set_visible(false)
                open_element.open = false;
            end 

            if new_path ~= open_element then 
                library.current_open = new_path or nil;
            end
        end 

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in options do 
                ins[prop] = value
            end
            
            return ins 
        end

        function library:unload_menu() 
            if library[ "items" ] then 
                library[ "items" ]:Destroy()
            end

            if library[ "other" ] then 
                library[ "other" ]:Destroy()
            end 
            
            for index, connection in library.connections do 
                connection:Disconnect() 
                connection = nil 
            end
            
            library = nil 
        end 
    --
    
    -- Library element functions
        function library:window(properties)
            -- [MOBILE] Auto-fit window to mobile viewport
            local default_size = dim2(0, 780, 0, 505)
            if is_mobile then
                local w = clamp(viewport_size.X * 0.94, 320, 700)
                local h = clamp(viewport_size.Y * 0.82, 340, 505)
                default_size = dim2(0, w, 0, h)
            end

            local cfg = { 
                suffix = properties.suffix or properties.Suffix or "tech";
                name = properties.name or properties.Name or "nebula";
                game_name = properties.gameInfo or properties.game_info or properties.GameInfo or "bloom.gg";
                size = properties.size or properties.Size or default_size;
                selected_tab;
                items = {};

                tween;
            }
            
            library[ "items" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Global;
                IgnoreGuiInset = true;
            });
            
            library[ "other" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            local items = cfg.items; do
                items[ "main" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = cfg.size;
                    Name = "\0";
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(10, 10, 12)
                }); items[ "main" ].Position = dim2(0, items[ "main" ].AbsolutePosition.X, 0, items[ "main" ].AbsolutePosition.Y)
                

                library:create( "UICorner" , {
                    Parent = items[ "main" ];
                    CornerRadius = dim(0, 10)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "main" ];
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });

                library.window_cfg = cfg
                library.window_items = items


                
                local side_width = is_mobile and 130 or 196
                items[ "side_frame" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, side_width, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(10, 10, 12)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "side_frame" ];
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "button_holder" ] = library:create( "Frame" , {
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 60);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -60);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.button_holder = items[ "button_holder" ];
                
                library:create( "UIListLayout" , {
                    Parent = items[ "button_holder" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingTop = dim(0, 16);
                    PaddingBottom = dim(0, 36);
                    Parent = items[ "button_holder" ];
                    PaddingRight = dim(0, 11);
                    PaddingLeft = dim(0, 10)
                });

                local accent = themes.preset.accent
                local tr, tg, tb = math.floor(accent.R * 255), math.floor(accent.G * 255), math.floor(accent.B * 255)
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    Text = string.format('<font color="rgb(%d, %d, %d)">%s</font><font color="rgb(255, 255, 255)">%s</font>', tr, tg, tb, cfg.name, cfg.suffix);
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 70);
                    TextColor3 = themes.preset.accent;
                    BorderSizePixel = 0;
                    RichText = true;
                    TextSize = 30;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
                
                items[ "multi_holder" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, side_width, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -side_width, 0, 56);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.multi_holder = items[ "multi_holder" ];
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "multi_holder" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "shadow" ] = library:create( "ImageLabel" , {
                    ImageColor3 = rgb(0, 0, 0);
                    ScaleType = Enum.ScaleType.Slice;
                    Parent = items[ "main" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Name = "\0";
                    BackgroundColor3 = rgb(255, 255, 255);
                    Size = dim2(1, 75, 1, 75);
                    AnchorPoint = vec2(0.5, 0.5);
                    Image = "rbxassetid://112971167999062";
                    BackgroundTransparency = 1;
                    Position = dim2(0.5, 0, 0.5, 0);
                    SliceScale = 0.75;
                    ZIndex = -100;
                    BorderSizePixel = 0;
                    SliceCenter = rect(vec2(112, 112), vec2(147, 147))
                });
                
                items[ "global_fade" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, side_width, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -side_width, 1, -56);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(10, 10, 12);
                    ZIndex = 2;
                });                

                library:create( "UICorner" , {
                    Parent = items[ "shadow" ];
                    CornerRadius = dim(0, 5)
                });
                
                items[ "info" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "main" ];
                    Name = "\0";
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    Visible = false;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "info" ];
                    CornerRadius = dim(0, 10)
                });
                
                items[ "grey_fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "info" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 6);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                items[ "game" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    Parent = items[ "info" ];
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.game_name;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10, 0.5, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); 
                
                local fr, fg, fb = math.floor(themes.preset.accent.R * 255), math.floor(themes.preset.accent.G * 255), math.floor(themes.preset.accent.B * 255)
                items[ "other_info" ] = library:create( "TextLabel" , {
                    Parent = items[ "info" ];
                    RichText = true;
                    Name = "\0";
                    TextColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = string.format('<font color="rgb(72, 72, 73)">%s</font><font color="rgb(%d, %d, %d)">%s%s</font>', cfg.sub_info or "lifetime, ", fr, fg, fb, cfg.name, cfg.suffix);
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, -10, 0.5, -1);
                    AnchorPoint = vec2(0, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    FontFace = fonts.font;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "other_info" ], "accent", "TextColor3");        
            end 

            do -- Other
                library:draggify(items[ "main" ])
                library:resizify(items[ "main" ])
            end 

            function cfg.toggle_menu(bool) 
                library[ "items" ].Enabled = bool
            end 

            return setmetatable(cfg, library)
        end 

        function library:tab(properties)
            local cfg = {
                name = properties.name or properties.Name or "visuals"; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6034767608";
                
                tabs = properties.tabs or properties.Tabs or {"Main", "Misc.", "Settings"};
                pages = {}; 
                current_multi; 
                
                items = {};
            } 

            local items = cfg.items; do 
                local side_width = is_mobile and 130 or 196
                local tab_holder_pos_x = side_width
                local tab_holder_size_x = is_mobile and (1) or (1)

                items[ "tab_holder" ] = library:create( "Frame" , {
                    Parent = library.cache;
                    Name = "\0";
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = dim2(0, tab_holder_pos_x, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -tab_holder_pos_x - 14, 1, -66);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                -- Tab buttons 
                    items[ "button" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "button_holder" ];
                        AutoButtonColor = false;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 35);
                        BorderSizePixel = 0;
                        TextSize = 16;
                        BackgroundColor3 = rgb(29, 29, 29)
                    });
                    
                    items[ "icon" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "button" ];
                        AnchorPoint = vec2(0, 0.5);
                        Image = cfg.icon or "http://www.roblox.com/asset/?id=6034767608";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 10, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 22, 0, 22);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_theme(items[ "icon" ], "accent", "ImageColor3");
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "button" ];
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        Position = dim2(0, 40, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "button" ];
                        CornerRadius = dim(0, 7)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(23, 23, 29);
                        Parent = items[ "button" ];
                        Enabled = false;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    });
                -- 

                -- Multi Sections
                    items[ "multi_section_button_holder" ] = library:create( "Frame" , {
                        Parent = library.cache;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "multi_section_button_holder" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        FillDirection = Enum.FillDirection.Horizontal
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingTop = dim(0, 8);
                        PaddingBottom = dim(0, 7);
                        Parent = items[ "multi_section_button_holder" ];
                        PaddingRight = dim(0, 7);
                        PaddingLeft = dim(0, 7)
                    });                        

                    for _, section in cfg.tabs do
                        local data = {items = {}} 

                        local multi_items = data.items; do 
                            -- Button
                                multi_items[ "button" ] = library:create( "TextButton" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(255, 255, 255);
                                    BorderColor3 = rgb(0, 0, 0);
                                    AutoButtonColor = false;
                                    Text = "";
                                    Parent = items[ "multi_section_button_holder" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 0, 39);
                                    BackgroundTransparency = 1;
                                    ClipsDescendants = true;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.X;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(25, 25, 29)
                                });
                                
                                multi_items[ "name" ] = library:create( "TextLabel" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(62, 62, 63);
                                    BorderColor3 = rgb(0, 0, 0);
                                    Text = section;
                                    Parent = multi_items[ "button" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 1, 0);
                                    BackgroundTransparency = 1;
                                    TextXAlignment = Enum.TextXAlignment.Left;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.XY;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "name" ];
                                    PaddingRight = dim(0, 5);
                                    PaddingLeft = dim(0, 5)
                                });
                                
                                multi_items[ "accent" ] = library:create( "Frame" , {
                                    BorderColor3 = rgb(0, 0, 0);
                                    AnchorPoint = vec2(0, 1);
                                    Parent = multi_items[ "button" ];
                                    BackgroundTransparency = 1;
                                    Position = dim2(0, 10, 1, 4);
                                    Name = "\0";
                                    Size = dim2(1, -20, 0, 6);
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = themes.preset.accent
                                }); library:apply_theme(multi_items[ "accent" ], "accent", "BackgroundColor3");
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "accent" ];
                                    CornerRadius = dim(0, 999)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "button" ];
                                    PaddingRight = dim(0, 10);
                                    PaddingLeft = dim(0, 10)
                                });
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "button" ];
                                    CornerRadius = dim(0, 7)
                                }); 
                            --

                            -- Tab 
                                multi_items[ "tab" ] = library:create( "Frame" , {
                                    Parent = library.cache;
                                    BackgroundTransparency = 1;
                                    Name = "\0";
                                    BorderColor3 = rgb(0, 0, 0);
                                    Size = dim2(1, -20, 1, -20);
                                    BorderSizePixel = 0;
                                    Visible = false;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIListLayout" , {
                                    FillDirection = Enum.FillDirection.Vertical;
                                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                                    Parent = multi_items[ "tab" ];
                                    Padding = dim(0, 7);
                                    SortOrder = Enum.SortOrder.LayoutOrder;
                                    VerticalFlex = Enum.UIFlexAlignment.Fill
                                });
                                
                                library:create( "UIPadding" , {
                                    PaddingTop = dim(0, 7);
                                    PaddingBottom = dim(0, 7);
                                    Parent = multi_items[ "tab" ];
                                    PaddingRight = dim(0, 7);
                                    PaddingLeft = dim(0, 7)
                                });
                            --
                        end

                        data.text = multi_items[ "name" ]
                        data.accent = multi_items[ "accent" ]
                        data.button = multi_items[ "button" ]
                        data.page = multi_items[ "tab" ]
                        data.parent = setmetatable(data, library):sub_tab({}).items[ "tab_parent" ]
                        
                        function data.open_page()
                            local page = cfg.current_multi; 
                            
                            if page and page.text ~= data.text then 
                                self.items[ "global_fade" ].BackgroundTransparency = 0
                                library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                                
                                local old_size = page.page.Size
                                page.page.Size = dim2(1, -20, 1, -20)
                            end

                            if page then
                                library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                                library:tween(page.accent, {BackgroundTransparency = 1})
                                library:tween(page.button, {BackgroundTransparency = 1})

                                page.page.Visible = false
                                page.page.Parent = library[ "cache" ] 
                            end 
                            
                            library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                            library:tween(data.accent, {BackgroundTransparency = 1})
                            library:tween(data.button, {BackgroundTransparency = 0})
                            library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                            data.page.Visible = true
                            data.page.Parent = items["tab_holder"]

                            cfg.current_multi = data

                            library:close_element()
                        end

                        multi_items[ "button" ].MouseButton1Down:Connect(function()
                            data.open_page() 
                        end)
                        -- [MOBILE] touch
                        multi_items[ "button" ].TouchTap:Connect(function()
                            data.open_page()
                        end)

                        cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
                    end 

                    cfg.pages[1].open_page()
                --
            end 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                local side_width = is_mobile and 130 or 196
                
                if selected_tab then 
                    if selected_tab[ 4 ] ~= items[ "tab_holder" ] then 
                        self.items[ "global_fade" ].BackgroundTransparency = 0
                        
                        library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                        selected_tab[ 4 ].Size = dim2(1, -side_width - 20, 1, -101)
                    end

                    library:tween(selected_tab[ 1 ], {BackgroundTransparency = 1})
                    library:tween(selected_tab[ 2 ], {ImageColor3 = rgb(72, 72, 73)})
                    library:tween(selected_tab[ 3 ], {TextColor3 = rgb(72, 72, 73)})

                    selected_tab[ 4 ].Visible = false
                    selected_tab[ 4 ].Parent = library[ "cache" ]
                    selected_tab[ 5 ].Visible = false
                    selected_tab[ 5 ].Parent = library[ "cache" ]
                end

                library:tween(items[ "button" ], {BackgroundTransparency = 0})
                library:tween(items[ "icon" ], {ImageColor3 = themes.preset.accent})
                library:tween(items[ "name" ], {TextColor3 = rgb(255, 255, 255)})
                library:tween(items[ "tab_holder" ], {Size = dim2(1, -side_width, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                
                items[ "tab_holder" ].Visible = true 
                items[ "tab_holder" ].Parent = self.items[ "main" ]
                items[ "multi_section_button_holder" ].Visible = true 
                items[ "multi_section_button_holder" ].Parent = self.items[ "multi_holder" ]

                self.selected_tab = {
                    items[ "button" ];
                    items[ "icon" ];
                    items[ "name" ];
                    items[ "tab_holder" ];
                    items[ "multi_section_button_holder" ];
                }

                library:close_element()
            end

            items[ "button" ].MouseButton1Down:Connect(function()
                cfg.open_tab()
            end)
            -- [MOBILE] touch
            items[ "button" ].TouchTap:Connect(function()
                cfg.open_tab()
            end)
            
            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return unpack(cfg.pages)
        end

        function library:seperator(properties)
            properties = properties or {}
            local cfg = {items = {}, name = type(properties) == "table" and (properties.Name or properties.name or properties.title or properties.Title) or (type(properties) == "string" and properties) or "General"}

            local items = cfg.items do 
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = self.items[ "button_holder" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 40, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0; 
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end;    

            return setmetatable(cfg, library)
        end 

        -- Miscellaneous 
            function library:column(properties) 
                local cfg = {items = {}, size = properties.size or 1}

                local items = cfg.items; do     
                    items[ "column" ] = library:create( "Frame" , {
                        Parent = self[ "parent" ] or self.items["tab_parent"];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, cfg.size, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 10);
                        Parent = items[ "column" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "column" ];
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Padding = dim(0, 10);
                        FillDirection = Enum.FillDirection.Vertical;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                end 

                return setmetatable(cfg, library)
            end 

            function library:sub_tab(properties) 
                local cfg = {items = {}, order = properties.order or 0; size = properties.size or 1}

                local items = cfg.items; do 
                    items[ "tab_parent" ] = library:create( "Frame" , {
                        Parent = self.items[ "tab" ];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(0,0,cfg.size,0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = items[ "tab_parent" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });
                end

                return setmetatable(cfg, library)
            end 
        --

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section"; 
                side = properties.side or properties.Side or "left";
                default = properties.default or properties.Default or false;
                size = properties.size or properties.Size or self.size or 0.5; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6022668898";
                fading_toggle = properties.fading or properties.Fading or false;
                items = {};
            };
            
            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = self.items[ "column" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, cfg.size, -3);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(25, 25, 29)
                });

                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "scrolling" ] = library:create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(44, 44, 46);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    Parent = items[ "inline" ];
                    Name = "\0";
                    Size = dim2(1, 0, 1, -40);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 35);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "scrolling" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 0, 35);
                    BorderSizePixel = 0;
                    TextSize = 16;
                    BackgroundColor3 = rgb(19, 19, 21)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "button" ];
                    Enabled = false;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "Icon" ] = library:create( "ImageLabel" , {
                    ImageColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "button" ];
                    AnchorPoint = vec2(0, 0.5);
                    Image = cfg.icon;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, 22, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "Icon" ], "accent", "ImageColor3");
                
                items[ "section_title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    RichText = true; -- [SECTION_TITLE_RICHTEXT]
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    Size = dim2(0, 0, 1, 0);
                    Position = dim2(0, 40, 0, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "button" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
                
                if cfg.fading_toggle then 
                    items[ "toggle" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(1, 0.5);
                        Parent = items[ "button" ];
                        Name = "\0";
                        Position = dim2(1, -9, 0.5, 0);
                        Size = dim2(0, 36, 0, 18);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(58, 58, 62)
                    });  library:apply_theme(items[ "toggle" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    items[ "toggle_outline" ] = library:create( "Frame" , {
                        Parent = items[ "toggle" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(50, 50, 50)
                    });  library:apply_theme(items[ "toggle_outline" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_outline" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "toggle_outline" ]
                    });
                    
                    items[ "toggle_circle" ] = library:create( "Frame" , {
                        Parent = items[ "toggle_outline" ];
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(86, 86, 88)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_circle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 7)
                    });
                
                    items[ "fade" ] = library:create( "Frame" , {
                        Parent = items[ "outline" ];
                        BackgroundTransparency = 0.800000011920929;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "fade" ];
                        CornerRadius = dim(0, 7)
                    });
                end 
            end;

            if cfg.fading_toggle then
                items[ "button" ].MouseButton1Click:Connect(function()
                    cfg.default = not cfg.default 
                    cfg.toggle_section(cfg.default) 
                end)
                -- [MOBILE] touch (only one handler to avoid double-toggle)
                items[ "button" ].TouchTap:Connect(function()
                    cfg.default = not cfg.default 
                    cfg.toggle_section(cfg.default)
                end)

                function cfg.toggle_section(bool)
                    library:tween(items[ "toggle" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "fade" ], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
                end 
            end 

            return setmetatable(cfg, library)
        end  

        function library:toggle(options) 
            local rand = math.random(1, 2) 
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                info = options.info or nil,
                flag = options.flag or library:next_flag(),
                
                type = options.type and string.lower(options.type) or rand == 1 and "toggle" or "checkbox";

                default = options.default or false,
                folding = options.folding or false, 
                callback = options.callback or function() end,

                items = {};
                seperator = options.seperator or options.Seperator or false;
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "toggle" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "toggle" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                -- Toggle
                    if cfg.type == "checkbox" then 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AutoButtonColor = false;
                            AnchorPoint = vec2(1, 0);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, 0, 0, 0);
                            Size = dim2(0, 16, 0, 16);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(67, 67, 68)
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        items[ "outline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(22, 22, 24)
                        }); library:apply_theme(items[ "outline" ], "accent", "BackgroundColor3");
                        
                        items[ "tick" ] = library:create( "ImageLabel" , {
                            ImageTransparency = 1;
                            BorderColor3 = rgb(0, 0, 0);
                            Image = "rbxassetid://111862698467575";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            Parent = items[ "outline" ];
                            Size = dim2(1, 2, 1, 2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255);
                            ZIndex = 1;
                        });

                        library:create( "UICorner" , {
                            Parent = items[ "outline" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        library:create( "UIGradient" , {
                            Enabled = false;
                            Parent = items[ "outline" ];
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}
                        });  
                    else 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AnchorPoint = vec2(1, 0.5);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, -9, 0.5, 0);
                            Size = dim2(0, 36, 0, 18);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        items[ "inline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "inline" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "inline" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        library:create( "UIGradient" , {
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                            Parent = items[ "inline" ]
                        });
                        
                        items[ "circle" ] = library:create( "Frame" , {
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Position = dim2(1, -14, 0, 2);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 12, 0, 12);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "circle" ];
                            CornerRadius = dim(0, 999)
                        });                        
                    end 
                --                
            end;
            
            function cfg.set(bool)
                if cfg.type == "checkbox" then 
                    library:tween(items[ "tick" ], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(67, 67, 68)})
                    library:tween(items[ "outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(22, 22, 24)})
                else
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "inline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                end

                cfg.callback(bool)

                if cfg.folding then 
                    elements.Visible = bool
                end

                flags[cfg.flag] = bool
            end 
            
            items[ "toggle" ].MouseButton1Click:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            -- [MOBILE] touch (only ONE handler — on the row — to avoid double-toggle)
            items[ "toggle" ].TouchTap:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)

            items[ "toggle_button" ].MouseButton1Click:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            -- NOTE: deliberately NO TouchTap on toggle_button — it would double-fire
            --       with the row's TouchTap when the user taps the switch itself.
            
            if cfg.seperator then
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end

            cfg.set(cfg.default)

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 
        
        function library:slider(options) 
            local cfg = {
                name = options.name or nil,
                suffix = options.suffix or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end, 
                info = options.info or nil; 

                min = options.min or options.minimum or 0,
                max = options.max or options.maximum or 100,
                intervals = options.interval or options.decimal or 1,
                default = options.default or 10,
                value = options.default or 10, 
                seperator = options.seperator or options.Seperator or true;

                dragging = false,
                items = {}
            }

            if cfg.style == "bar" then
                flags[cfg.flag] = cfg.default
                local items = cfg.items
                items["slider_object"] = library:create("Frame", {
                    Parent = self.items["elements"],
                    BackgroundTransparency = 1,
                    Size = dim2(1, 0, 0, 22),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })

                items["bar_btn"] = library:create("TextButton", {
                    Parent = items["slider_object"],
                    Text = "",
                    AutoButtonColor = false,
                    Size = dim2(1, -8, 1, 0),
                    Position = dim2(0, 4, 0, 0),
                    BackgroundColor3 = rgb(18, 19, 24),
                    BorderSizePixel = 0
                })
                library:create("UICorner", { Parent = items["bar_btn"], CornerRadius = dim(0, 4) })
                library:create("UIStroke", { Parent = items["bar_btn"], Color = rgb(25, 27, 33), Thickness = 1 })

                local initPct = clamp((cfg.default - cfg.min) / (cfg.max - cfg.min), 0, 1)
                items["fill"] = library:create("Frame", {
                    Parent = items["bar_btn"],
                    Size = dim2(initPct, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent,
                    ZIndex = 2
                })
                library:apply_theme(items["fill"], "accent", "BackgroundColor3")
                library:create("UICorner", { Parent = items["fill"], CornerRadius = dim(0, 4) })

                items["center_label"] = library:create("TextLabel", {
                    Parent = items["bar_btn"],
                    FontFace = fonts.small,
                    TextColor3 = rgb(255, 255, 255),
                    TextSize = 13,
                    Size = dim2(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 3,
                    Text = (cfg.name or "percent") .. ": " .. tostring(cfg.default) .. cfg.suffix
                })

                function cfg.set(value)
                    cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)
                    local pct = clamp((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 1)
                    items["fill"].Size = dim2(pct, 0, 1, 0)
                    items["center_label"].Text = (cfg.name or "percent") .. ": " .. tostring(cfg.value) .. cfg.suffix
                    flags[cfg.flag] = cfg.value
                    cfg.callback(flags[cfg.flag])
                end

                local function handleInput(input)
                    local size_x = clamp((input.Position.X - items["bar_btn"].AbsolutePosition.X) / items["bar_btn"].AbsoluteSize.X, 0, 1)
                    local val = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(val)
                end

                items["bar_btn"].MouseButton1Down:Connect(function()
                    cfg.dragging = true
                end)
                items["bar_btn"].InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        cfg.dragging = true
                        handleInput(input)
                    end
                end)
                library:connection(uis.InputChanged, function(input)
                    if cfg.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        handleInput(input)
                    end
                end)
                library:connection(uis.InputEnded, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        cfg.dragging = false
                    end
                end)

                if cfg.seperator then
                    library:create("Frame", {
                        AnchorPoint = vec2(0, 1),
                        Parent = self.items["elements"],
                        Position = dim2(0, 0, 1, 0),
                        Size = dim2(1, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(36, 36, 37)
                    })
                end

                cfg.set(cfg.default)
                config_flags[cfg.flag] = cfg.set
                return setmetatable(cfg, library)
            end 

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "slider_object" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "slider_object" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 37);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 

                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 23);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "slider" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 4);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "slider" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "slider" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 0, 4);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });  library:apply_theme(items[ "fill" ], "accent", "BackgroundColor3");
                
                library:create( "UICorner" , {
                    Parent = items[ "fill" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "circle" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0.5, 0.5);
                    Parent = items[ "fill" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(244, 244, 244)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "circle" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4)
                });
                
                items[ "value" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "50%";
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 6, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "value" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end 

            function cfg.set(value)
                cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                library:tween(items[ "fill" ], {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
                items[ "value" ].Text = tostring(cfg.value) .. cfg.suffix

                flags[cfg.flag] = cfg.value
                cfg.callback(flags[cfg.flag])
            end

            items[ "slider" ].MouseButton1Down:Connect(function()
                cfg.dragging = true 
                library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
            end)
            -- [MOBILE] touch
            items[ "slider" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    cfg.dragging = true
                    library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
                    local size_x = clamp((input.Position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X, 0, 1)
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
                    or input.UserInputType == Enum.UserInputType.Touch) then
                    local size_x = clamp((input.Position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X, 0, 1)
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 
                    or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.dragging = false
                    library:tween(items[ "value" ], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2) 
                end 
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            cfg.set(cfg.default)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:dropdown(options) 
            local cfg = {
                name = options.name or nil;
                info = options.info or nil;
                style = options.style or (options.bar and "bar") or "normal";
                flag = options.flag or library:next_flag();
                options = options.items or {""};
                callback = options.callback or function() end;
                multi = options.multi or false;
                scrolling = options.scrolling or false;

                width = options.width or 130;

                open = false;
                option_instances = {};
                multi_items = {};
                ignore = options.ignore or false;
                items = {};
                y_size;
                seperator = options.seperator or options.Seperator or true;
            }   

            cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"
            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                -- Element
                    items[ "dropdown_object" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Dropdown";
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    if cfg.info then 
                        items[ "info" ] = library:create( "TextLabel" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(130, 130, 130);
                            BorderColor3 = rgb(0, 0, 0);
                            TextWrapped = true;
                            Text = cfg.info;
                            Parent = items[ "dropdown_object" ];
                            Name = "\0";
                            Position = dim2(0, 5, 0, 17);
                            Size = dim2(1, -10, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 16;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    end 

                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "dropdown" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, cfg.width, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "dropdown" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "sub_text" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "awdawdawdawdawdawdawdaw";
                        Parent = items[ "dropdown" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "sub_text" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "indicator" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "dropdown" ];
                        AnchorPoint = vec2(1, 0.5);
                        Image = "rbxassetid://101025591575185";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -5, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Element Holder
                    items[ "dropdown_holder" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library[ "items" ];
                        Name = "\0";
                        Visible = true;
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0);
                        ZIndex = 10;
                    });
                    
                    items[ "outline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_holder" ];
                        Size = dim2(1, 0, 1, 0);
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(33, 33, 35);
                        ZIndex = 10;
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "outline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "outline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 4)
                    });
                -- 
            end 

            function cfg.render_option(text)
                local button = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Size = dim2(1, -12, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    ZIndex = 10;
                }); library:apply_theme(button, "accent", "TextColor3");
                
                library:create( "UIPadding" , {
                    Parent = button;
                    PaddingTop = dim(0, 1);
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                return button
            end
            
            function cfg.set_visible(bool)
                local a = bool and cfg.y_size or 0
                library:tween(items[ "dropdown_holder" ], {Size = dim_offset(items[ "dropdown" ].AbsoluteSize.X, a)})

                items[ "dropdown_holder" ].Position = dim2(0, items[ "dropdown" ].AbsolutePosition.X, 0, items[ "dropdown" ].AbsolutePosition.Y + 80)
                if not (self.sanity and library.current_open == self) then 
                    library:close_element(cfg)
                end
            end
            
            function cfg.set(value)
                local selected = {}
                local isTable = type(value) == "table"

                for _, option in cfg.option_instances do 
                    if option.Text == value or (isTable and find(value, option.Text)) then 
                        insert(selected, option.Text)
                        cfg.multi_items = selected
                        option.TextColor3 = themes.preset.accent
                    else
                        option.TextColor3 = rgb(72, 72, 73)
                    end
                end

                items[ "sub_text" ].Text = isTable and concat(selected, ", ") or selected[1] or ""
                flags[cfg.flag] = isTable and selected or selected[1]
                
                cfg.callback(flags[cfg.flag]) 
            end
            
            function cfg.refresh_options(list) 
                cfg.y_size = 0

                for _, option in cfg.option_instances do 
                    option:Destroy() 
                end
                
                cfg.option_instances = {} 

                for _, option in list do 
                    local button = cfg.render_option(option)
                    cfg.y_size += button.AbsoluteSize.Y + 6
                    insert(cfg.option_instances, button)
                    
                    button.MouseButton1Down:Connect(function()
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                    -- [MOBILE] touch
                    button.TouchTap:Connect(function()
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                end
            end

            items[ "dropdown" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 
                
                cfg.set_visible(cfg.open)
            end)
            -- [MOBILE] touch
            items[ "dropdown" ].TouchTap:Connect(function()
                cfg.open = not cfg.open 
                cfg.set_visible(cfg.open)
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            flags[cfg.flag] = {} 
            config_flags[cfg.flag] = cfg.set
            
            cfg.refresh_options(cfg.options)
            cfg.set(cfg.default)
                
            return setmetatable(cfg, library)
        end

        function library:label(options)
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                seperator = options.seperator or options.Seperator or false;
                info = options.info or nil; 

                items = {};
            }

            local items = cfg.items; do 
                items[ "label" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "label" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "label" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "label" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                
            end 

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            return setmetatable(cfg, library)
        end 
        
        function library:colorpicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or library:next_flag(),

                color = options.color or color(1, 1, 1),
                alpha = options.alpha and 1 - options.alpha or 0,
                
                open = false, 
                callback = options.callback or function() end,
                items = {};

                seperator = options.seperator or options.Seperator or false;
            }

            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

            local label; 
            if not self.items.right_components then 
                label = self:label({name = cfg.name, seperator = cfg.seperator})
            end

            local items = cfg.items; do 
                -- Component
                    items[ "colorpicker" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = label and label.items.right_components or self.items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, 16, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "colorpicker_inline" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "colorpicker_inline" ]
                    });         
                --
                
                -- Colorpicker
                    items[ "colorpicker_holder" ] = library:create( "Frame" , {
                        Parent = library[ "other" ];
                        Name = "\0";
                        Position = dim2(0.20000000298023224, 20, 0.296999990940094, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 166, 0, 197);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });

                    items[ "colorpicker_fade" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        BackgroundTransparency = 0;
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        ZIndex = 100;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });
                    
                    items[ "colorpicker_components" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_components" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "saturation_holder" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 7, 0, 7);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -14, 1, -80);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 39, 39)
                    });
                    
                    items[ "sat" ] = library:create( "TextButton" , {
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Text = "";
                        AutoButtonColor = false;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "sat" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = items[ "sat" ];
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    items[ "val" ] = library:create( "Frame" , {
                        Name = "\0";
                        Parent = items[ "saturation_holder" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Parent = items[ "val" ];
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "val" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "saturation_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "satvalpicker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 1);
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Position = dim2(0, 0, 4, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "satvalpicker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "satvalpicker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "hue_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -64);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
                        Parent = items[ "hue_gradient" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "hue_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "hue_gradient" ];
                        Name = "\0";
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "hue_picker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "alpha_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -46);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(25, 25, 29);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "alpha_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "alpha_gradient" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                        Parent = items[ "alpha_picker" ]
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = items[ "alpha_gradient" ]
                    });
                    
                    items[ "alpha_indicator" ] = library:create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "alpha_gradient" ];
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        TileSize = dim2(0, 6, 0, 6);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))};
                        Transparency = numseq{numkey(0, 0.8062499761581421), numkey(1, 0)};
                        Parent = items[ "alpha_indicator" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_indicator" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "colorpicker_components" ];
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))}
                    });

                    items[ "input" ] = library:create( "TextBox" , {
                        FontFace = fonts.font;
                        AnchorPoint = vec2(1, 1);
                        Text = "";
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        BorderSizePixel = 0;
                        PlaceholderColor3 = rgb(255, 255, 255);
                        CursorPosition = -1;
                        ClearTextOnFocus = false;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255);
                        TextColor3 = rgb(72, 72, 72);
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(1, -8, 1, -11);
                        Size = dim2(1, -16, 0, 18);
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); 
                    
                    library:create( "UICorner" , {
                        Parent = items[ "input" ];
                        CornerRadius = dim(0, 3)
                    });
                    
                    items[ "UICorenr" ] = library:create( "UICorner" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        CornerRadius = dim(0, 4)
                    });
                --                  
            end;

            function cfg.set_visible(bool)
                items[ "colorpicker_fade" ].BackgroundTransparency = 0
                items[ "colorpicker_holder" ].Parent = bool and library[ "items" ] or library[ "other" ]
                items[ "colorpicker_holder" ].Position = dim_offset(items[ "colorpicker" ].AbsolutePosition.X, items[ "colorpicker" ].AbsolutePosition.Y + items[ "colorpicker" ].AbsoluteSize.Y + 45)

                library:tween(items[ "colorpicker_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                library:tween(items[ "colorpicker_holder" ], {Position = items[ "colorpicker_holder" ].Position + dim_offset(0, 20)})
                
                if not (self.sanity and library.current_open == self and self.open) then 
                    library:close_element(cfg)
                end
            end

            function cfg.set(color, alpha)
                if type(color) == "boolean" then 
                    return
                end 

                if color then 
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                local Color = hsv(h, s, v)

                library:tween(items[ "hue_picker" ], {Position = dim2(0, (items[ "hue_gradient" ].AbsoluteSize.X - items[ "hue_picker" ].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "alpha_picker" ], {Position = dim2(0, (items[ "alpha_gradient" ].AbsoluteSize.X - items[ "alpha_picker" ].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "satvalpicker" ], {Position = dim2(0, s * (items[ "saturation_holder" ].AbsoluteSize.X - items[ "satvalpicker" ].AbsoluteSize.X), 1, 1 - v * (items[ "saturation_holder" ].AbsoluteSize.Y - items[ "satvalpicker" ].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

                items[ "alpha_indicator" ]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))};
                
                items[ "colorpicker" ].BackgroundColor3 = Color
                items[ "colorpicker_inline" ].BackgroundColor3 = Color
                items[ "saturation_holder" ].BackgroundColor3 = hsv(h, 1, 1)

                items[ "hue_picker" ].BackgroundColor3 = hsv(h, 1, 1)
                items[ "alpha_picker" ].BackgroundColor3 = hsv(h, 1, 1 - a)
                items[ "satvalpicker" ].BackgroundColor3 = hsv(h, s, v)

                flags[cfg.flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local color = items[ "colorpicker" ].BackgroundColor3
                items[ "input" ].Text = string.format("%s, %s, %s, ", library:round(color.R * 255), library:round(color.G * 255), library:round(color.B * 255))
                items[ "input" ].Text ..= library:round(1 - a, 0.01)
                
                cfg.callback(Color, a)
            end
            
            function cfg.update_color() 
                local mouse = uis:GetMouseLocation() 
                local offset = vec2(mouse.X, mouse.Y - gui_offset) 

                if dragging_sat then	
                    s = math.clamp((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then
                    h = math.clamp((offset - items[ "hue_gradient" ].AbsolutePosition).X / items[ "hue_gradient" ].AbsoluteSize.X, 0, 1)
                elseif dragging_alpha then
                    a = 1 - math.clamp((offset - items[ "alpha_gradient" ].AbsolutePosition).X / items[ "alpha_gradient" ].AbsoluteSize.X, 0, 1)
                end

                cfg.set()
            end

            items[ "colorpicker" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 
                cfg.set_visible(cfg.open)            
            end)
            -- [MOBILE] touch
            items[ "colorpicker" ].TouchTap:Connect(function()
                cfg.open = not cfg.open 
                cfg.set_visible(cfg.open)
            end)

            uis.InputChanged:Connect(function(input)
                if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    cfg.update_color() 
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false
                end
            end)    

            items[ "alpha_gradient" ].MouseButton1Down:Connect(function()
                dragging_alpha = true 
            end)
            
            items[ "hue_gradient" ].MouseButton1Down:Connect(function()
                dragging_hue = true 
            end)
            
            items[ "sat" ].MouseButton1Down:Connect(function()
                dragging_sat = true  
            end)

            items[ "input" ].FocusLost:Connect(function()
                local text = items[ "input" ].Text
                local r, g, b, a = library:convert(text)
                
                if r and g and b and a then 
                    cfg.set(rgb(r, g, b), 1 - a)
                end 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
            
            cfg.set(cfg.color, cfg.alpha)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:textbox(options) 
            local cfg = {
                name = options.name or "TextBox",
                placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                default = options.default or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                visible = options.visible or true,
                items = {};
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                items[ "textbox" ] = library:create( "TextButton" , {
                    LayoutOrder = -1;
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 19);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "input" ] = library:create( "TextBox" , {
                    FontFace = fonts.font;
                    Text = "";
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    BorderSizePixel = 0;
                    PlaceholderColor3 = rgb(255, 255, 255);
                    CursorPosition = -1;
                    ClearTextOnFocus = false;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    TextColor3 = rgb(72, 72, 72);
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 30);
                    BackgroundColor3 = rgb(33, 33, 35)
                }); 

                library:create( "UICorner" , {
                    Parent = items[ "input" ];
                    CornerRadius = dim(0, 3)
                });                
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4);
                    PaddingRight = dim(0, 4)
                });
            end 
            
            function cfg.set(text) 
                flags[cfg.flag] = text

                items[ "input" ].Text = text

                cfg.callback(text)
            end 
            
            items[ "input" ]:GetPropertyChangedSignal("Text"):Connect(function()
                cfg.set(items[ "input" ].Text) 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
                
            if cfg.default then 
                cfg.set(cfg.default) 
            end

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:keybind(options) 
            local cfg = {
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                name = options.name or nil, 
                ignore_key = options.ignore or false, 

                key = options.key or nil, 
                mode = options.mode or "Toggle",
                active = options.default or false, 

                open = false,
                binding = nil, 

                hold_instances = {},
                items = {};
            }

            flags[cfg.flag] = {
                mode = cfg.mode,
                key = cfg.key, 
                active = cfg.active
            }

            local items = cfg.items; do 
                -- Component
                    items[ "keybind_element" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "keybind_holder" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = items[ "right_components" ];
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Size = dim2(0, 0, 0, 16);
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "keybind_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "key" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "LSHIFT";
                        Parent = items[ "keybind_holder" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "key" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });                                  
                -- 
                
                -- Mode Holder
                    items[ "dropdown" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library.items;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 0);
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "inline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown" ];
                        Size = dim2(1, 0, 1, 0);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "inline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "inline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    local options = {"Hold", "Toggle", "Always"}
                    
                    cfg.y_size = 20
                    for _, option in options do                        
                        local name = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(72, 72, 73);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = option;
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Size = dim2(0, 0, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.hold_instances[option] = name
                        library:apply_theme(name, "accent", "TextColor3")
                        
                        cfg.y_size += name.AbsoluteSize.Y

                        library:create( "UIPadding" , {
                            Parent = name;
                            PaddingTop = dim(0, 1);
                            PaddingRight = dim(0, 5);
                            PaddingLeft = dim(0, 5)
                        });

                        name.MouseButton1Click:Connect(function()
                            cfg.set(option)
                            cfg.set_visible(false)
                            cfg.open = false
                        end)
                        -- [MOBILE]
                        name.TouchTap:Connect(function()
                            cfg.set(option)
                            cfg.set_visible(false)
                            cfg.open = false
                        end)
                    end
                -- 
            end 
            
            function cfg.modify_mode_color(path)
                for _, v in cfg.hold_instances do 
                    v.TextColor3 = rgb(72, 72, 72)
                end 

                cfg.hold_instances[path].TextColor3 = themes.preset.accent
            end

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "Always" then
                    cfg.set(true)
                elseif mode == "Hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                cfg.modify_mode_color(mode)
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    cfg.active = input

                    if cfg.mode == "Always" then 
                        cfg.active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    cfg.key = input or "NONE"	
                elseif find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        cfg.active = true 
                    end 

                    cfg.mode = input
                    cfg.set_mode(cfg.mode) 
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
                    input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key

                    cfg.key = input.key or "NONE"
                    cfg.mode = input.mode or "Toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    cfg.set_mode(cfg.mode) 
                end 

                cfg.callback(cfg.active)

                local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))

                items[ "key" ].Text = __text

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
            end

            function cfg.set_visible(bool)
                local size = bool and cfg.y_size or 0
                library:tween(items[ "dropdown" ], {Size = dim_offset(items[ "keybind_holder" ].AbsoluteSize.X, size)})

                items[ "dropdown" ].Position = dim_offset(items[ "keybind_holder" ].AbsolutePosition.X, items[ "keybind_holder" ].AbsolutePosition.Y + items[ "keybind_holder" ].AbsoluteSize.Y + 60)
            end
        
            items[ "keybind_holder" ].MouseButton1Down:Connect(function()
                task.wait()
                items[ "key" ].Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            items[ "keybind_holder" ].MouseButton2Down:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then
                    local selected_key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType

                    if selected_key == cfg.key then 
                        if cfg.mode == "Toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "Hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)    

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "Hold" then 
                        cfg.set(false)
                    end
                end
            end)
            
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:button(options) 
            local cfg = {
                name = options.name or "TextBox",
                callback = options.callback or function() end,
                items = {};
            }
            
            local items = cfg.items; do 
                items[ "button_element" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "button_element" ];
                    Name = "\0";
                    Position = dim2(1, -4, 0, 0);
                    Size = dim2(1, -8, 0, 30);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "name" ], "accent", "BackgroundColor3");                            
            end 

            items[ "button" ].MouseButton1Click:Connect(function()
                cfg.callback()
                items[ "name" ].TextColor3 = themes.preset.accent 
                library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
            end)
            -- [MOBILE] touch
            items[ "button" ].TouchTap:Connect(function()
                cfg.callback()
                items[ "name" ].TextColor3 = themes.preset.accent
                library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
            end)
            
            return setmetatable(cfg, library)
        end 

        function library:settings(options)  
            local cfg = {
                open = false; 
                items = {}; 
                sanity = true;
            }

            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Visible = true;
                    Parent = library[ "items" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    ClipsDescendants = true;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(25, 25, 29)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "inline" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "fade" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "tick" ] = library:create( "ImageButton" , {
                    Image = "rbxassetid://128797200442698";
                    Name = "\0";
                    AutoButtonColor = false;
                    Parent = self.items[ "right_components" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 16, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                
            end 

            function cfg.set_visible(bool)                 
                library:tween(items[ "outline" ], {Size = dim_offset(bool and 240 or 0, 0)})
                items[ "outline" ].Position = dim_offset(items[ "tick" ].AbsolutePosition.X, items[ "tick" ].AbsolutePosition.Y + 90)
                library:close_element(cfg)
            end
            
            -- Only ONE handler — Tap fires both MouseButton1Click and TouchTap on mobile if duplicated
            items[ "tick" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 
                cfg.set_visible(cfg.open)
            end)

            return setmetatable(cfg, library)
        end 

        function library:list(properties) 
            local cfg = {
                items = {};
                options = properties.options or {"1", "2", "3"};
                flag = properties.flag or library:next_flag();    
                callback = properties.callback or function() end;
                data_store = {};        
                current_element;
            }

            local items = cfg.items; do
                items[ "list" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "list" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "list" ];
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });
            end 

            function cfg.refresh_options(options_to_refresh)
                for _,option in cfg.data_store do 
                    option:Destroy()
                end

                for _, option_data in options_to_refresh do 
                    local button = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "list" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); cfg.data_store[#cfg.data_store + 1] = button;

                    local name = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = option_data;
                        Parent = button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = button;
                        CornerRadius = dim(0, 3)
                    });     

                    button.MouseButton1Click:Connect(function()
                        local current = cfg.current_element 
                        if current and current ~= name then 
                            library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                        end

                        flags[cfg.flag] = option_data
                        cfg.callback(option_data)
                        library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                        cfg.current_element = name
                    end)
                    -- [MOBILE]
                    button.TouchTap:Connect(function()
                        local current = cfg.current_element 
                        if current and current ~= name then 
                            library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                        end

                        flags[cfg.flag] = option_data
                        cfg.callback(option_data)
                        library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                        cfg.current_element = name
                    end)

                    name.MouseEnter:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(140, 140, 140)})
                    end)

                    name.MouseLeave:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(72, 72, 72)})
                    end)
                end
            end

            cfg.refresh_options(cfg.options)

            return setmetatable(cfg, library)
        end 

        function library:init_config(window) 
            window:seperator({name = "Settings"})
            local main = window:tab({name = "Configs", tabs = {"Main"}})
            
            local column = main:column({})
            local section = column:section({name = "Configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
            config_holder = section:list({options = {"Report", "This", "Error", "To", "Finobe"}, callback = function(option) end, flag = "config_name_list"}); library:update_config_list()
            
            local column = main:column({})
            local section = column:section({name = "Settings", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
            section:textbox({name = "Config name:", flag = "config_name_text"})
            section:button({name = "Save", callback = function() writefile(library.directory .. "/configs/" .. flags["config_name_text"] or flags["config_name_list"] .. ".cfg", library:get_config()) library:update_config_list() notifications:create_notification({name = "Configs", info = "Saved config to:\n" .. flags["config_name_list"] or flags["config_name_text"]}) end}) 
            section:button({name = "Load", callback = function() library:load_config(readfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg"))  library:update_config_list() notifications:create_notification({name = "Configs", info = "Loaded config:\n" .. flags["config_name_list"]}) end})
            section:button({name = "Delete", callback = function() delfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg")  library:update_config_list() notifications:create_notification({name = "Configs", info = "Deleted config:\n" .. flags["config_name_list"]}) end})
            section:colorpicker({name = "Menu Accent", callback = function(color, alpha) library:update_theme("accent", color) end, color = themes.preset.accent})
            section:keybind({name = "Menu Bind", callback = function(bool) window.toggle_menu(bool) end, default = true})
        end
    --

    -- Notification Library
        function notifications:refresh_notifs() 
            local offset = 50

            for i, v in notifications.notifs do
                local Position = vec2(20, offset)
                library:tween(v, {Position = dim_offset(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function notifications:fade(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        library:tween(instance, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    library:tween(instance, {TextTransparency = fading})
                elseif instance:IsA("Frame") then
                    library:tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
                end
            end
        end 
        
        function notifications:create_notification(options)
            local cfg = {
                name = options.name or "This is a title!";
                info = options.info or "This is extra info!";
                lifetime = options.lifetime or 3;
                items = {};
                outline;
            }

            local items = cfg.items; do 
                items[ "notification" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = dim2(0, 210, 0, 53);
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    AnchorPoint = vec2(1, 0);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(10, 10, 12)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "notification" ];
                    Transparency = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 7, 0, 6);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "notification" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "info" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.info;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 9, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextWrapped = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 17);
                    PaddingRight = dim(0, 8);
                    Parent = items[ "info" ]
                });
                
                items[ "bar" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 8, 1, -6);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 5);
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "bar" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    PaddingRight = dim(0, 8);
                    Parent = items[ "notification" ]
                });
            end
            
            local index = #notifications.notifs + 1
            notifications.notifs[index] = items[ "notification" ]

            notifications:fade(items[ "notification" ], false)
            
            local offset = notifications:refresh_notifs()

            items[ "notification" ].Position = dim_offset(20, offset)

            library:tween(items[ "notification" ], {AnchorPoint = vec2(0, 0)}, Enum.EasingStyle.Quad, 1)
            library:tween(items[ "bar" ], {Size = dim2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

            task.spawn(function()
                task.wait(cfg.lifetime)
                
                notifications.notifs[index] = nil
                
                notifications:fade(items[ "notification" ], true)
                
                library:tween(items[ "notification" ], {AnchorPoint = vec2(1, 0)}, Enum.EasingStyle.Quad, 1)

                task.wait(1)
        
                items[ "notification" ]:Destroy() 
            end)
        end
    --
-- 

library.separator = library.seperator
library.seperator = library.seperator
return library

    end

    local ok, res = pcall(loadEmbeddedBloom)
    if ok and res then
        Library = res
    else
        warn("[bloom.gg] Embedded library error, falling back to local: " .. tostring(res))
        pcall(function()
            if isfile and isfile("Sleepy-Hub-UI-main/Library.lua") then
                Library = loadstring(readfile("Sleepy-Hub-UI-main/Library.lua"))()
            end
        end)
    end
end

if not Library then
    warn("[bloom.gg] Failed to initialize bloom.gg UI Library!")
    return
end

local window = Library:window({
    name        = "bloom",
    suffix      = ".gg 🌸",
    gameInfo    = "blossom hub",
    footer_left = "blossom hub",
    sub_info    = "",
    size        = UDim2.fromOffset(780, 505)
})
Library:update_theme("accent", Color3.fromRGB(255, 110, 190))

local menuVisible = true
local bloomGui = nil
local bloomConnections = {}
local feature_toggles = {}
local mobile_refresh = nil

local function add_connection(conn)
    table.insert(bloomConnections, conn)
    return conn
end

local function notify(info, name)
    pcall(function()
        Library.notifications:create_notification({
            name = name or "bloom.gg 🌸",
            info = tostring(info),
            lifetime = 4
        })
    end)
end

local function character_of(plr)
    return plr and plr.Character
end

local function root_of(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
end

local function humanoid_of(char)
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local rushToggle = nil
local rushDrop = nil
local rush_pending_reason = nil
local noclip_old = {}
local sky_state = nil
local currentEmote = nil
local currentEmoteAnim = nil
local lastHeadBoost = 0
local rushClock = 0

local function set_toggle(tog, v)
    if not tog then return end
    tog.enabled = v
    if tog.set then tog.set(v) end
end

-- ── sticky head (obi_stick v2) ────────────────────────────────────────────────
local function sticky_closest_player()
    local root = root_of(character_of(LocalPlayer))
    if not root then return nil end
    local range = flags.sticky_range or 35
    local nearest, best = nil, range
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer then
            local pc = character_of(plr)
            local pr = pc and root_of(pc)
            local ph = pc and humanoid_of(pc)
            if pr and ph and ph.Health > 0 then
                local d = (pr.Position - root.Position).Magnitude
                if d < best then best = d; nearest = plr end
            end
        end
    end
    return nearest
end

add_connection(RunService.RenderStepped:Connect(function(dt)
    if not flags.sticky_head then return end
    local char = character_of(LocalPlayer)
    local root = root_of(char)
    local hum = humanoid_of(char)
    if not root or not hum or hum.Health <= 0 then return end
    if hum.FloorMaterial ~= Enum.Material.Air then return end

    local target = sticky_closest_player()
    if not target then return end
    local tchar = character_of(target)
    local head = tchar and tchar:FindFirstChild("Head")
    if not head then return end

    local headPos = head.Position + Vector3.new(0, 1.6, 0)
    local offset  = headPos - root.Position
    local dist    = offset.Magnitude
    local vel     = root.AssemblyLinearVelocity
    local stick   = flags.sticky_stick or 2.0

    local flatTarget = Vector3.new(headPos.X, root.Position.Y, headPos.Z)
    local targetCF   = CFrame.lookAt(root.Position, flatTarget)
    local alpha      = math.clamp((flags.sticky_rot or 0.08) * 60 * dt, 0, 1)
    root.CFrame = root.CFrame:Lerp(targetCF, alpha)

    if dist > 2.5 then
        local desired = offset.Unit * ((flags.sticky_pull or 2.0) * 18)
        root.AssemblyLinearVelocity = vel:Lerp(
            Vector3.new(desired.X, vel.Y, desired.Z), flags.sticky_air or 0.16)
    end

    if dist <= 3 then
        local horizontal = Vector3.new(offset.X, 0, offset.Z)
        if horizontal.Magnitude > 0 then
            local added = horizontal.Unit * (stick * 5)
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(
                root.AssemblyLinearVelocity + added, 0.12)
        end
    end

    if dist <= 2 then
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(
            Vector3.new(offset.X * (stick * 5), root.AssemblyLinearVelocity.Y, offset.Z * (stick * 5)), 0.18)
    end

    if dist <= 1.2 then
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(
            Vector3.new(offset.X * (stick * 6), root.AssemblyLinearVelocity.Y, offset.Z * (stick * 6)), 0.15)
    end
end))

-- ── qb aimbot helpers ─────────────────────────────────────────────────────────
local cachedBall = nil
local ballScanClock = 0
local ballHolder = nil
local qbTarget = nil
local qbTargetClock = 0

local BALL_NAMES = { "Football", "football", "Ball", "ball", "NFLBall", "ProFootball", "FootBall" }

local function find_football()
    if cachedBall and cachedBall.Parent then return cachedBall end
    cachedBall = nil
    for _, name in ipairs(BALL_NAMES) do
        local f = Workspace:FindFirstChild(name, true)
        if f and f:IsA("BasePart") then
            cachedBall = f
            return cachedBall
        end
    end
    return nil
end

local function ball_is_held_by(ball, plr)
    if not ball or not ball.Parent or not plr then return false end
    local pc = plr.Character
    if not pc then return false end
    if ball:IsDescendantOf(pc) then return true end
    local tool = ball.Parent
    if tool and tool:IsA("Tool") and tool.Parent == pc then return true end
    return false
end

local function qb_predicted_target(root)
    local myTeam = LocalPlayer.Team
    if not myTeam then return nil end
    local lead = flags.qb_prediction or 0.35
    local best, bestScore = nil, -math.huge
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Team == myTeam then
            local pc = character_of(plr)
            local pr = pc and root_of(pc)
            local ph = pc and humanoid_of(pc)
            if pr and ph and ph.Health > 0 then
                local openness = 500
                for _, opp in Players:GetPlayers() do
                    if opp ~= plr and opp.Team ~= myTeam then
                        local oc = character_of(opp)
                        local oroot = oc and root_of(oc)
                        local ohum = oc and humanoid_of(oc)
                        if oroot and ohum and ohum.Health > 0 then
                            local d = (oroot.Position - pr.Position).Magnitude
                            if d < openness then openness = d end
                        end
                    end
                end
                local dist = (pr.Position - root.Position).Magnitude
                local score = openness * 2 - dist * 0.25
                if score > bestScore then bestScore = score; best = pr end
            end
        end
    end
    if not best then return nil end
    return best.Position + best.AssemblyLinearVelocity * lead
end

local TOUCHDOWN_KEYS = { "touchdown", "touch down", "endzone", "end zone", "score zone", "scoring zone", "try zone", "red zone" }

local function find_touchdown_zone()
    local local_team = LocalPlayer.Team
    local local_name = local_team and string.lower(local_team.Name) or ""
    local opp_name = ""
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer and p.Team and local_team and p.Team ~= local_team then
            opp_name = string.lower(p.Team.Name)
            break
        end
    end
    if opp_name == "" then
        for _, p in Players:GetPlayers() do
            if p ~= LocalPlayer and p.Team then
                opp_name = string.lower(p.Team.Name)
                break
            end
        end
    end
    local best, best_score
    for _, d in Workspace:GetDescendants() do
        if d:IsA("BasePart") and d.Size.X < 400 and d.Size.Z < 400 then
            local hay = string.lower(d.Name)
            if d.Parent then
                hay = hay .. " " .. string.lower(d.Parent.Name)
            end
            local matched = false
            for _, key in TOUCHDOWN_KEYS do
                if string.find(hay, key, 1, true) then
                    matched = true
                    break
                end
            end
            if matched then
                local score = 0
                if opp_name ~= "" and string.find(hay, opp_name, 1, true) then
                    score = score + 50
                end
                if local_name ~= "" and string.find(hay, local_name, 1, true) then
                    score = score - 50
                end
                if score == 0 then
                    if local_name ~= "" and string.find(hay, "opponent", 1, true) then
                        score = score + 40
                    end
                    if string.find(hay, "away", 1, true) or string.find(hay, "visitor", 1, true) then
                        score = score + 15
                    end
                    if string.find(hay, "home", 1, true) then
                        score = score - 10
                    end
                end
                if d.Size.Y <= 15 then
                    score = score + 1
                end
                if not best or score > best_score then
                    best, best_score = d, score
                end
            end
        end
    end
    return best
end

local function teleport_touchdown()
    local char = character_of(LocalPlayer)
    if not char then
        notify("tp to touchdown: no character")
        return
    end
    local zone = find_touchdown_zone()
    if not zone then
        notify("tp to touchdown: no touchdown zone found")
        return
    end
    local dest = zone.Position + Vector3.new(0, zone.Size.Y / 2 + 5, 0)
    char:PivotTo(CFrame.new(dest))
    notify("tp to touchdown: " .. zone.Name)
end

local SKY_LIGHT_PROPS = { "Ambient", "OutdoorAmbient", "ColorShift_Top", "ColorShift_Bottom", "FogColor", "Brightness", "ClockTime", "FogEnd", "FogStart" }

local function sky_enable(mode)
    if sky_state then sky_disable() end
    sky_state = { removed = {}, sky = nil, lights = {}, mode = mode or "gray" }
    for _, ch in Lighting:GetChildren() do
        if ch:IsA("Sky") or ch:IsA("Atmosphere") or ch:IsA("Clouds") then
            table.insert(sky_state.removed, ch)
            pcall(function() ch.Parent = nil end)
        end
    end
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        for _, ch in terrain:GetChildren() do
            if ch:IsA("Clouds") then
                table.insert(sky_state.removed, ch)
                pcall(function() ch.Parent = nil end)
            end
        end
    end
    local sky = Instance.new("Sky")
    sky.Name = sky_state.mode == "sakura" and "BloomSakuraSky" or "BloomGraySky"
    sky.SunTextureId = ""
    sky.MoonTextureId = ""
    sky.StarCount = 0
    sky.CelestialBodiesShown = false
    sky.SkyboxBk = ""
    sky.SkyboxDn = ""
    sky.SkyboxFt = ""
    sky.SkyboxLf = ""
    sky.SkyboxRt = ""
    sky.SkyboxUp = ""
    sky.Parent = Lighting
    sky_state.sky = sky
    if sky_state.mode == "sakura" then
        for _, prop in SKY_LIGHT_PROPS do
            sky_state.lights[prop] = Lighting[prop]
        end
        Lighting.Ambient = Color3.fromRGB(255, 190, 220)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 200, 225)
        Lighting.ColorShift_Top = Color3.fromRGB(255, 170, 210)
        Lighting.ColorShift_Bottom = Color3.fromRGB(255, 210, 230)
        Lighting.FogColor = Color3.fromRGB(255, 195, 222)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        local atmo = Instance.new("Atmosphere")
        atmo.Name = "BloomSakuraAtmosphere"
        atmo.Color = Color3.fromRGB(255, 180, 215)
        atmo.Decay = Color3.fromRGB(255, 205, 228)
        atmo.Density = 0.4
        atmo.Glare = 0
        atmo.Haze = 1.5
        atmo.Parent = Lighting
        sky_state.atmo = atmo
    end
end

local function sky_disable()
    if not sky_state then return end
    if sky_state.sky then
        pcall(function() sky_state.sky:Destroy() end)
    end
    if sky_state.atmo then
        pcall(function() sky_state.atmo:Destroy() end)
    end
    for prop, v in sky_state.lights do
        pcall(function() Lighting[prop] = v end)
    end
    for _, ch in sky_state.removed do
        if ch then
            pcall(function() ch.Parent = Lighting end)
        end
    end
    sky_state = nil
end

local STRETCH_BIND = "BloomStretchScreen"

local function stretch_enable()
    pcall(function() RunService:UnbindFromRenderStep(STRETCH_BIND) end)
    RunService:BindToRenderStep(STRETCH_BIND, Enum.RenderPriority.Camera.Value + 1, function()
        local cam = Workspace.CurrentCamera
        if cam then
            local f = flags.stretch_amount or 0.65
            cam.CFrame = cam.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, f, 0, 0, 0, 1)
        end
    end)
end

local function stretch_disable()
    pcall(function() RunService:UnbindFromRenderStep(STRETCH_BIND) end)
end

local function noclip_restore()
    for p, v in noclip_old do
        if p.Parent then
            pcall(function() p.CanCollide = v end)
        end
    end
    noclip_old = {}
end

local function clear_hitboxes()
    for _, inst in Workspace:GetDescendants() do
        if inst.Name == "BloomHeadHitbox" then
            pcall(function() inst:Destroy() end)
        end
    end
end

local function stop_emote()
    if currentEmote then
        pcall(function() currentEmote:Stop(0.15) end)
        currentEmote = nil
    end
    if currentEmoteAnim then
        pcall(function() currentEmoteAnim:Destroy() end)
        currentEmoteAnim = nil
    end
end

local function play_emote(asset_id)
    local char = character_of(LocalPlayer)
    local hum = humanoid_of(char)
    if not char or not hum then
        notify("emotes: no character")
        return
    end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end
    local ok, err = pcall(function()
        pcall(stop_emote)
        local anim = Instance.new("Animation")
        anim.AnimationId = asset_id:match("^rbxassetid://") and asset_id or ("rbxassetid://" .. tostring(asset_id))
        local track = animator:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action2
        track.Looped = false
        track:Play(0.05)
        currentEmote = track
        currentEmoteAnim = anim
    end)
    if not ok then
        notify("emotes: failed to play (" .. tostring(err) .. ")")
    end
end

local function is_target_down(plr)
    local c = character_of(plr)
    local h = humanoid_of(c)
    if not c or not h then return true end
    if h.Health <= 0 then return true end
    if h:GetState() == Enum.HumanoidStateType.Dead then return true end
    if h.PlatformStand then return true end
    if c:FindFirstChild("Downed") or c:FindFirstChild("Knocked") or c:FindFirstChild("Ragdoll") or c:FindFirstChild("KO") then
        return true
    end
    for _, attr in { "Downed", "Knocked", "DBNO", "Ragdoll", "IsDown" } do
        if plr:GetAttribute(attr) or c:GetAttribute(attr) then
            return true
        end
    end
    return false
end

local function rush_target_player()
    local sel = flags.rush_target
    if type(sel) == "string" and sel ~= "Nearest" and sel ~= "None" and #sel > 0 then
        local p = Players:FindFirstChild(sel)
        if p and p ~= LocalPlayer then
            return p
        end
    end
    local char = character_of(LocalPlayer)
    local root = root_of(char)
    if not root then return nil end
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer then
            local pc = character_of(p)
            if pc then
                if pc:FindFirstChild("Ball") or pc:FindFirstChildOfClass("Tool") and pc:FindFirstChildOfClass("Tool").Name:lower():find("ball") or p.Backpack:FindFirstChild("Ball") then
                    return p
                end
                if p:GetAttribute("HasBall") or pc:GetAttribute("HasBall") or p:GetAttribute("BallCarrier") then
                    return p
                end
                local tool = pc:FindFirstChildOfClass("Tool")
                if tool and (tool.Name:lower():find("ball") or tool:FindFirstChild("Handle")) then
                    -- often ball tools exist; also check if tool has ball part
                    if tool.Name:lower():find("ball") or tool:FindFirstChild("Ball") then
                        return p
                    end
                end
                -- generic: player holding something named ball
                for _, v in pc:GetChildren() do
                    if v.Name:lower():find("ball") then
                        return p
                    end
                end
            end
        end
    end
    local best, best_d
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer then
            local pr = root_of(character_of(p))
            if pr then
                local d = (pr.Position - root.Position).Magnitude
                if not best_d or d < best_d then
                    best, best_d = p, d
                end
            end
        end
    end
    return best
end

local function rush_dropdown_items()
    local list = { "Nearest" }
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

local function refresh_rush_dropdown()
    if not rushDrop or not rushDrop.refresh_options then return end
    local list = rush_dropdown_items()
    local cur = flags.rush_target
    local found = false
    for _, n in list do
        if n == cur then
            found = true
            break
        end
    end
    if not found then
        cur = "Nearest"
    end
    pcall(function()
        rushDrop.refresh_options(list)
        rushDrop.set(cur)
    end)
end

local function rush_stop(reason)
    rush_pending_reason = reason
    if rushToggle then
        set_toggle(rushToggle, false)
    end
    flags.autorush = false
end

local function make_toggle_feature(sec, opts)
    local tog, kb, pad
    local last_v = false
    tog = sec:toggle({
        name = opts.name,
        info = opts.info,
        flag = opts.flag,
        default = false,
        callback = function(v)
            if tog then tog.enabled = v end
            flags[opts.flag] = v
            if mobile_refresh then pcall(mobile_refresh, opts.flag) end
            local changed = v ~= last_v
            last_v = v
            if changed and opts.on_change then
                opts.on_change(v)
            end
            if kb and kb.active ~= v then kb.set(v) end
            if pad and pad.active ~= v then pad.set(v) end
        end
    })
    feature_toggles[opts.flag] = tog
    if opts.after then
        opts.after(tog)
    end
    local ready = false
    kb = sec:keybind({
        name = opts.name .. " - KB/M",
        flag = opts.flag .. "_kb",
        mode = "Toggle",
        default = false,
        callback = function(state)
            if ready and tog then
                tog.enabled = state == true
                tog.set(state == true)
            end
        end
    })
    pad = sec:keybind({
        name = opts.name .. " - controller",
        flag = opts.flag .. "_pad",
        mode = "Toggle",
        default = false,
        callback = function(state)
            if ready and tog then
                tog.enabled = state == true
                tog.set(state == true)
            end
        end
    })
    ready = true
    return tog, kb, pad
end

-- ── extra runtime state ───────────────────────────────────────────────────────
local ball_visual = { texture = nil, material = nil, color = nil, decals = {} }
local nameState = { fake = nil, clock = 0, conn = nil }
local hand_old = {}
local autoCatchClock = 0
local tackleClock = 0
local boostClock = 0
local ballVisualClock = 0
local noclipClock = 0
local hitboxClock = 0

-- ball: no texture + square box
local function ball_texture_off(ball)
    if not ball then return end
    if ball:IsA("MeshPart") and ball_visual.texture == nil then
        ball_visual.texture = ball.TextureID
        pcall(function() ball.TextureID = "" end)
    end
    if ball_visual.material == nil then ball_visual.material = ball.Material end
    if ball_visual.color == nil then ball_visual.color = ball.Color end
    pcall(function()
        ball.Material = Enum.Material.SmoothPlastic
        ball.Color = Color3.fromRGB(240, 240, 240)
    end)
    for _, ch in ball:GetChildren() do
        if ch:IsA("Decal") or ch:IsA("Texture") then
            table.insert(ball_visual.decals, ch)
            pcall(function() ch.Parent = nil end)
        end
    end
end

local function ball_texture_restore(ball)
    if ball then
        if ball_visual.texture ~= nil and ball:IsA("MeshPart") then
            pcall(function() ball.TextureID = ball_visual.texture end)
        end
        if ball_visual.material then pcall(function() ball.Material = ball_visual.material end) end
        if ball_visual.color then pcall(function() ball.Color = ball_visual.color end) end
        for _, ch in ball_visual.decals do
            if ch then pcall(function() ch.Parent = ball end) end
        end
    end
    ball_visual.texture = nil
    ball_visual.material = nil
    ball_visual.color = nil
    ball_visual.decals = {}
end

local function ball_box_on(ball)
    if not ball or ball:FindFirstChild("BloomBallBox") then return end
    local sb = Instance.new("SelectionBox")
    sb.Name = "BloomBallBox"
    sb.Color3 = Color3.fromRGB(255, 110, 190)
    sb.LineThickness = 0.15
    sb.SurfaceTransparency = 1
    sb.Adornee = ball
    sb.Parent = ball
end

local function ball_box_off(ball)
    local found = {}
    if ball and ball:FindFirstChild("BloomBallBox") then
        table.insert(found, ball.BloomBallBox)
    end
    for _, inst in Workspace:GetDescendants() do
        if inst.Name == "BloomBallBox" then
            table.insert(found, inst)
        end
    end
    for _, inst in found do
        pcall(function() inst:Destroy() end)
    end
end

-- particle effects: player / ball (fire, water, sakura)
local FX_PRESETS = {
    fire = {
        color = ColorSequence.new(Color3.fromRGB(255, 120, 30), Color3.fromRGB(255, 220, 60)),
        size = NumberSequence.new(1.4, 0.2), speed = NumberRange.new(4, 8),
        rate = 55, life = NumberRange.new(0.45, 0.9), light = 2
    },
    water = {
        color = ColorSequence.new(Color3.fromRGB(120, 190, 255), Color3.fromRGB(50, 110, 220)),
        size = NumberSequence.new(0.9, 0.3), speed = NumberRange.new(3, 6),
        rate = 45, life = NumberRange.new(0.4, 0.8), light = 0
    },
    sakura = {
        color = ColorSequence.new(Color3.fromRGB(255, 185, 220), Color3.fromRGB(255, 120, 180)),
        size = NumberSequence.new(0.8, 0.5), speed = NumberRange.new(1, 3),
        rate = 35, life = NumberRange.new(1.5, 3), light = 0
    }
}

local function ensure_emitter(parent, key)
    if not parent then return end
    if parent:FindFirstChild("BloomFx_" .. key) then return end
    local preset = FX_PRESETS[key]
    if not preset then return end
    local att = Instance.new("Attachment")
    att.Name = "BloomFx_" .. key
    att.Parent = parent
    local pe = Instance.new("ParticleEmitter")
    pe.Name = "BloomFxParticles"
    pe.Color = preset.color
    pe.Size = preset.size
    pe.Speed = preset.speed
    pe.Rate = preset.rate
    pe.Lifetime = preset.life
    pe.LightEmission = preset.light
    pe.SpreadAngle = Vector2.new(180, 180)
    pe.Parent = att
end

local function remove_emitter(parent, key)
    if not parent then return end
    local att = parent:FindFirstChild("BloomFx_" .. key)
    if att then pcall(function() att:Destroy() end) end
end

local function sync_fx(parent, prefix)
    if not parent then return end
    for key in FX_PRESETS do
        if flags[prefix .. "_" .. key] then
            ensure_emitter(parent, key)
        else
            remove_emitter(parent, key)
        end
    end
end

local function clear_fx(parent)
    if not parent then return end
    for key in FX_PRESETS do
        remove_emitter(parent, key)
    end
end

-- weather: rain, storm, thunder, snow
local weather = { rain = nil, snow = nil, storm = false, lights = nil, conn = nil, thunderOn = false, alive = true }

local function weather_follow()
    if weather.conn then return end
    weather.conn = RunService.RenderStepped:Connect(function()
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local pos = cam.CFrame.Position + Vector3.new(0, 25, 0)
        if weather.rain and weather.rain.Parent then weather.rain.CFrame = CFrame.new(pos) end
        if weather.snow and weather.snow.Parent then weather.snow.CFrame = CFrame.new(pos) end
    end)
end

local function weather_part(name)
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Transparency = 1
    part.Size = Vector3.new(240, 1, 240)
    part.Parent = Workspace
    return part
end

local function weather_rain_on()
    if weather.rain then return end
    local part = weather_part("BloomRain")
    local att = Instance.new("Attachment")
    att.Parent = part
    local pe = Instance.new("ParticleEmitter")
    pe.Name = "BloomRainParticles"
    pe.Color = ColorSequence.new(Color3.fromRGB(170, 200, 255))
    pe.Transparency = NumberSequence.new(0.35)
    pe.Size = NumberSequence.new(0.6)
    pe.Lifetime = NumberRange.new(0.5, 0.9)
    pe.Rate = 220
    pe.Speed = NumberRange.new(70, 95)
    pe.SpreadAngle = Vector2.new(4, 4)
    pe.EmissionDirection = Enum.NormalId.Bottom
    pe.Parent = att
    weather.rain = part
    weather_follow()
end

local function weather_snow_on()
    if weather.snow then return end
    local part = weather_part("BloomSnow")
    local att = Instance.new("Attachment")
    att.Parent = part
    local pe = Instance.new("ParticleEmitter")
    pe.Name = "BloomSnowParticles"
    pe.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    pe.Size = NumberSequence.new(0.7)
    pe.Lifetime = NumberRange.new(4, 7)
    pe.Rate = 70
    pe.Speed = NumberRange.new(3, 7)
    pe.SpreadAngle = Vector2.new(25, 25)
    pe.EmissionDirection = Enum.NormalId.Bottom
    pe.Parent = att
    weather.snow = part
    weather_follow()
end

local function weather_off(key)
    local part = weather[key]
    if part then pcall(function() part:Destroy() end) end
    weather[key] = nil
    if not weather.rain and not weather.snow then
        if weather.conn then pcall(function() weather.conn:Disconnect() end) end
        weather.conn = nil
    end
end

local function storm_on()
    if weather.storm then return end
    weather.lights = {}
    for _, prop in { "Brightness", "ClockTime", "FogColor", "FogEnd", "Ambient", "OutdoorAmbient" } do
        weather.lights[prop] = Lighting[prop]
    end
    Lighting.Brightness = 0.6
    Lighting.ClockTime = 17
    Lighting.FogColor = Color3.fromRGB(70, 75, 85)
    Lighting.FogEnd = 600
    Lighting.Ambient = Color3.fromRGB(60, 62, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(75, 78, 88)
    weather.storm = true
end

local function storm_off()
    if not weather.storm then return end
    if weather.lights then
        for prop, v in weather.lights do
            pcall(function() Lighting[prop] = v end)
        end
    end
    weather.lights = nil
    weather.storm = false
end

task.spawn(function()
    while weather.alive do
        task.wait(math.random(30, 90) / 10)
        if weather.thunderOn and weather.alive then
            for _ = 1, 2 do
                local a, o = Lighting.Ambient, Lighting.OutdoorAmbient
                pcall(function()
                    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                end)
                task.wait(0.06)
                pcall(function()
                    Lighting.Ambient = a
                    Lighting.OutdoorAmbient = o
                end)
                task.wait(0.12)
            end
        end
    end
end)

-- name changer: rewrite the displayed (client-side) name
local function rewrite_fake_name()
    local fake = nameState.fake
    if not fake or fake == "" then return end
    local real = LocalPlayer.Name
    local disp = LocalPlayer.DisplayName
    local function scan(root)
        if not root then return end
        for _, d in root:GetDescendants() do
            if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                if d.Text == real or (disp and disp ~= "" and d.Text == disp) then
                    d.Text = fake
                end
            elseif d:IsA("TextValue") then
                if d.Value == real or (disp and disp ~= "" and d.Value == disp) then
                    d.Value = fake
                end
            end
        end
    end
    pcall(scan, LocalPlayer.Character)
    pcall(scan, LocalPlayer.PlayerGui)
    local core = (gethui and gethui()) or game:GetService("CoreGui")
    pcall(scan, core)
    pcall(scan, game:GetService("StarterGui"))
end

local function name_changer_apply(fake)
    nameState.fake = fake
    pcall(function() LocalPlayer.DisplayName = fake end)
    pcall(function()
        local hum = humanoid_of(character_of(LocalPlayer))
        if hum then hum.DisplayName = fake end
    end)
    if not nameState.conn then
        nameState.conn = add_connection(RunService.Heartbeat:Connect(function(dt)
            if not nameState.fake then return end
            nameState.clock = nameState.clock + dt
            if nameState.clock < 1 then return end
            nameState.clock = 0
            rewrite_fake_name()
        end))
    end
    rewrite_fake_name()
end

-- tackle / reach helpers
local function nearest_opponent(range)
    local root = root_of(character_of(LocalPlayer))
    if not root then return nil, nil end
    local myTeam = LocalPlayer.Team
    local best, bestRoot, bestD = nil, nil, range
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and (myTeam == nil or plr.Team ~= myTeam) then
            local pc = character_of(plr)
            local pr = pc and root_of(pc)
            local ph = pc and humanoid_of(pc)
            if pr and ph and ph.Health > 0 then
                local d = (pr.Position - root.Position).Magnitude
                if d < bestD then bestD = d; best = plr; bestRoot = pr end
            end
        end
    end
    return best, bestRoot
end

local function reach_apply(on)
    local char = character_of(LocalPlayer)
    if not char then return end
    local size = flags.reach_size or 3
    for _, name in { "RightHand", "LeftHand", "RightLowerArm", "LeftLowerArm" } do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") then
            if hand_old[p] == nil then hand_old[p] = p.Size end
            if on then
                local o = hand_old[p]
                pcall(function() p.Size = Vector3.new(o.X + size, o.Y + size, o.Z + size) end)
            else
                pcall(function() p.Size = hand_old[p] end)
            end
        end
    end
    if not on then hand_old = {} end
end

-- emotes (R15 PlayEmote via HumanoidDescription)
local EMOTES = {
	{ name = "BBS",         id = "rbxassetid://83690407262789",  speed = 1.25 },
	{ name = "BOP",         id = "rbxassetid://8028669437",      speed = 1    },
	{ name = "Hackers",     id = "rbxassetid://10714364213",     speed = 1    },
	{ name = "HD",          id = "rbxassetid://133666867152446", speed = 1    },
	{ name = "TTL",         id = "rbxassetid://125578981255289", speed = 1    },
	{ name = "NH",          id = "rbxassetid://83345430870757",  speed = 1    },
	{ name = "CCL",         id = "rbxassetid://107875941017127", speed = 1    },
	{ name = "Penguin",     id = "rbxassetid://5439075558",      speed = 1    },
	{ name = "Worm",        id = "rbxassetid://133640711863790", speed = 1    },
	{ name = "Griddy",      id = "rbxassetid://8028694339",      speed = 1    },
	{ name = "Sam Slash",   id = "rbxassetid://15249657798",     speed = 1    },
	{ name = "Dimension",   id = "rbxassetid://5618747341",      speed = 1    },
	{ name = "Ballspin",    id = "rbxassetid://14215798544",     speed = 1    },
	{ name = "Thug",        id = "rbxassetid://13550466835",     speed = 1    },
	{ name = "Inner Child", id = "rbxassetid://14215788817",     speed = 1    },
	{ name = "Sturdy",      id = "rbxassetid://14215791622",     speed = 1    },
	{ name = "Smith Knicks",id = "rbxassetid://15312473847",     speed = 1    },
	{ name = "Mop",         id = "rbxassetid://14215807283",     speed = 1    },
	{ name = "MPG",         id = "rbxassetid://14138482621",     speed = 1    },
	{ name = "Moon",        id = "rbxassetid://14216002323",     speed = 1    },
	{ name = "Eagle Flap",  id = "rbxassetid://2293380203",      speed = 1    },
	{ name = "PPJT",        id = "rbxassetid://5433555683",      speed = 1    },
	{ name = "Headless",    id = "rbxassetid://5704065738",      speed = 1    },
	{ name = "Druski",      id = "rbxassetid://14901504235",     speed = 1    },
	{ name = "Keep it hot", id = "http://www.roblox.com/asset/?id=85267023718407", speed = 1 },
	{ name = "Silencer",    id = "rbxassetid://15249654202",     speed = 1    },
	{ name = "Reanimated",  id = "rbxassetid://2293388847",      speed = 1    },
	{ name = "Money Hop Switch", id = "rbxassetid://132555082396072", speed = 1 },
	{ name = "Turbulence",  id = "rbxassetid://13643188123",     speed = 1    },
}

local function play_named_emote(emoteName, emoteId, speed)
    local char = character_of(LocalPlayer)
    local hum = humanoid_of(char)
    if not char or not hum then
        notify("emotes: no character")
        return
    end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end
    local idStr = tostring(emoteId)
    local digits = idStr:match("(%d+)")
    if not digits then
        notify("emotes: bad id for " .. tostring(emoteName))
        return
    end
    pcall(stop_emote)
    local ok, err = pcall(function()
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. digits
        local track = animator:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action2
        track.Looped = true
        track:Play(0.05)
        track:AdjustSpeed(tonumber(speed) or 1)
        currentEmote = track
        currentEmoteAnim = anim
    end)
    if not ok then
        notify("emotes: could not play " .. tostring(emoteName) .. " (" .. tostring(err) .. ")")
    end
end

-- clothing changer + accessory loader
local function to_asset_id(v)
    if not v or v == "" then return "" end
    local s = tostring(v)
    if s:match("^rbxassetid://%d+") then return s end
    local digits = s:match("(%d+)")
    return digits and ("rbxassetid://" .. digits) or ""
end

local function ensure_wearable(char, class, name)
    local inst = char:FindFirstChild(name)
    if inst and not inst:IsA(class) then
        pcall(function() inst:Destroy() end)
        inst = nil
    end
    if not inst then
        inst = Instance.new(class)
        inst.Name = name
        inst.Parent = char
    end
    return inst
end

local function apply_clothing(shirt, pants, tshirt)
    local char = character_of(LocalPlayer)
    if not char then notify("clothing: no character") return end
    local sid, pid, tid = to_asset_id(shirt), to_asset_id(pants), to_asset_id(tshirt)
    if sid ~= "" then ensure_wearable(char, "Shirt", "BloomShirt").ShirtTemplate = sid end
    if pid ~= "" then ensure_wearable(char, "Pants", "BloomPants").PantsTemplate = pid end
    if tid ~= "" then ensure_wearable(char, "ShirtGraphic", "BloomTShirt").Graphic = tid end
    notify("clothing applied")
end

local function http_get_body(url)
    if not url then return nil end
    local ok, body = pcall(function()
        if syn and syn.request then
            local r = syn.request({ Url = url, Method = "GET" })
            return r and r.Body
        elseif http_request then
            local r = http_request({ Url = url, Method = "GET" })
            return r and r.Body
        elseif request then
            local r = request({ Url = url, Method = "GET" })
            return r and r.Body
        elseif http and http.request then
            local r = http.request({ Url = url, Method = "GET" })
            return r and r.Body
        elseif game.HttpGet then
            return game:HttpGet(url)
        end
        return nil
    end)
    if ok then return body end
    return nil
end

local function load_asset_model(id)
    local num = tonumber(tostring(id):match("(%d+)"))
    if not num then return nil end
    local ok, model = pcall(function() return InsertService:LoadAsset(num) end)
    if ok and model then return model end
    local body = http_get_body("https://assetdelivery.roblox.com/v1/asset/?id=" .. num)
    if not body then
        local meta = http_get_body("https://assetdelivery.roblox.com/v2/assetId/" .. num)
        if meta then
            local loc = tostring(meta):match('"location":"([^"]+)"')
            if loc then
                body = http_get_body((loc:gsub("&amp;", "&")))
            end
        end
    end
    if body and #body > 0 then
        local ok2, model2 = pcall(function() return InsertService:LoadLocalAsset(body) end)
        if ok2 and model2 then return model2 end
    end
    return nil
end

local function collect_wearables(root, out)
    for _, inst in ipairs(root:GetChildren()) do
        if inst:IsA("Accessory") then
            table.insert(out, inst)
        elseif inst:IsA("BasePart") then
            table.insert(out, inst)
        elseif inst:IsA("Model") or inst:IsA("Folder") then
            collect_wearables(inst, out)
        end
    end
end

local function attach_head_part(part, char)
    local head = char:FindFirstChild("Head")
    if not head then return false end
    pcall(function()
        part.Anchored = false
        part.CanCollide = false
        part.Massless = true
        part.CFrame = head.CFrame * CFrame.new(0, 0.5, 0)
        local weld = Instance.new("WeldConstraint")
        weld.Name = "BloomAccWeld"
        weld.Part0 = head
        weld.Part1 = part
        weld.Parent = part
    end)
    return true
end

local function add_accessory(id)
    local char = character_of(LocalPlayer)
    if not char then notify("accessory: no character") return end
    local num = tonumber(tostring(id):match("(%d+)"))
    if not num then notify("accessory: bad id") return end
    local model = load_asset_model(num)
    if not model then
        notify("accessory: failed to load " .. num)
        return
    end
    local items = {}
    collect_wearables(model, items)
    local count = 0
    for _, inst in ipairs(items) do
        if inst:IsA("Accessory") then
            inst.Parent = char
            count = count + 1
        elseif inst:IsA("BasePart") then
            if attach_head_part(inst, char) then
                inst.Parent = char
                count = count + 1
            end
        end
    end
    if count > 0 then
        notify("accessory added: " .. num)
    else
        notify("accessory: nothing usable in " .. num)
    end
end

local ACCESSORY_PRESETS = {
    { name = "Sub-Commando", id = 129806646203761 },
    { name = "Lava Hair", id = 113527009413079 },
    { name = "Pilgrim Hat", id = 1223149 }
}

-- cosmetics (items) from Inferno hub
local ITEMS = {
    Coldstare    = { mesh = "rbxassetid://5028704943",     texture = "rbxassetid://5047708728",     parent = "UpperTorso", scale = Vector3.new(1,1,1),          offset = CFrame.new(0,0.15,0.65)    * CFrame.Angles(0,math.rad(180),0) },
    DesertVest   = { mesh = "rbxassetid://11755494017",    texture = "rbxassetid://11755494031",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05) },
    DRC          = { mesh = "rbxassetid://6541224713",     texture = "rbxassetid://7833727918",     parent = "Head",       scale = Vector3.new(1.01,1.01,1.01),  offset = CFrame.new(0,0.8,0.15)     * CFrame.Angles(0,math.rad(90),0)  },
    DesignerKeff = { mesh = "rbxassetid://14156626934", texture = "rbxassetid://14156781317", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.05,0.41,0.15) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
    PinkScene    = { mesh = "rbxassetid://73581570515279", texture = "rbxassetid://86617487565011", parent = "Head",       scale = Vector3.new(0.95,0.95,0.95),  offset = CFrame.new(-0.1,0.1,0.2)   * CFrame.Angles(0,math.rad(180),0) },
    SeeingStars  = { mesh = "rbxassetid://62139052",       texture = "rbxassetid://62139103",       parent = "Head",       scale = Vector3.new(1.05,1.05,1.05),  offset = CFrame.new(0,0.05,-0.45) },
    SubarcticCommando = { mesh = "http://www.roblox.com/asset/?id=39200112", texture = "http://www.roblox.com/asset/?id=39200088", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.15,0) },
    TacticalVest = { mesh = "rbxassetid://11754584493",    texture = "rbxassetid://11754584535",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05)      * CFrame.Angles(0,math.rad(180),0) },
    WhiteTowel   = { mesh = "rbxassetid://6919149797",     texture = "rbxassetid://6923948446",     parent = "LowerTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0.55,-0.65,-0.15)*CFrame.Angles(0,math.rad(90),0) },
    LavaScene    = { mesh = "http://www.roblox.com/asset/?id=83490415", texture = "http://www.roblox.com/asset/?id=83491029", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.1,0.1,0.2) },
    KingCape     = { mesh = "rbxassetid://7547683590",     texture = "rbxassetid://7547692544",     parent = "UpperTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0,-0.85,0.7) },
    KingCrown    = { mesh = "rbxassetid://2180251969",     texture = "rbxassetid://2180251094",     parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,1,0) },
    GravBeanie   = { mesh = "rbxassetid://14310737075",    texture = "rbxassetid://15591009630",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0.05)) },
    LAchrome     = { mesh = "rbxassetid://15498987026",    texture = "rbxassetid://15498997319",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,-0.2) },
    Ush          = { mesh = "rbxassetid://12710398184",    texture = "rbxassetid://12710399814",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.3,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
    RedCW        = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://1143320126",  parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
    BlackCW      = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "http://www.roblox.com/asset/?id=1577349", parent = "Head", scale = Vector3.new(1,1.3,1), offset = CFrame.new(0,0.25,-0.19) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
    PurpleCW     = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://14296191274", parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
    PoliceVest = { mesh = "rbxassetid://10692364338", texture = "rbxassetid://10691986674", parent = "UpperTorso", scale = Vector3.new(0.8,1.1,0.8), offset = CFrame.new(0,-0.05,0) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
    ArcTacVest = { mesh = "rbxassetid://10714316724", texture = "rbxassetid://10714600858", parent = "UpperTorso", scale = Vector3.new(0.7,1,0.8), offset = CFrame.new(0,0,-0.1) },
    ArticCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=38965529", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
    GreyEvil = { mesh = "rbxassetid://14470653457", texture = "rbxassetid://14473920427", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.41,0.1) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
    PilgrimHat = { mesh = "http://www.roblox.com/asset/?id=1223118", texture = "http://www.roblox.com/asset/?id=5671898", parent = "Head", scale = Vector3.new(1.7,1.7,1.7), offset = CFrame.new(0,1,0) },
    y2kbluebeanie = { mesh = "rbxassetid://13870642930", texture = "rbxassetid://13870661669", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.9,0) },
    MonochromeMilitary = { mesh = "http://www.roblox.com/asset/?id=192571937 ", texture = "http://www.roblox.com/asset/?id=192571951 ", parent = "Head", scale = Vector3.new(1.4,1.4,1.4), offset = CFrame.new(0,0.4,0) },
    MidnightCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=259417739", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
    GasMask = { mesh = "rbxassetid://8928474817", texture = "rbxassetid://8927755382", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
    Snorkel = { mesh = "http://www.roblox.com/asset/?id=10547596", texture = "http://www.roblox.com/asset/?id=10517820", parent = "Head", scale = Vector3.new(1.05,1.05,1.05), offset = CFrame.new(0,0.2,0) },
}

local CLOTHES = {
    { name = "All Star Shirt",  type = "shirt", id = "rbxassetid://104603634169771" },
    { name = "All Star Shorts", type = "pants", id = "rbxassetid://73939866847703"  },
    { name = "Black World Tour Shirt", type = "shirt", id = "rbxassetid://15335037852" },
    { name = "Pink World Tour Shirt", type = "shirt", id = "rbxassetid://15334978300" },
    { name = "King Shirt", type = "shirt", id = "rbxassetid://6296265575" },
    { name = "King Pants", type = "pants", id = "rbxassetid://10725550576" },
    { name = "Grey Flare", type = "shirt", id = "rbxassetid://15345367906" },
    { name = "Black Flare", type = "shirt", id = "rbxassetid://15345348842" },
    { name = "Red Flare", type = "shirt", id = "rbxassetid://15345347397" },
    { name = "Acid Flare", type = "shirt", id = "rbxassetid://15345352095" },
    { name = "Pastel Flare", type = "shirt", id = "rbxassetid://15345355082" },
    { name = "Orange Flare", type = "shirt", id = "rbxassetid://15345357354" },
    { name = "White World Tour", type = "shirt", id = "rbxassetid://15334975460" },
    { name = "Hooded Jean Jacket", type = "shirt", id = "rbxassetid://15334917844" },
}

local equipped_items = {}

local function equip_item(name)
    if equipped_items[name] then return end
    local data = ITEMS[name]
    if not data then return end
    local c = character_of(LocalPlayer)
    if not c then return end
    local parentPart = c:FindFirstChild(data.parent)
    if not parentPart then return end
    local part = Instance.new("Part")
    part.Name = name
    part.Size = Vector3.new(1,1,1)
    part.CanCollide = false
    part.Massless = true
    part.Parent = c
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = data.mesh
    mesh.TextureId = data.texture
    mesh.Scale = data.scale
    mesh.Parent = part
    local weld = Instance.new("Motor6D")
    weld.Part0 = parentPart
    weld.Part1 = part
    weld.C0 = data.offset
    weld.Parent = parentPart
    part.CFrame = parentPart.CFrame * data.offset
    equipped_items[name] = part
end

local function unequip_item(name)
    if equipped_items[name] then
        pcall(function() equipped_items[name]:Destroy() end)
        equipped_items[name] = nil
    end
end

local function unequip_all_items()
    for name in pairs(equipped_items) do unequip_item(name) end
    equipped_items = {}
end

local function apply_cloth_entry(entry)
    if not entry then return false end
    if entry.type == "shirt" then
        return apply_clothing(entry.id, nil, nil)
    elseif entry.type == "pants" then
        return apply_clothing(nil, entry.id, nil)
    end
    return false
end

-- potato graphics: strip every texture / effect for max fps
local potato_state = nil

local function potato_strip_one(inst, state)
    if not inst then return end
    pcall(function()
        if inst:IsA("Decal") or inst:IsA("Texture") then
            if inst.Transparency < 1 then
                table.insert(state.changed, { inst, "Transparency", inst.Transparency })
                inst.Transparency = 1
            end
        elseif inst:IsA("MeshPart") then
            if inst.TextureID ~= "" then
                table.insert(state.changed, { inst, "TextureID", inst.TextureID })
                inst.TextureID = ""
            end
        elseif inst:IsA("SurfaceAppearance") then
            if inst.Parent then
                table.insert(state.changed, { inst, "Parent", inst.Parent })
                inst.Parent = nil
            end
        elseif inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Beam")
            or inst:IsA("Fire") or inst:IsA("Smoke") or inst:IsA("Sparkles") then
            if inst.Enabled then
                table.insert(state.changed, { inst, "Enabled", true })
                inst.Enabled = false
            end
        elseif inst:IsA("Light") then
            if inst.Enabled then
                table.insert(state.changed, { inst, "Enabled", true })
                inst.Enabled = false
            end
        elseif inst:IsA("Sky") or inst:IsA("Atmosphere") or inst:IsA("Clouds") then
            if inst.Parent then
                table.insert(state.changed, { inst, "Parent", inst.Parent })
                inst.Parent = nil
            end
        elseif inst:IsA("Shirt") then
            if inst.ShirtTemplate ~= "" then
                table.insert(state.changed, { inst, "ShirtTemplate", inst.ShirtTemplate })
                inst.ShirtTemplate = ""
            end
        elseif inst:IsA("Pants") then
            if inst.PantsTemplate ~= "" then
                table.insert(state.changed, { inst, "PantsTemplate", inst.PantsTemplate })
                inst.PantsTemplate = ""
            end
        elseif inst:IsA("ShirtGraphic") then
            if inst.Graphic ~= "" then
                table.insert(state.changed, { inst, "Graphic", inst.Graphic })
                inst.Graphic = ""
            end
        elseif inst:IsA("BasePart") then
            if inst.Material ~= Enum.Material.SmoothPlastic then
                table.insert(state.changed, { inst, "Material", inst.Material })
                inst.Material = Enum.Material.SmoothPlastic
            end
            if inst.Reflectance > 0 then
                table.insert(state.changed, { inst, "Reflectance", inst.Reflectance })
                inst.Reflectance = 0
            end
        end
    end)
end

local POTATO_LIGHT_PROPS = {
    "Ambient", "OutdoorAmbient", "Brightness", "ClockTime",
    "EnvironmentDiffuseScale", "EnvironmentSpecularScale",
    "GlobalShadows", "FogEnd", "FogColor", "FogStart"
}

local function potato_enable()
    if potato_state then return end
    potato_state = { changed = {}, lighting = {} }
    for _, prop in ipairs(POTATO_LIGHT_PROPS) do
        potato_state.lighting[prop] = Lighting[prop]
    end
    pcall(function()
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.FogEnd = 100000
    end)
    for _, inst in ipairs(Workspace:GetDescendants()) do
        potato_strip_one(inst, potato_state)
    end
    pcall(function()
        potato_state.conn = Workspace.DescendantAdded:Connect(function(inst)
            if potato_state then
                potato_strip_one(inst, potato_state)
            end
        end)
    end)
end

local function potato_restore()
    if not potato_state then return end
    if potato_state.conn then pcall(function() potato_state.conn:Disconnect() end) end
    for i = #potato_state.changed, 1, -1 do
        local e = potato_state.changed[i]
        pcall(function()
            local inst, prop, value = e[1], e[2], e[3]
            if not inst then return end
            if prop == "Parent" then
                if inst.Parent == nil and value then inst.Parent = value end
            else
                inst[prop] = value
            end
        end)
    end
    for prop, v in potato_state.lighting do
        pcall(function() Lighting[prop] = v end)
    end
    potato_state = nil
end

if UI_ONLY then
    local function dummy_element()
        return setmetatable({}, {
            __index = function() return function() end end,
            __newindex = function() end
        })
    end
    for _, m in ipairs({ "toggle", "slider", "button", "textbox", "dropdown", "list", "colorpicker", "keybind" }) do
        Library[m] = function() return dummy_element() end
    end
end

window:seperator({ name = "features" })

local mainPage = window:tab({
    name = "main",
    icon = "rbxassetid://10723415766",
    tabs = { "main" }
})

do
    local col1 = mainPage:column({})
    local secMove = col1:section({ name = "movement", size = 1, default = true, icon = "rbxassetid://10723415766" })

    make_toggle_feature(secMove, {
        name = "Headboost",
        flag = "headboost",
        info = "landing on another player's head launches you upward",
        after = function()
            secMove:slider({
                name = "boost power",
                min = 50,
                max = 600,
                interval = 5,
                default = 250,
                flag = "headboost_power",
                callback = function(v) flags.headboost_power = v end
            })
        end
    })

    make_toggle_feature(secMove, {
        name = "Sticky Head",
        flag = "sticky_head",
        info = "auto turns and pulls you toward the nearest player while airborne",
        on_change = function(v)
            notify(v and "sticky head: on" or "sticky head: off")
        end,
        after = function()
            secMove:slider({
                name = "search range",
                min = 5,
                max = 80,
                interval = 1,
                default = 35,
                suffix = " studs",
                flag = "sticky_range",
                callback = function(v) flags.sticky_range = v end
            })
            secMove:slider({
                name = "pull strength",
                min = 10,
                max = 40,
                interval = 1,
                default = 20,
                flag = "sticky_pull",
                callback = function(v) flags.sticky_pull = v / 10 end
            })
            secMove:slider({
                name = "stickiness",
                min = 10,
                max = 40,
                interval = 1,
                default = 20,
                flag = "sticky_stick",
                callback = function(v) flags.sticky_stick = v / 10 end
            })
            secMove:slider({
                name = "rotation smoothness",
                min = 1,
                max = 20,
                interval = 1,
                default = 8,
                flag = "sticky_rot",
                callback = function(v) flags.sticky_rot = v / 100 end
            })
            secMove:slider({
                name = "air control smoothing",
                min = 1,
                max = 30,
                interval = 1,
                default = 16,
                flag = "sticky_air",
                callback = function(v) flags.sticky_air = v / 100 end
            })
        end
    })

    make_toggle_feature(secMove, {
        name = "Noclip",
        flag = "noclip",
        info = "walk through walls and players",
        on_change = function(v)
            if v then
                noclip_old = {}
            else
                noclip_restore()
            end
        end
    })

    make_toggle_feature(secMove, {
        name = "Speed",
        flag = "speed",
        info = "boost your walkspeed while enabled",
        on_change = function(v)
            local hum = humanoid_of(character_of(LocalPlayer))
            if hum then
                if v then
                    hum.WalkSpeed = flags.walkspeed or 16
                else
                    hum.WalkSpeed = 16
                end
            end
        end,
        after = function()
            secMove:slider({
                name = "walkspeed",
                min = 16,
                max = 500,
                interval = 1,
                default = 16,
                flag = "walkspeed",
                callback = function(v)
                    flags.walkspeed = v
                    if flags.speed then
                        local hum = humanoid_of(character_of(LocalPlayer))
                        if hum then
                            hum.WalkSpeed = v
                        end
                    end
                end
            })
        end
    })

    make_toggle_feature(secMove, {
        name = "Auto PJ",
        flag = "auto_pj",
        info = "when jumping, always turns your character to the right",
        on_change = function(v) end
    })


    local col2 = mainPage:column({})
    local secExp = col2:section({ name = "player", size = 0.55, default = true, icon = "rbxassetid://6031075931" })

    secExp:button({
        name = "tp to touchdown",
        callback = teleport_touchdown
    })

    local tp_ready = false
    secExp:keybind({
        name = "tp to touchdown - KB/M",
        flag = "tp_touchdown_kb",
        mode = "Hold",
        default = false,
        callback = function(state)
            if tp_ready and state then
                teleport_touchdown()
            end
        end
    })
    secExp:keybind({
        name = "tp to touchdown - controller",
        flag = "tp_touchdown_pad",
        mode = "Hold",
        default = false,
        callback = function(state)
            if tp_ready and state then
                teleport_touchdown()
            end
        end
    })
    tp_ready = true

    make_toggle_feature(secExp, {
        name = "Hitbox Expander",
        flag = "hitbox",
        info = "expands other players' head hitboxes",
        on_change = function(v)
            if not v then
                clear_hitboxes()
            end
        end,
        after = function()
            secExp:slider({
                name = "hitbox size",
                min = 0,
                max = 25,
                interval = 1,
                default = 6,
                suffix = " studs",
                flag = "hitbox_size",
                callback = function(v) flags.hitbox_size = v end
            })
            secExp:slider({
                name = "hitbox transparency",
                min = 0,
                max = 1,
                interval = 0.05,
                default = 1,
                flag = "hitbox_transparency",
                callback = function(v) flags.hitbox_transparency = v end
            })
        end
    })

    make_toggle_feature(secExp, {
        name = "Auto Rush DB",
        flag = "autorush",
        info = "teleports to your target until they are down",
        on_change = function(v)
            if v then
                refresh_rush_dropdown()
                notify("auto rush: on - target " .. tostring(flags.rush_target or "Nearest"))
            else
                local reason = rush_pending_reason
                rush_pending_reason = nil
                notify(reason or "auto rush: off")
            end
        end,
        after = function()
            rushDrop = secExp:dropdown({
                name = "rush target",
                items = rush_dropdown_items(),
                default = "Nearest",
                flag = "rush_target",
                seperator = true,
                callback = function(v)
                    flags.rush_target = v
                end
            })
        end
    })

    make_toggle_feature(secExp, {
        name = "Auto Catch",
        flag = "auto_catch",
        info = "teleports you onto the ball until you catch it (teleport only, no flying)",
        on_change = function(v)
            notify(v and "auto catch: on" or "auto catch: off")
        end
    })

    make_toggle_feature(secExp, {
        name = "Auto Tackle",
        flag = "tackle",
        info = "lunges you at the nearest opponent",
        on_change = function(v)
            notify(v and "auto tackle: on" or "auto tackle: off")
        end,
        after = function()
            secExp:slider({
                name = "tackle range",
                min = 3,
                max = 60,
                interval = 1,
                default = 18,
                suffix = " studs",
                flag = "tackle_range",
                callback = function(v) flags.tackle_range = v end
            })
        end
    })

    make_toggle_feature(secExp, {
        name = "Reach",
        flag = "reach",
        info = "enlarges your hands so you can reach and catch further",
        on_change = function(v)
            reach_apply(v)
        end,
        after = function()
            secExp:slider({
                name = "reach size",
                min = 1,
                max = 15,
                interval = 1,
                default = 3,
                suffix = " studs",
                flag = "reach_size",
                callback = function(v)
                    flags.reach_size = v
                    if flags.reach then reach_apply(true) end
                end
            })
        end
    })

    make_toggle_feature(secExp, {
        name = "Dive",
        flag = "dive",
        info = "jumping gives you a long dive lunge",
        on_change = function(v)
            notify(v and "dive: on" or "dive: off")
        end,
        after = function()
            secExp:slider({
                name = "dive power",
                min = 20,
                max = 300,
                interval = 5,
                default = 90,
                flag = "dive_power",
                callback = function(v) flags.dive_power = v end
            })
        end
    })

    make_toggle_feature(secExp, {
        name = "Boost",
        flag = "boost",
        info = "continuously boosts you upward using boost power",
        on_change = function(v)
            notify(v and "boost: on" or "boost: off")
        end,
        after = function()
            secExp:slider({
                name = "boost power",
                min = 20,
                max = 600,
                interval = 5,
                default = 120,
                flag = "boost_power",
                callback = function(v) flags.boost_power = v end
            })
        end
    })

    for _, emote in EMOTES do
        secExp:button({
            name = "emote: " .. emote.name,
            callback = function() play_named_emote(emote.name, emote.id, emote.speed) end
        })
    end

    local secQB = col2:section({ name = "qb aimbot", size = 0.40, default = true, icon = "rbxassetid://10723415766" })

    make_toggle_feature(secQB, {
        name = "QB Aimbot",
        flag = "qb_aimbot",
        info = "redirects the ball to your most open teammate with prediction",
        on_change = function(v)
            notify(v and "qb aimbot: on" or "qb aimbot: off")
        end,
        after = function()
            secQB:slider({
                name = "prediction",
                min = 0,
                max = 1,
                interval = 0.05,
                default = 0.35,
                suffix = "s",
                flag = "qb_prediction",
                callback = function(v) flags.qb_prediction = v end
            })
        end
    })
end

local visualsPage = window:tab({
    name = "visuals",
    icon = "rbxassetid://6031075931",
    tabs = { "visuals" }
})

do
    local col1 = visualsPage:column({})
    local secSky = col1:section({ name = "world", size = 1, default = true, icon = "rbxassetid://6031075931" })

    make_toggle_feature(secSky, {
        name = "Potato Graphics",
        flag = "potato",
        info = "strips every texture, effect, light and material on the map for max fps",
        on_change = function(v)
            if v then
                potato_enable()
                notify("potato graphics: on")
            else
                potato_restore()
                notify("potato graphics: off")
            end
        end
    })

    make_toggle_feature(secSky, {
        name = "Sky Changer",
        flag = "sky_changer",
        info = "flat gray sky with no textures or atmosphere",
        on_change = function(v)
            if v then
                sky_enable("gray")
            else
                sky_disable()
            end
        end
    })

    make_toggle_feature(secSky, {
        name = "Sakura Sky",
        flag = "sakura_sky",
        info = "pink no-texture sky with a sakura atmosphere",
        on_change = function(v)
            if v then
                sky_enable("sakura")
            else
                sky_disable()
            end
        end
    })

    make_toggle_feature(secSky, {
        name = "Ball: No Texture",
        flag = "ball_notexture",
        info = "removes the football's textures",
        on_change = function(v)
            local ball = find_football()
            if v then
                ball_texture_off(ball)
            else
                ball_texture_restore(ball)
            end
        end
    })

    make_toggle_feature(secSky, {
        name = "Ball: Box",
        flag = "ball_box",
        info = "draws a pink square around the football",
        on_change = function(v)
            local ball = find_football()
            if v then
                ball_box_on(ball)
            else
                ball_box_off(ball)
            end
        end
    })

    make_toggle_feature(secSky, {
        name = "Player Effect: Fire",
        flag = "player_fire",
        info = "fire particles on your character",
        on_change = function(v)
            local root = root_of(character_of(LocalPlayer))
            if v then ensure_emitter(root, "fire") else remove_emitter(root, "fire") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Player Effect: Water",
        flag = "player_water",
        info = "water particles on your character",
        on_change = function(v)
            local root = root_of(character_of(LocalPlayer))
            if v then ensure_emitter(root, "water") else remove_emitter(root, "water") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Player Effect: Sakura",
        flag = "player_sakura",
        info = "sakura petals on your character",
        on_change = function(v)
            local root = root_of(character_of(LocalPlayer))
            if v then ensure_emitter(root, "sakura") else remove_emitter(root, "sakura") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Ball Effect: Fire",
        flag = "ball_fire",
        info = "fire particles on the football",
        on_change = function(v)
            local ball = find_football()
            if v then ensure_emitter(ball, "fire") else remove_emitter(ball, "fire") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Ball Effect: Water",
        flag = "ball_water",
        info = "water particles on the football",
        on_change = function(v)
            local ball = find_football()
            if v then ensure_emitter(ball, "water") else remove_emitter(ball, "water") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Ball Effect: Sakura",
        flag = "ball_sakura",
        info = "sakura petals on the football",
        on_change = function(v)
            local ball = find_football()
            if v then ensure_emitter(ball, "sakura") else remove_emitter(ball, "sakura") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Weather: Rain",
        flag = "weather_rain",
        info = "rain around the camera",
        on_change = function(v)
            if v then weather_rain_on() else weather_off("rain") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Weather: Snow",
        flag = "weather_snow",
        info = "snow around the camera",
        on_change = function(v)
            if v then weather_snow_on() else weather_off("snow") end
        end
    })

    make_toggle_feature(secSky, {
        name = "Weather: Storm",
        flag = "weather_storm",
        info = "dark storm lighting",
        on_change = function(v)
            if v then storm_on() else storm_off() end
        end
    })

    make_toggle_feature(secSky, {
        name = "Weather: Thunder",
        flag = "weather_thunder",
        info = "random lightning flashes",
        on_change = function(v)
            weather.thunderOn = v
            notify(v and "thunder: on" or "thunder: off")
        end
    })

    local col2 = visualsPage:column({})
    local secScreen = col2:section({ name = "screen", size = 0.3, default = true, icon = "rbxassetid://6031075931" })

    make_toggle_feature(secScreen, {
        name = "Stretched Screen",
        flag = "stretch",
        info = "stretches the camera view",
        on_change = function(v)
            if v then
                stretch_enable()
            else
                stretch_disable()
            end
        end,
        after = function()
            secScreen:slider({
                name = "stretch amount",
                min = 0.3,
                max = 1,
                interval = 0.05,
                default = 0.65,
                flag = "stretch_amount",
                callback = function(v)
                    flags.stretch_amount = v
                end
            })
        end
    })

    local secCloth = col2:section({ name = "clothing", size = 0.3, default = true, icon = "rbxassetid://10709769508" })

    secCloth:textbox({
        name = "shirt id",
        default = "",
        callback = function(t) flags.clothing_shirt = t end
    })
    secCloth:textbox({
        name = "pants id",
        default = "",
        callback = function(t) flags.clothing_pants = t end
    })
    secCloth:textbox({
        name = "tshirt id",
        default = "",
        callback = function(t) flags.clothing_tshirt = t end
    })
    secCloth:button({
        name = "apply clothing",
        callback = function()
            apply_clothing(flags.clothing_shirt, flags.clothing_pants, flags.clothing_tshirt)
        end
    })

    secCloth:button({
        name = "clear clothing",
        callback = function()
            local char = character_of(LocalPlayer)
            if not char then return end
            for _, n in { "BloomShirt", "BloomPants", "BloomTShirt" } do
                local inst = char:FindFirstChild(n)
                if inst then pcall(function() inst:Destroy() end) end
            end
            notify("clothing cleared")
        end
    })

    secCloth:textbox({
        name = "accessory id",
        default = "",
        seperator = true,
        callback = function(t) flags.accessory_id = t end
    })
    secCloth:button({
        name = "add accessory",
        callback = function()
            add_accessory(flags.accessory_id)
        end
    })

    for _, acc in ACCESSORY_PRESETS do
        secCloth:button({
            name = acc.name,
            callback = function() add_accessory(acc.id) end
        })
    end

    for _, cl in CLOTHES do
        secCloth:button({
            name = cl.name,
            callback = function()
                if apply_cloth_entry(cl) then
                    notify("wearing: " .. cl.name)
                else
                    notify("clothing: failed " .. cl.name)
                end
            end
        })
    end

    local secItems = col2:section({ name = "cosmetics", size = 0.28, default = true, icon = "rbxassetid://10709769508" })
    local sorted_item_names = {}
    for k in pairs(ITEMS) do table.insert(sorted_item_names, k) end
    table.sort(sorted_item_names)
    for _, iname in ipairs(sorted_item_names) do
        secItems:button({
            name = iname,
            callback = function()
                if equipped_items[iname] then
                    unequip_item(iname)
                    notify("unequipped: " .. iname)
                else
                    equip_item(iname)
                    if equipped_items[iname] then
                        notify("equipped: " .. iname)
                    else
                        notify("cosmetic failed: " .. iname)
                    end
                end
            end
        })
    end
    secItems:button({
        name = "unequip all items",
        callback = function()
            unequip_all_items()
            notify("all cosmetics removed")
        end
    })
end

local emotesPage = window:tab({
    name = "emotes",
    icon = "rbxassetid://10709769508",
    tabs = { "emotes" }
})

do
    local col1 = emotesPage:column({})
    local secEmote = col1:section({ name = "emotes", size = 1, default = true, icon = "rbxassetid://10709769508" })

    for _, emote in EMOTES do
        secEmote:button({
            name = emote.name,
            callback = function() play_named_emote(emote.name, emote.id, emote.speed) end
        })
    end

    secEmote:button({
        name = "stop emote",
        callback = function()
            local hum = humanoid_of(character_of(LocalPlayer))
            if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end) end
            pcall(stop_emote)
        end
    })
end

window:seperator({ name = "menu" })


local miscPage = window:tab({
    name = "misc",
    icon = "rbxassetid://10709769508",
    tabs = { "misc" }
})

do
    local col1 = miscPage:column({})
    local secName = col1:section({ name = "name changer", size = 1, default = true, icon = "rbxassetid://10709769508" })

    local currentName = ""
    pcall(function()
        currentName = LocalPlayer.DisplayName
    end)

    secName:textbox({
        name = "display name",
        default = LocalPlayer.DisplayName or "",
        callback = function(t)
            flags.display_name = t
        end
    })
    secName:textbox({
        name = "username",
        default = LocalPlayer.Name or "",
        callback = function(t)
            flags.user_name = t
        end
    })
    secName:button({
        name = "apply name change",
        callback = function()
            local dn = flags.display_name
            local un = flags.user_name
            if not dn or dn == "" then dn = un end
            if not dn or dn == "" then dn = "bloom" end
            pcall(function()
                LocalPlayer:SetAttribute("FakeDisplayName", dn)
                LocalPlayer:SetAttribute("bloom_displayname", dn)
            end)
            name_changer_apply(dn)
            notify("name changer: applied (" .. dn .. ")")
        end
    })
end

local configsPage = window:tab({
    name = "configs",
    icon = "rbxassetid://10734950309",
    tabs = { "configs" }
})

do
    local col1 = configsPage:column({})
    local secList = col1:section({ name = "saved configs", size = 1, default = true, icon = "rbxassetid://139628202576511" })

    local cfg_list
    cfg_list = secList:list({
        options = { "default" },
        default = "default",
        flag = "selected_config_name",
        callback = function(option)
            flags.selected_config_name = option
        end
    })

    local function refresh_configs()
        pcall(function()
            if not isfolder or not listfiles then return end
            if not isfolder("bloom") then makefolder("bloom") end
            if not isfolder("bloom/configs") then makefolder("bloom/configs") end
            local files = listfiles("bloom/configs")
            local list = {}
            for _, f in ipairs(files) do
                local name = tostring(f):gsub("bloom/configs[\\/]", ""):gsub("bloom[\\/]configs[\\/]", ""):gsub(".cfg", ""):gsub(".json", "")
                table.insert(list, name)
            end
            if #list == 0 then table.insert(list, "default") end
            if cfg_list and cfg_list.refresh_options then
                cfg_list.refresh_options(list)
            end
        end)
    end

    local col2 = configsPage:column({})
    local secAct = col2:section({ name = "config actions", size = 1, default = true, icon = "rbxassetid://129380150574313" })

    secAct:textbox({
        name = "config name",
        default = "",
        seperator = true,
        callback = function(t)
            flags.config_custom_name = t
        end
    })

    secAct:toggle({
        name = "overwrite configs",
        flag = "config_overwrite",
        default = true,
        callback = function(v)
            flags.config_overwrite = v
        end
    })

    secAct:button({
        name = "save config",
        callback = function()
            local cname = flags.config_custom_name
            if not cname or #cname == 0 then cname = flags.selected_config_name end
            if not cname or #cname == 0 then cname = "default" end
            pcall(function()
                if not isfolder("bloom") then makefolder("bloom") end
                if not isfolder("bloom/configs") then makefolder("bloom/configs") end
                local path = "bloom/configs/" .. cname .. ".cfg"
                if flags.config_overwrite == false and isfile and isfile(path) then
                    local i = 1
                    while isfile("bloom/configs/" .. cname .. "_" .. i .. ".cfg") do
                        i = i + 1
                    end
                    cname = cname .. "_" .. i
                    path = "bloom/configs/" .. cname .. ".cfg"
                end
                writefile(path, Library:get_config())
                refresh_configs()
                notify("saved config: " .. cname, "configs")
            end)
        end
    })

    secAct:button({
        name = "overwrite selected config",
        callback = function()
            local cname = flags.selected_config_name
            if not cname or #cname == 0 then cname = "default" end
            pcall(function()
                if not isfolder("bloom") then makefolder("bloom") end
                if not isfolder("bloom/configs") then makefolder("bloom/configs") end
                writefile("bloom/configs/" .. cname .. ".cfg", Library:get_config())
                refresh_configs()
                notify("overwrote config: " .. cname, "configs")
            end)
        end
    })

    secAct:button({
        name = "load config",
        callback = function()
            local cname = flags.selected_config_name or flags.config_custom_name or "default"
            pcall(function()
                local path = "bloom/configs/" .. cname .. ".cfg"
                if isfile and isfile(path) then
                    Library:load_config(readfile(path))
                    notify("loaded config: " .. cname, "configs")
                else
                    notify("config not found: " .. cname, "configs")
                end
            end)
        end
    })

    secAct:button({
        name = "delete config",
        callback = function()
            local cname = flags.selected_config_name
            if not cname or #cname == 0 or cname == "default" then return end
            pcall(function()
                local path = "bloom/configs/" .. cname .. ".cfg"
                if isfile and isfile(path) then
                    delfile(path)
                    refresh_configs()
                    notify("deleted config: " .. cname, "configs")
                end
            end)
        end
    })

    secAct:button({
        name = "export to clipboard",
        callback = function()
            pcall(function()
                if setclipboard then
                    setclipboard(Library:get_config())
                    notify("config copied to clipboard", "configs")
                end
            end)
        end
    })

    secAct:button({
        name = "import from clipboard",
        callback = function()
            pcall(function()
                if getclipboard then
                    local clip = getclipboard()
                    if clip and #clip > 0 then
                        Library:load_config(clip)
                        notify("config loaded from clipboard", "configs")
                    end
                end
            end)
        end
    })

    secAct:colorpicker({
        name = "accent color",
        color = Color3.fromRGB(255, 110, 190),
        callback = function(c)
            Library:update_theme("accent", c)
        end
    })

    secAct:keybind({
        name = "menu toggle keybind",
        key = Enum.KeyCode.RightShift,
        default = true,
        mode = "Toggle",
        callback = function(state)
            menuVisible = (state == true)
            pcall(function()
                window.toggle_menu(menuVisible)
            end)
        end
    })

    secAct:button({
        name = "unload bloom",
        callback = function()
            pcall(function()
                if getgenv and getgenv().bloom_cleanup then
                    getgenv().bloom_cleanup()
                end
            end)
        end
    })

    task.defer(refresh_configs)
end

clear_hitboxes()

add_connection(RunService.Heartbeat:Connect(function(dt)
    local char = character_of(LocalPlayer)
    local root = root_of(char)
    local hum = humanoid_of(char)

    if game.PlaceId ~= NFL_PLACE_ID and game.GameId ~= NFL_UNIVERSE_ID then
        pcall(function() LocalPlayer:Kick("WRONG GAME!") end)
        return
    end

    if char then
        sync_fx(root, "player")
    end

    -- shared ball scan (throttled) for every ball-related feature
    if flags.qb_aimbot or flags.auto_catch or flags.ball_notexture or flags.ball_box
        or flags.ball_fire or flags.ball_water or flags.ball_sakura then
        ballVisualClock = ballVisualClock + dt
        if ballVisualClock >= 0.25 or not (cachedBall and cachedBall.Parent) then
            ballVisualClock = 0
            if not (cachedBall and cachedBall.Parent) then
                cachedBall = nil
            end
            local ball = find_football()
            if ball then
                sync_fx(ball, "ball")
                if flags.ball_notexture then ball_texture_off(ball) end
                if flags.ball_box then ball_box_on(ball) end
            end
            ballHolder = nil
            if ball and (flags.qb_aimbot or flags.auto_catch) then
                for _, plr in Players:GetPlayers() do
                    if ball_is_held_by(ball, plr) then
                        ballHolder = plr
                        break
                    end
                end
            end
        end
    end

    if flags.auto_catch and root and char then
        local ball = cachedBall
        if ball and ball.Parent and ballHolder ~= LocalPlayer then
            autoCatchClock = autoCatchClock + dt
            if autoCatchClock >= 0.15 then
                autoCatchClock = 0
                local dist = (ball.Position - root.Position).Magnitude
                if dist > 2 then
                    pcall(function() char:PivotTo(CFrame.new(ball.Position)) end)
                    pcall(function()
                        local r = root_of(char)
                        if r then r.AssemblyLinearVelocity = Vector3.zero end
                    end)
                end
            end
        end
    end

    if flags.tackle and root and char then
        tackleClock = tackleClock + dt
        if tackleClock >= 0.1 then
            tackleClock = 0
            local _, oppRoot = nearest_opponent(flags.tackle_range or 18)
            if oppRoot then
                local dir = oppRoot.Position - root.Position
                if dir.Magnitude > 0.1 then
                    local flat = Vector3.new(dir.X, 0, dir.Z)
                    if flat.Magnitude > 0.1 then
                        flat = flat.Unit
                        root.AssemblyLinearVelocity = Vector3.new(flat.X * 55, root.AssemblyLinearVelocity.Y, flat.Z * 55)
                        root.CFrame = CFrame.lookAt(root.Position, root.Position + flat)
                    end
                end
            end
        end
    end

    if flags.boost and root then
        boostClock = boostClock + dt
        if boostClock >= 0.5 then
            boostClock = 0
            local power = flags.boost_power or 120
            root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, power, root.AssemblyLinearVelocity.Z)
        end
    end

    if flags.qb_aimbot and root and char then
        qbTargetClock = qbTargetClock + dt
        if qbTargetClock >= 0.15 then
            qbTargetClock = 0
            qbTarget = qb_predicted_target(root)
        end

        local ball = cachedBall
        local pred = qbTarget
        if ball and ball.Parent and pred then
            if ballHolder == LocalPlayer then
                local flat = Vector3.new(pred.X, root.Position.Y, pred.Z)
                root.CFrame = root.CFrame:Lerp(
                    CFrame.lookAt(root.Position, flat),
                    math.clamp(0.3 * 60 * dt, 0, 1))
            elseif ballHolder == nil then
                local dir = pred - ball.Position
                if dir.Magnitude > 1.5 then
                    pcall(function() ball:SetNetworkOwner(LocalPlayer) end)
                    local speed = math.max(ball.AssemblyLinearVelocity.Magnitude, 70)
                    ball.AssemblyLinearVelocity = dir.Unit * speed
                end
            end
        end
    end

    if flags.headboost and root and char then
        if tick() - lastHeadBoost >= 0.3 then
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = { char }
            local result = Workspace:Raycast(root.Position, Vector3.new(0, -4.5, 0), params)
            if result and result.Instance then
                local inst = result.Instance
                if inst.Name == "Head" or inst.Name == "BloomHeadHitbox" then
                    local model = inst:FindFirstAncestorOfClass("Model")
                    local owner = model and Players:GetPlayerFromCharacter(model)
                    if owner and owner ~= LocalPlayer and root.AssemblyLinearVelocity.Y <= 2 then
                        local power = flags.headboost_power or 250
                        root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, power, root.AssemblyLinearVelocity.Z)
                        lastHeadBoost = tick()
                    end
                end
            end
        end
    end



    if flags.noclip and char then
        noclipClock = noclipClock + dt
        if noclipClock >= 0.2 then
            noclipClock = 0
            for _, p in char:GetDescendants() do
                if p:IsA("BasePart") then
                    if noclip_old[p] == nil then
                        noclip_old[p] = p.CanCollide
                    end
                    p.CanCollide = false
                end
            end
        end
    end

    if flags.hitbox then
        hitboxClock = hitboxClock + dt
        if hitboxClock >= 0.15 then
            hitboxClock = 0
            local expand = flags.hitbox_size or 6
            local trans = flags.hitbox_transparency or 1
            for _, plr in Players:GetPlayers() do
                if plr ~= LocalPlayer then
                    local pc = character_of(plr)
                    local head = pc and pc:FindFirstChild("Head")
                    if head then
                        local hb = pc:FindFirstChild("BloomHeadHitbox")
                        if not hb then
                            hb = Instance.new("Part")
                            hb.Name = "BloomHeadHitbox"
                            hb.Anchored = true
                            hb.CanCollide = true
                            hb.CastShadow = false
                            hb.Material = Enum.Material.ForceField
                            hb.Color = Color3.fromRGB(255, 110, 190)
                            hb.Parent = pc
                        end
                        hb.Size = head.Size + Vector3.new(expand, expand, expand)
                        hb.Transparency = trans
                        hb.CFrame = head.CFrame
                    end
                end
            end
        end
    end

    if flags.autorush then
        rushClock = rushClock + dt
        if rushClock >= 0.15 then
            rushClock = 0
            local target = rush_target_player()
            if not target then
                rush_stop("auto rush: no target available")
            elseif is_target_down(target) then
                rush_stop("auto rush: " .. target.Name .. " is down")
            else
                local tc = character_of(target)
                local troot = root_of(tc)
                if tc and troot and char then
                    local look = troot.CFrame.LookVector
                    local dest = troot.Position + look * 3 + Vector3.new(0, 1.5, 0)
                    char:PivotTo(CFrame.lookAt(dest, troot.Position + Vector3.new(0, 1.5, 0)))
                end
            end
        end
    end
end))

local function hook_character(char)
    if not char then return end
    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", 15)
        if hum and hum:IsA("Humanoid") then
            add_connection(hum.Jumping:Connect(function()
                if not LocalPlayer.Character then return end
                local r = root_of(LocalPlayer.Character)
                if not r then return end

                if flags.auto_pj then
                    local root = r
                    local cf = root.CFrame
                    local right = Vector3.new(cf.XVector.X, 0, cf.XVector.Z)
                    if right.Magnitude > 0.01 then
                        right = right.Unit
                    else
                        right = Vector3.new(1, 0, 0)
                    end
                    pcall(function()
                        root.CFrame = CFrame.lookAt(cf.Position, cf.Position + right)
                    end)
                end

                if flags.dive then
                    local look = r.CFrame.LookVector
                    local power = flags.dive_power or 90
                    r.AssemblyLinearVelocity = Vector3.new(look.X * power, math.max(r.AssemblyLinearVelocity.Y, 20), look.Z * power)
                end
            end))
        end
        if flags.speed then
            local h2 = humanoid_of(character_of(LocalPlayer))
            if h2 then
                h2.WalkSpeed = flags.walkspeed or 16
            end
        end
        hand_old = {}
        if flags.reach then reach_apply(true) end
        if nameState.fake then name_changer_apply(nameState.fake) end
        local root2 = root_of(character_of(LocalPlayer))
        if root2 then sync_fx(root2, "player") end
    end)
end

add_connection(LocalPlayer.CharacterAdded:Connect(hook_character))
hook_character(character_of(LocalPlayer))

add_connection(Players.PlayerAdded:Connect(function()
    if flags.autorush then
        refresh_rush_dropdown()
    end
end))

add_connection(Players.PlayerRemoving:Connect(function()
    if flags.autorush then
        refresh_rush_dropdown()
    end
end))

if UserInputService.TouchEnabled then
    pcall(function()
        local parent = (gethui and gethui()) or game:GetService("CoreGui")
        bloomGui = Instance.new("ScreenGui")
        bloomGui.Name = "BloomMobile"
        bloomGui.ResetOnSpawn = false
        bloomGui.DisplayOrder = 999
        bloomGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        bloomGui.Parent = parent

        local PINK = Color3.fromRGB(255, 110, 190)
        local DARK = Color3.fromRGB(28, 28, 32)
        local OFFC = Color3.fromRGB(40, 40, 48)
        local TXT  = Color3.fromRGB(245, 245, 245)
        local ONC  = Color3.fromRGB(20, 20, 24)

        local function round(inst, r)
            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, r)
            c.Parent = inst
            return c
        end

        local function add_stroke(inst, col, th, tr)
            local s = Instance.new("UIStroke")
            s.Color = col
            s.Thickness = th
            s.Transparency = tr or 0.2
            s.Parent = inst
            return s
        end

        local function pill(text, pos, size)
            local b = Instance.new("TextButton")
            b.AnchorPoint = Vector2.new(1, 0)
            b.Position = pos
            b.Size = size
            b.BackgroundColor3 = DARK
            b.BackgroundTransparency = 0.15
            b.Text = text
            b.Font = Enum.Font.GothamBold
            b.TextSize = 15
            b.TextColor3 = TXT
            b.AutoButtonColor = true
            b.Parent = bloomGui
            round(b, math.floor(size.Y.Offset / 2))
            add_stroke(b, PINK, 2, 0.2)
            return b
        end

        local lastFire = {}
        local function once(key)
            local now = tick()
            if lastFire[key] and (now - lastFire[key]) < 0.35 then return false end
            lastFire[key] = now
            return true
        end

        -- rounded rectangular button: toggles the whole menu on / off
        local menuBtn = pill("🌸 MENU", UDim2.new(1, -12, 0, 12), UDim2.fromOffset(112, 40))

        -- rounded rectangular button: shows / hides the feature buttons
        local featBtn = pill("⚡ FEATURES", UDim2.new(1, -12, 0, 58), UDim2.fromOffset(112, 36))

        local panel = Instance.new("Frame")
        panel.Name = "QuickPanel"
        panel.AnchorPoint = Vector2.new(1, 0)
        panel.Position = UDim2.new(1, -12, 0, 100)
        panel.Size = UDim2.new(0, 156, 0.7, 0)
        panel.BackgroundColor3 = DARK
        panel.BackgroundTransparency = 0.2
        panel.Visible = true
        panel.Parent = bloomGui
        round(panel, 10)
        add_stroke(panel, PINK, 1.5, 0.4)

        local pscroll = Instance.new("ScrollingFrame")
        pscroll.Size = UDim2.new(1, -8, 1, -8)
        pscroll.Position = UDim2.new(0, 4, 0, 4)
        pscroll.BackgroundTransparency = 1
        pscroll.BorderSizePixel = 0
        pscroll.ScrollBarThickness = 3
        pscroll.ScrollBarImageColor3 = PINK
        pscroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        pscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        pscroll.Parent = panel

        local plist = Instance.new("UIListLayout")
        plist.Padding = UDim.new(0, 4)
        plist.Parent = pscroll
        local ppad = Instance.new("UIPadding")
        ppad.PaddingTop = UDim.new(0, 4)
        ppad.PaddingBottom = UDim.new(0, 4)
        ppad.PaddingLeft = UDim.new(0, 4)
        ppad.PaddingRight = UDim.new(0, 4)
        ppad.Parent = pscroll

        local mobileButtons = {}
        local mobileLabels = {}

        local function toggle_feature(flag)
            local tog = feature_toggles[flag]
            if tog then
                set_toggle(tog, not (tog.enabled == true))
            else
                flags[flag] = not flags[flag]
            end
            if mobile_refresh then pcall(mobile_refresh, flag) end
        end

        mobile_refresh = function(flag)
            local b = mobileButtons[flag]
            if not b then return end
            local tog = feature_toggles[flag]
            local on = flags[flag] == true
            if tog and tog.enabled ~= nil then on = (tog.enabled == true) end
            b.Text = "  " .. (mobileLabels[flag] or flag) .. (on and ": ON" or ": OFF")
            b.BackgroundColor3 = on and PINK or OFFC
            b.TextColor3 = on and ONC or TXT
        end

        local function add_toggle(label, flagname)
            local t = Instance.new("TextButton")
            t.Size = UDim2.new(1, 0, 0, 30)
            t.BackgroundColor3 = OFFC
            t.TextColor3 = TXT
            t.Font = Enum.Font.GothamBold
            t.TextSize = 13
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.AutoButtonColor = true
            t.Parent = pscroll
            round(t, 6)
            add_stroke(t, Color3.fromRGB(60, 60, 68), 1, 0)
            mobileButtons[flagname] = t
            mobileLabels[flagname] = label
            local function fire()
                if once(flagname) then toggle_feature(flagname) end
            end
            t.MouseButton1Click:Connect(fire)
            t.TouchTap:Connect(fire)
            mobile_refresh(flagname)
        end

        if not UI_ONLY then
        local scriptOn = true
        local st = Instance.new("TextButton")
        st.Size = UDim2.new(1, 0, 0, 30)
        st.BackgroundColor3 = OFFC
        st.TextColor3 = TXT
        st.Font = Enum.Font.GothamBold
        st.TextSize = 13
        st.TextXAlignment = Enum.TextXAlignment.Left
        st.Text = "  SCRIPT: ON"
        st.AutoButtonColor = true
        st.Parent = pscroll
        round(st, 6)
        add_stroke(st, Color3.fromRGB(60, 60, 68), 1, 0)
        local function togglescript()
            if not once("script") then return end
            scriptOn = not scriptOn
            flags.script_enabled = scriptOn
            st.Text = scriptOn and "  SCRIPT: ON" or "  SCRIPT: OFF"
            st.BackgroundColor3 = scriptOn and PINK or OFFC
            st.TextColor3 = scriptOn and ONC or TXT
        end
        st.MouseButton1Click:Connect(togglescript)
        st.TouchTap:Connect(togglescript)

        add_toggle("Headboost", "headboost")
        add_toggle("Sticky Head", "sticky_head")
        add_toggle("Noclip", "noclip")
        add_toggle("Speed", "speed")
        add_toggle("Auto PJ", "auto_pj")
        add_toggle("Hitbox", "hitbox")
        add_toggle("Auto Rush", "autorush")
        add_toggle("QB Aimbot", "qb_aimbot")
        add_toggle("Auto Catch", "auto_catch")
        add_toggle("Auto Tackle", "tackle")
        add_toggle("Reach", "reach")
        add_toggle("Dive", "dive")
        add_toggle("Boost", "boost")
        add_toggle("Potato GFX", "potato")
        add_toggle("Sky Changer", "sky_changer")
        add_toggle("Sakura Sky", "sakura_sky")
        add_toggle("Ball No Tex", "ball_notexture")
        add_toggle("Ball Box", "ball_box")
        add_toggle("P Effect: Fire", "player_fire")
        add_toggle("P Effect: Water", "player_water")
        add_toggle("P Effect: Sakura", "player_sakura")
        add_toggle("B Effect: Fire", "ball_fire")
        add_toggle("B Effect: Water", "ball_water")
        add_toggle("B Effect: Sakura", "ball_sakura")
        add_toggle("Rain", "weather_rain")
        add_toggle("Snow", "weather_snow")
        add_toggle("Storm", "weather_storm")
        add_toggle("Thunder", "weather_thunder")
        add_toggle("Stretched", "stretch")
        end

        local function fire_menu()
            if not once("menu") then return end
            menuVisible = not menuVisible
            pcall(function() window.toggle_menu(menuVisible) end)
            menuBtn.Text = menuVisible and "🌸 MENU" or "🌸 OPEN"
        end
        menuBtn.MouseButton1Click:Connect(fire_menu)
        menuBtn.TouchTap:Connect(fire_menu)

        local function fire_feat()
            if not once("feat") then return end
            panel.Visible = not panel.Visible
        end
        featBtn.MouseButton1Click:Connect(fire_feat)
        featBtn.TouchTap:Connect(fire_feat)

        task.delay(1, function()
            if not mobile_refresh then return end
            for flag in pairs(mobileButtons) do
                pcall(mobile_refresh, flag)
            end
        end)
    end)
end

getgenv().bloom_cleanup = function()
    pcall(function()
        for _, conn in bloomConnections do
            pcall(function() conn:Disconnect() end)
        end
    end)
    bloomConnections = {}

    pcall(stretch_disable)
    pcall(sky_disable)
    pcall(clear_hitboxes)
    pcall(noclip_restore)
    pcall(stop_emote)
    pcall(function()
        weather.alive = false
        weather.thunderOn = false
        if weather.conn then weather.conn:Disconnect() end
    end)
    pcall(function() weather_off("rain") end)
    pcall(function() weather_off("snow") end)
    pcall(storm_off)
    pcall(potato_restore)
    pcall(function()
        local ball = find_football()
        if ball then
            ball_texture_restore(ball)
            ball_box_off(ball)
            clear_fx(ball)
        end
        clear_fx(root_of(character_of(LocalPlayer)))
    end)
    pcall(function() reach_apply(false) end)
    pcall(function()
        if bloomGui then
            bloomGui:Destroy()
            bloomGui = nil
        end
    end)
    pcall(function()
        Library:unload_menu()
    end)
    menuVisible = false
end

task.delay(1.5, function()
    notify("bloom.gg loaded - press RightShift or the 🌸 button", "bloom.gg 🌸")
end)
