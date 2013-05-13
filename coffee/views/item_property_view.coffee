class ItemPropertyView
    constructor: (@obj) ->

    update: (item) ->
        $("#item-property").find(".item-id").text(item.id)
        $("#item-property").find(".item-shape").text(item.shape)
        $("#item-property").find(".item-x").text(item.x)
        $("#item-property").find(".item-y").text(item.y)