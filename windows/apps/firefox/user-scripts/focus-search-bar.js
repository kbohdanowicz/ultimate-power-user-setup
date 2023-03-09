// ==UserScript==
// @name        Focus search window on page load
// @namespace   Violentmonkey Scripts
// @match       https://www.youtube.com/feed/library
// @match       https://duckduckgo.com/*
// @grant       none
// @version     1.0
// @author      -
// @description 02/09/2021, 17:02:33
// ==/UserScript==

'use strict'

const isVisible = function(element) {
    return element.offsetParent !== null
}

const isFocusable = function(element) {
    let initialFocus = document.activeElement
    element.focus()
    let elementIsFocusable = document.activeElement == element
    initialFocus.focus()
    return elementIsFocusable
}

/**
 * Query for a set of focusable, visible html element(s) mathing a query
 * pattern.
 *
 * @returns
 *      The matched elements as an array of elements. Returns an empty array if
 *      no query matched any element.
 */
const getEligibleTextInputs = function() {
    const queries = [
        [
            "input[type='search']",
            "input[inputmode='search']",
            "input[type='text'][class*='search']",
            "input[type='text'][class*='Search']",
            "input:not([type])[class*='search']",
            "input:not([type])[class*='Search']",
            "input[type='text'][placeholder*='Search']",
            "input[type='text'][placeholder*='search']",
            "input:not([type])[placeholder*='Search']",
            "input:not([type])[placeholder*='search']",
        ].join(","),
        "input[type='text'],input:not([type])",
        "textarea,input[type='email'],input[type='url']"
    ]
    let inputs = []
    for (const q of queries) {
        const selection = Array.from(document.querySelectorAll(q))
        inputs = selection.filter(e => isVisible(e) && isFocusable(e))
        if (inputs.length > 0) {
            break
        }
    }
    return inputs
}

const binarySearch = function(sortedHayStack, needle, comparisonFunction) {

    // Binary find the insert position
    let insertionPosition = null;
    let low = 0;
    let high = sortedHayStack.length - 1 + 1;
    let half;
    let comparison;
    let infiniteLoop = 0;
    while (insertionPosition === null) {
        half = (low + high) >> 1;
        comparison = comparisonFunction(needle, sortedHayStack[half]);
        if (comparison > 0) {
            low = half + 1;
        } else if (comparison < 0) {
            high = half - 1 + 1;
        } else if (comparison == 0) {
            insertionPosition = half;
        } else {
            error("Something strange #code-ref(706987)");
        }
        if (insertionPosition === null && low >= high) {
            insertionPosition = high;
        }
        if (infiniteLoop++ > 10000) {
            error("Infinite loop (>10000) #code-ref(102802)");
        }
    }

    // Go to the lowest insert position
    while (
        insertionPosition >= 0
        && comparisonFunction(needle, sortedHayStack[insertionPosition]) <= 0
    ) {
        insertionPosition -= 1;
    }
    insertionPosition += 1;
    return insertionPosition;
}

/**
 * Compare two DOM nodes by their position in the page (their order of appearance).
 *
 * @param A DOM Node to compare
 * @param B DOM Node to compare
 * @returns 1 if a comes after b, -1 if a comes before b, 0 otherwise (usually because a == b).
 */
const nodePositionCompare = function(a, b) {
    if (a === undefined || a === null) {
        error("Undefined or null argument value #code-ref(410385)");
    }
    let positionInformation = b.compareDocumentPosition(a);
    if (positionInformation & Node.DOCUMENT_POSITION_FOLLOWING) {
        // a comes after b
        return 1;
    } else if (positionInformation & Node.DOCUMENT_POSITION_PRECEDING) {
        // a comes before b
        return -1;
    } else {
        return 0;
    }
};

const getNextTextInput = function(referenceElement) {
    const inputCandidates = getEligibleTextInputs();
    const insertionPosition = binarySearch(inputCandidates, referenceElement, nodePositionCompare);
    // ^ Lowest possible position
    const l = inputCandidates.length;
    let i;
    if (l == 0) {
        return null;
    }

    i = insertionPosition % l;
    if (inputCandidates[i] == referenceElement) {
        i = (i + 1) % l;
    }

    return inputCandidates[i];
};

const addressBarUrl = document.location.href

for (const matchingUrl of GM_info.script.matches) {
  if (addressBarUrl.includes(matchingUrl)) {
    const reference = document.activeElement
    const input = getNextTextInput(reference)
    input.focus() // Unnecessary
    input.select()
  }
}





















