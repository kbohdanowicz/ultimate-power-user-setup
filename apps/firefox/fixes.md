### Prevent quitting the browser by shortcuts (CTRL + Q | CTRL + SHIFT + Q):
- visit `about:config`
- set `browser.quitShortcut.disabled` to `true`

### Edge-like Smooth scroll:
- visit `about:config`
- set these:
- `general.smoothScroll.currentVelocityWeighting` to `0`
- `general.smoothScroll.mouseWheel.durationMinMS` to `300`
- `general.smoothScroll.mouseWheel.durationMaxMS` to `350`
- `general.smoothScroll.stopDecelerationWeighting` to `1`
- `mousewheel.min_line_scroll_amount` to `10`

### Remove "login using google account" popup
Add `accounts.google.com/gsi/*` to ublock origin "My Filters"

[source](https://superuser.com/questions/1773208/how-can-i-block-the-sign-in-with-google-prompt-on-websites)