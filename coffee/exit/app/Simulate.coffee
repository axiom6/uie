
Data = require( 'js/exit/app/Data')

class Simulate

  module.exports = Simulate # Util.Export( Simulate, 'exit/app/Simulate' )

  constructor:( @stream  ) ->

  generateLocationsFromMilePosts:( delay ) ->
    time    = 0
    #subject = @stream.getSubject('Location')
    #subject.delay( delay )
    for feature in Data.MilePosts.features
      Milepost = feature.properties.Milepost
      Util.noop( Milepost )
      lat      = feature.geometry.coordinates[1]  # lat lon reversed in GeoJSON
      lon      = feature.geometry.coordinates[0]
      latlon   = [lat,lon]
      time    += delay
      @stream.publish( 'Location', latlon ) # latlon is content Milepost is from
    return