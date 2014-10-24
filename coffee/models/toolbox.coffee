# ツールボックス
class Toolbox
    constructor: (@app) ->
        @canvas = @app.canvas
        @data = @app.data
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
                @app.transit(new ItemAddState(@canvas, @data, shape))
            when "connector"
                @app.transit(new ConnectorNormalState(@app, @canvas, @data))
            when "straightline"
                @app.transit(new StraightLineNormalState(@canvas, @data))
            when "freeline"
                @app.transit(new FreeLineNormalState(@app, @canvas, @data))
            else
                log "unknown shape: #{shape}"
