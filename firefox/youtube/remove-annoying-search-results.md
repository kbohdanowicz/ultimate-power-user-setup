- Open uBlock Origin dashboard
- Select `my filters` tab
- Copy these filters:
```
! Removes 'People also ask' question suggestions from google search results
google.com##[data-it="rq"]
google.com##[data-it="rq"]

! Removes suggestions from youtube search results such as 'For you'
youtube.com##ytd-shelf-renderer.style-scope:has(span:has-text(/Related to your search/i))
youtube.com##ytd-shelf-renderer:has-text(/People also watched/)
youtube.com###contents > ytd-shelf-renderer:has-text(/For you/)
youtube.com##ytd-shelf-renderer.style-scope:has(span:has-text(/Watch again/i))
youtube.com##ytd-horizontal-card-list-renderer.ytd-item-section-renderer.style-scope:has(span:has-text(/Searches related to/i))
youtube.com##ytd-shelf-renderer.style-scope:has(span:has-text(/Learn while you're at home/i))
youtube.com##ytd-horizontal-card-list-renderer.ytd-item-section-renderer.style-scope
youtube.com###secondary > .ytd-two-column-search-results-renderer
youtube.com###contents > .ytd-secondary-search-container-renderer.style-scope
youtube.com##ytd-shelf-renderer:has-text(/Previously watched/)
youtube.com##ytd-shelf-renderer:has-text(/Results for similar searches/)
youtube.com##ytd-shelf-renderer:has-text(/Channels new to you/)
youtube.com##ytd-shelf-renderer:has-text(/New for you/)
```