script:name("New Visuals")
script:devs({"ConeTin"})
script:desc("New Vision of Rockstar Visuals")

script_info = {
    name = "NewVisuals"
}

fonts = {
    mulish_bold = {
        link = "https://github.com/ConeTin/Rockstar-NewVisuals/raw/main/NewVisuals/mulish-bold.ttf",
        path = script_info.name .. "/mulish-bold.ttf"
    }
}

-- беброу

utils = {
    rgb = function(r, g, b)
        return color.new(r/255, g/255,b/255, 1)
    end,

    rgba = function(r, g, b, alpha)
        return color.new(r/255, g/255, b/255, alpha/255)
    end
}

mods = {
    watermark = {
        draggable = drag.new("Watermark"),
        mod = module.new("Watermark", "Информация о клиенте"),
        on_event = function(event)
            local name = "Rockstar Free";
            local draggable = mods.watermark.draggable
            draggable:set_width(render:text_width(fonts.mulish_bold.path, 18, name) + 11)
            render:blur(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5)
            render:rect(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5, render:alpha(utils.rgb(0, 14, 23), 0.5))
            
            local off = 4
            render:init_stencil()
            render:rect(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5, render:alpha(utils.rgb(0, 14, 23), 0.5))
            render:read_stencil(0)
            render:glow(draggable:x() - off, 
            draggable:y() - off, 
            draggable:width() + off * 2, draggable:height()-0.5 + off * 2, 7, 5+off/2, client:client_color(90), client:client_color(135), client:client_color(180), client:client_color(360))
            render:finish_stencil()

            render:text(fonts.mulish_bold.path, 18, name, draggable:x() + 5, draggable:y() + 3)
        end,

        on_init = function()
            mods.watermark.mod:set(true)
            mods.watermark.draggable:set_x(7):set_y(7):set_width(100):set_height(18)
        end
    },

    keybinds = {
        draggable = drag.new("KeyBinds"),
        mod = module.new("KeyBinds", "Информация о включенных модулях"),
        on_event = function(event)
            local name = "Rockstar Free";
            local draggable = mods.keybinds.draggable
            draggable:set_width(render:text_width(fonts.mulish_bold.path, 18, name) + 11)
            render:blur(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5)
            render:rect(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5, render:alpha(utils.rgb(0, 14, 23), 0.5))
            
            local off = 4
            render:init_stencil()
            render:rect(draggable:x(), draggable:y(), draggable:width(), draggable:height(), 5, render:alpha(utils.rgb(0, 14, 23), 0.5))
            render:read_stencil(0)
            render:glow(draggable:x() - off, 
            draggable:y() - off, 
            draggable:width() + off * 2, draggable:height()-0.5 + off * 2, 7, 5+off/2, client:client_color(90), client:client_color(135), client:client_color(180), client:client_color(360))
            render:finish_stencil()

            render:text(fonts.mulish_bold.path, 18, name, draggable:x() + 5, draggable:y() + 3)
        end,

        on_init = function()
            mods.keybinds.mod:set(true)
            mods.keybinds.draggable:set_x(7):set_y(50):set_width(100):set_height(18)
        end
    }
}

function initialize()
    for key, font in pairs(fonts) do
        files:download_file(font.link, font.path)
    end

    for key, mod in pairs(mods) do
        mod.on_init()
    end

end

initialize()

events.render_2d:set(function(event)
    for key, mod in pairs(mods) do
        if mod.mod:get() then
            mod.on_event(event)
        end
    end
end)
