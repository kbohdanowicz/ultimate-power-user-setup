// ==UserScript==
// @name        Set subscribe button to dark
// @namespace   Violentmonkey Scripts
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.0
// @author      -
// @description 31/10/2022, 01:18:23
// ==/UserScript==

'use strict'

// set subscribe button to dark (sets "yt-spec-button-shape-next--tonal" class)
const setSubButtonColor = () => {
  const subButton = document.querySelectorAll("#subscribe-button button")[0]
  if (subButton === undefined) {
    // console.log("sub button not loaded yet")
  } else {
    subButton.className = "yt-spec-button-shape-next yt-spec-button-shape-next--tonal yt-spec-button-shape-next--mono yt-spec-button-shape-next--size-m"
    // console.log("[" + i + "] set sub button color")
  }
}

const alignLikeDislikeRatioBar = () => {
    document.getElementById('actions-inner').classList.remove('ytd-watch-metadata')
}

for (let i = 600; i <= 2000; i +=10) {
  setTimeout(() => {
    setSubButtonColor()
    // alignLikeDislikeRatioBar()
  }, i)
}
