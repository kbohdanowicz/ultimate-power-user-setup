### Prevent quitting the browser by shortcuts (CTRL + Q | CTRL + SHIFT + Q):
- visit `about:config`
- set `browser.quitShortcut.disabled` to `true`

### Smooth scroll:
- visit `about:config`
- set these:
- `general.smoothScroll.currentVelocityWeighting` to `0`
- `general.smoothScroll.mouseWheel.durationMinMS` to `300`
- `general.smoothScroll.mouseWheel.durationMaxMS` to `350`
- `general.smoothScroll.stopDecelerationWeighting` to `1`
- `mousewheel.min_line_scroll_amount` to `10`