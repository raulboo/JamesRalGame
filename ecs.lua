local function _has(e, labels)
    for _,label in ipairs(labels) do
        if not e[label] then return false end
    end
    return true
end

function system(ks, f)
    return function(es)
        for _,e in pairs(es) do
            if _has(e, ks) then
                f(e)
            end
        end
    end
end