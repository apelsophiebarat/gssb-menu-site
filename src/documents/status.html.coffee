---
layout: default
referencesOthers: true
standalone: false
sitemap: false
---
div '.container', ->
  h1 "Status"
  div '.well', ->
    dl '.dl-horizontal', ->
      dt "Site version"
      dd @site.version
      dt "Start date"
      dd "#{@site.date}"
      dt "Environment"
      dd "#{@docpad.getEnvironment()}"
      hostname = @docpad.getHostname()
      if hostname?
        dt "Hostname"
        dd "#{@hostname}"
      renderingDate = new Date()
      dt "Last rendering"
      dd -> "#{renderingDate}"
      lastPost = @getCollection('posts')?.first()?.toJSON()
      if lastPost?
        dt "Last blog post"
        dd "#{lastPost.date}"
      lastMenu = @getCollection('menus')?.first()?.toJSON()
      if lastMenu?
        dt "Last menu"
        dd "#{lastMenu.date}"