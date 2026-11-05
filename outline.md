Things that should be accessible:
- Texture path
- UV position
- Number of frames
- JSON component

Rewrite goals:
- Try to cut down on instructions used on init, allowing for synchronous loading
- Store the where but not the what. Defer parsing data until the user actually requests it