class ToolboxView
    constructor: () ->

    # 選択された項目のタイプのスタイルを変更
    update: (toolbox) ->
        for shape in toolbox.shapes
            selector = "#add-item-select li[shape=\"#{shape}\"]"
            if shape is toolbox.selectedShape
                $("#{selector}").addClass("selected")
            else
                $("#{selector}").removeClass("selected")
