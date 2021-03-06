# Elm MDL Workshop

Content for a short workshop given in the Elm Dublin Meetup, June 2017.

This workshop is a little bit of an intro to Elm and little bit of an intro to elm-mdl (Material Design Light library for Elm).

## Setting up

1. Install [Elm](https://guide.elm-lang.org/install.html). Alternatively you can edit via [Ellie](https://ellie-app.com). (Lot's of cut and paste though. TODO: If someone has time put the code up there  and add links :))
2. Run `elm reactor` and go to http://localhost:8000
3. Code lives in `src`

## Optional

- Install [elm-format](https://github.com/avh4/elm-format), most plugins can use this to auto-format code.

## Recommended Editors

1. Visual Studio Code + Elm Plugin + elm-format plugin
2. SublimeText 3 + Elm Plugin
3. Atom + Elm plugin

## Useful Links

- [Elm Guide](https://guide.elm-lang.org) (An intro to Elm)
- [Elm Packages](http://package.elm-lang.org) (Elm's package index)
- [elm-mdl](http://package.elm-lang.org/packages/debois/elm-mdl/latest)
- [Elm in Action](https://www.manning.com/books/elm-in-action) (book)
- [elm-spa-example](https://github.com/rtfeldman/elm-spa-example) (a substantial example app)
- [elm-live](https://github.com/tomekwi/elm-live) (more powerful dev server)
- [Ellie](https://ellie-app.com) (live web editor for Elm code, even supports packages)

# Steps

## Step 1

Let's create a basic model for our first machine!

### Exercise 1

We can afford more than one machine now!


## Step 2

Let's create a basic elm-mdl UI and show our machine!

### Exercise 2

Let's show all our machines!

Bonus: Can we embed a link to www.arcade-museum.com in each card?

Bonus bonus: Can we embed a picture from www.arcade-museum.com in each card?

Bonus bonus bonus: Can we make the card look a little less boring?

## Step 3

Let's record some high scores!

## Exercise 3

Freeform :)

Let's work on different ideas:

- Lets split the machine out into it's own module.
- Can we start following the elm-spa-example structure?
- Adding a graph of scores? elm-plot or sparklines (Enjoy the SVG integration in Elm's HTML)
- Why not fetch the image using a task?
- Persist the scores somewhere?
