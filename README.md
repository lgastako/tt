# tt

Typed Templates.

## Concept

The idea is that templates are functions from a row type to text. You can render
the template by passing a complete row-type to the `render` function, and get
`Text` back, but you can also pass a partial row-type to the `partial` function
and get back a "smaller" template that has been partially applied and is
expecting the rest of the row-type that wasn't applied.


So for example, we might define a template like so:

    myTemplate :: Rec ("name" .== Text .+ "age" .== Int) -> Text
    myTemplate = template "My name is {name} and I am {age} years old."

And then render it all at once:

    rendered :: Text
    rendered = render myTemplate (#name .== "Rip Van Winkle" .+ #age .== 55)

Or render it in stages:

    partiallyRendered :: Rec ("age" .== Int) -> Text
    partiallyRendered = partial myTemplate (#name .== "Rip Van Winkle")

    fullyRendered :: Text
    fullyRendered = render partiallyRendered (#age .== 55)

Both of which will result in the same text:

    My name is Rip Van Winkle and I'm 55 years old.




