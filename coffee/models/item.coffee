# アイテム
class Item
    @sequence = 0

    constructor: (@x, @y, @sizeX, @sizeY, @shape) ->
        Item.sequence += 1
        @id = Item.sequence
        @focused = false
        @text = "ABC"
        @update(@x, @y)

        switch @shape
          when "circle"
            @fabricObject = new fabric.Circle(
              radius: 10, fill: 'green', left: @x, top: @y, originX: 'left', originY: 'top'
            )
          when "rectangle"
            @fabricObject = new fabric.Rect(
              width: 20, height: 20, fill: 'green', left: @x, top: @y, originX: 'left', originY: 'top'
            )
          when "triangle"
            @fabricObject = new fabric.Triangle(
              width: 20, height: 20, fill: 'green', left: @x, top: @y, originX: 'left', originY: 'top'
            )
        @fabricObject.selectable = false

        # TODO:
        div = document.createElement("span")
        div.appendChild(document.createTextNode(@id))
        div.className = "canvasText"
        # div.style.fontSize = "48px"
        div.style.fontFamily = "メイリオ,sans-serif"
        div.style.fonwWeight = "normal"
        div.style.visible = "hidden"
        div.style.position = "absolute"
        div.style.display = "none"
        @element = div
        $('#canvas').append(div)

    # 元に戻すために保持
    saveCurrentPosition: () ->
        @saveX = @x
        @saveY = @y

    # 元に戻す
    restore: () ->
        if @saveX? and @saveY?
            @update(@saveX, @saveY)
            @saveX = null
            @saveY = null

    # 異動確定時に保持していた値をクリア
    clear: () ->
        @saveX = null
        @saveY = null

    update: (@x, @y) ->
