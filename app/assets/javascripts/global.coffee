@ready = ->
  homeReady()
  videosReady()
  fileDragReady()
  galleriesReady()
  galleryPhotosReady()
  categoriesReady()
  slidesReady()

$(document).ready(ready)
$(document)
  .on('turbolinks:load', ready)
  .on('click', '[data-object~="suppress-click"]', -> false)
