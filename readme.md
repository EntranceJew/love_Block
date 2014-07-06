# Climax/Sensuality Framework
Codenamed love_block, because I didn't know what else to call it at the time.

## Information
This framework was built with rapid cooperative testing in mind. It was build so that developers could have multiplayer from the ground up.

## Features
- Console with scrollback and history, dumpable on exit.
- Screenshots.
- Saving and loading states.
- Multiplayer in client / listenserver format.

## Known Issues
- Print overload function doesn't handle multiple argument outputs.
- Console print intercept doesn't properly handle misc types like userdata.
- Loading corrupt settings.txt results in total failure. (Overwritten, not joined.)
- In the event of lag, the tick may accrue debt and take a while to correct.
- As the amount of memory increases (server snapshots) the player's speed does as well.

### Current Tasks
- Rework networking
- Push global controls into a TLbind object.

### Minor To Do

### Major To Do
- Reworking multiplayer to lag compensate.
- Implement a [console](https://github.com/markandgo/loveshack), [animation](https://github.com/kikito/anim8), [debugging](https://github.com/nunodonato/hudebug)
- Sync mouse cursors between multiplayer.
- Create a settings modal.
- Enhance the globals viewer.
- Unify the modals to use less globals.
- Implement loveframes "demo" system into core.

## Credits
Created by EntranceJew and HammyHammerGuy

**Third-Party Libraries**
- [FPSGraph](https://github.com/icrawler/FPSGraph) by icrawler
- [inspect](https://github.com/kikito/inspect.lua) by kikito
- [loveframes](https://github.com/NikolaiResokav/LoveFrames) by Kenny Shields (NikolaiResokav)
- [loveframes fix](https://github.com/Klowner/LoveFrames) by Klowner
- [LUBE](http://love2d.org/forums/viewtopic.php?p=21112#p21112) by bartbes [docs](https://github.com/bartbes/love-misc-libs/blob/master/LUBE/docs.md)
- [middleclass](https://github.com/kikito/middleclass) by kikito [docs](https://github.com/kikito/middleclass/wiki/Quick-Example)
- [monocle](https://github.com/kjarvi/monocle) by kjarvi
- [ser](https://github.com/gvx/Ser) by gvx
- [TLbind](http://love2d.org/wiki/TLbind) by Taehl
- [TSerial](https://love2d.org/wiki/Tserial) by Taehl
- [tween.lua](https://github.com/kikito/tween.lua) by kikito