--- Process Branch

server.registerUseableItem(Config.BranchItem, function(source, originalItem)
    if not server.hasItem(source, originalItem.name) then return end

    local removeItem = lib.callback.await('weedplanting:client:UseBranch', source)

    if removeItem then
        local branchItem = server.getItem(source, Config.BranchItem)

        if not branchItem then return end
    
        local health = 100
        if branchItem.metadata and branchItem.metadata.health then
            health = branchItem.metadata.health
        elseif branchItem.info and branchItem.info.health then
            health = branchItem.info.health
        end

        if server.removeItem(source, branchItem.name, 1, branchItem.metadata or branchItem.info, branchItem.slot) then
            server.addItem(source, Config.WeedItem, health)
        end
    end
end)


--- Package Bags

server.registerUseableItem(Config.WeedItem, function(source, item)
    local hasItem = server.hasItem(source, Config.WeedItem, 20)

    if hasItem then
        local removeItem = lib.callback.await('weedplanting:client:UseDryWeed', source)

        if removeItem then
            if server.removeItem(source, Config.WeedItem, 20) then
                server.addItem(source, Config.PackedWeedItem, 1)
            end
        end
    else
        utils.notify(source, Locales['notify_title_processing'], Locales['not_enough_dryweed'], 'error', 2500)
    end
end)
