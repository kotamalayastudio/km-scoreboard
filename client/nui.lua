NUI = {}
local isOpen = false

---@param action string The action name the UI listens for
---@param data? table Optional data payload
function NUI.SendMessage(action, data)
    SendNuiMessage(json.encode({ action = action, data = data or {} }))
end

---@param visible boolean
function NUI.SetVisibility(visible)
    NUI.SendMessage('setVisible', { visible = visible })
end

---@param hasFocus boolean
---@param hasCursor boolean|nil Defaults to hasFocus if not provided
function NUI.SetFocus(hasFocus, hasCursor)
    SetNuiFocus(hasFocus, hasCursor ~= false and hasFocus)
end

---@param data? table Data to pass to UI on open
function NUI.Open(data)
    if isOpen then return end
    isOpen = true
    NUI.SetFocus(true, true)
    NUI.SendMessage('open', data)
end

function NUI.Close()
    if not isOpen then return end
    isOpen = false
    NUI.SetFocus(false, false)
    NUI.SendMessage('close')
end

---@return boolean
function NUI.IsOpen()
    return isOpen
end

RegisterNuiCallback('close', function(_, cb)
    NUI.Close()
    cb({ success = true })
end)
