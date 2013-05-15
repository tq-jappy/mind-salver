class ItemPropertyViewModel
    constructor: () ->
        @id = ko.observable("")
        @shape = ko.observable("")
        @x = ko.observable("")
        @y = ko.observable("")
        @showProperty = ko.observable(false)

    update: (item) ->
        @id(item.id)
        @shape(item.shape)
        @x(item.x)
        @y(item.y)
        @showProperty(true)

    reset: (item) ->
        @id("")
        @shape("")
        @x("")
        @y("")
        @showProperty(false)
