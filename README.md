# Hi

## This is my TidalCycles configuration repo

1. Clone this repo
2. Make a symlink from `/home/tidal` to the root folder (eg. `/home/you/git/libtidal`)
  - `ln -s /home/you/git/libtidal /home/tidal`
3. Break stuff

Then, you can import my lib from your boot.tidal by adding `:script /home/tidal/boot.tidal` to it.
Or the other way around

## Chapters

### 1. Varargs

I'm trying to make a way to write something like `stack "~ sn" "bd"` instead of `stack ["~ sn", "bd"]`

### 2. Mixer

These are wrappers to help when using Open Stage Control

### 3. Rhythm

I'm working on a way to store rhythms. Right now the file exports a rhythm dictionary which you can use like this:

```haskell
p "percussion" $ rs "house" ["bd", "sn", "ho", "hh"]

-- or: p "percussion" $ rs "house" (l "bd" "sn" "ho" "hh")
```

### 4. UX

WIP

### 5. Instruments

Some stuff I used on [isohedra](https://github.com/ghalestrilo/isohedra) mostly. Try them out!

### 6. Song

Does not work yet
