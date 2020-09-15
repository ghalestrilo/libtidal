# Hi

## This is my TidalCycles configuration repo

1. Clone this repo
2. Make a symlink from `/home/tidal` to the root folder (eg. `/home/you/git/libtidal`)
    - `ln -s /home/you/git/libtidal /home/tidal`
3. Break stuff

Then, you can import my lib from your boot.tidal by adding `:script /home/tidal/boot.tidal` to it.
Or the other way around

## Chapters

### 0. Boot

Implements `tonal`, `setkey` and `t`:

  - `tonal root mode`: wrapper for `note`, played in the key signature defined by `root` and `mode`
  - `setkey root mode`: sets the `global_root` and `global_mode` global dictionary entries, to later be read by `t`
  - `t`: wrapper for `tonal`, bound to the global key (defined by `setkey`)

### 1. Varargs

Attempts to write something like `stack "~ sn" "bd"` instead of `stack ["~ sn", "bd"]`.

Functions:

  - `l`: `l a b c ...` == `[a, b, c, ...]`

### 2. Mixer

These are wrappers to help when using Open Stage Control:

  - `fx i`: Receives osc signal at `"f<i>"`, used for effects faders
  - `vx i`: Receives osc signal at `"v<i>"`, used for volume faders

### 3. Rhythm

I'm working on a way to store rhythms. Right now the file exports a rhythm dictionary which you can use like this:

```haskell
p "percussion" $ rs "house" ["bd", "sn", "ho", "hh"]

-- or: p "percussion" $ rs "house" (l "bd" "sn" "ho" "hh")
```

Functions:

  - `rs` (to be deprecated): 
  - `r`: used to read a rhythm from the global dictionary (eg. `r "house" ["bd", "sn"]`)
  - `dr`: short for *define rhythm*, used to push a rhythm into the global dictionary

### 4. UX

WIP

### 5. Instruments

Some stuff I used on [isohedra](https://github.com/ghalestrilo/isohedra) mostly. Try them out!
Functions:
  `piano`: `superpiano` with some fx
  `vibe`: `supervibe` with some fx
  `gretsch`: `gretsch` kit with some fx

### 6. Song

Does not work yet
