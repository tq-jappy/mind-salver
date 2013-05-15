class ItemPropertyViewModel
    constructor: (@item) ->
        @selectedItem = ko.observable("")
        @shapes = ko.observableArray(@toolbox.shapes)

    selected: (shape) =>
        return @selectedItem() is shape

    switchItem: (obj, e) =>
        @selectedItem(obj.shape)
        @toolbox.update(obj.shape)
