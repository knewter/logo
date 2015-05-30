## Logo

This is a Logo implementation for Elixir.  We would ultimately like to support
a parser for the logo language.  For now we'll provide the primitives necessary,
but stop short of building the parser.  Our dream is to support this:

```elixir
Logo.evaluate("""
COLOR [255 0 0]
PENDOWN
FORWARD 400
RIGHT 90
FORWARD 200
RIGHT 180
FORWARD 400
""")
```

This should draw a T.  Since we have no parser yet, we would expect that to
evaluate to something like this, which we do support presently.

```elixir
{:ok, logo} = Logo.Instance.start
logo
|> color({255, 0, 0})
|> pen_down
|> forward(400)
|> right(90)
|> forward(200)
|> right(180)
|> forward(400)
```
