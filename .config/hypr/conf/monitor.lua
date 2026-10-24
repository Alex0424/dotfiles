local LAPTOP_CHASSIS_TYPES = { ["8"] = true, ["9"] = true, ["10"] = true, ["14"] = true }

local function is_laptop()
    local f = io.open("/sys/class/dmi/id/chassis_type", "r")
    if not f then
        return false
    end
    local chassis = f:read("*l")
    f:close()
    return chassis ~= nil and LAPTOP_CHASSIS_TYPES[chassis] == true
end

local function apply(monitors)
    for _, m in ipairs(monitors) do
        hl.monitor({
            output = "desc:" .. m.desc,
            mode = m.mode or "1920x1080",
            position = m.position,
            scale = "1",
        })
        if m.workspace then
            hl.workspace_rule({
                workspace = m.workspace,
                monitor = "desc:" .. m.desc,
            })
        end
    end
end

local at_work = is_laptop()

-- HOME:
if not at_work then
    apply({
        { desc = "Acer Technologies VG242Y P TL7EE0033E00", position = "0x0", workspace = "1" },
        { desc = "AOC 25G3ZM WKRN9HA006774", position = "1920x0", workspace = "2" },
        { desc = "ASUSTek COMPUTER INC VG248 LALMQS189709", position = "3840x0", workspace = "3" },
    })
end

-- WORK:
if at_work then
    apply({
        { desc = "BOE 0x0CF2", position = "0x0", workspace = "0" },
        { desc = "HP Inc. HP V27ie G5 3CM41508QM", position = "1920x0", workspace = "1" },
        { desc = "HP Inc. HP 27fw 3CM9441FLX", position = "3840x0", workspace = "2" },
    })
end
