class Toolbox
    constructor: (@canvas, @data) ->
        @shapes = [
            {shape: "circle", value: "○"},
            {shape: "triangle", value: "△"},
            {shape: "rectangle", value: "□"},
            {shape: "connector", value: "con"},
            {shape: "straightline", value: "─"},
            {shape: "freeline", value: "～"}
        ]

    update: (shape) ->
        switch (shape)
            when "circle", "triangle", "rectangle"
                @canvas.transit(new ItemAddState(@canvas, @data, shape))
            when "connector"
                @canvas.transit(new ConnectorNormalState(@canvas, @data))
            when "straightline"
                @canvas.transit(new StraightLineNormalState(@canvas, @data))
            when "freeline"
                @canvas.transit(new FreeLineNormalState(@canvas, @data))
            else
                log "unknown shape: #{shape}"
