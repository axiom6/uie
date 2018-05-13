

class F6s

  module.exports = F6s

  ###
  "https://www.f6s.com/system/search/autocomplete-locations?id_format=country_alias%2Fcity_alias&countries=1"
   https://www.f6s.com/account/settings/search_actors_data?type=skills'
              var cs = new Cs({
                site_url : "/moc.s6f.www//:sptth".reverse(),
                site_url_ssl : "/moc.s6f.www//:sptth".reverse(),
                site_url_main: "https://www.f6s.com/",
                login_page_path: 'main/authorization/login',
                fbAppId : '196388037101827',
                fbUserData : 'public_profile, email, user_friends',
                youtubeKey : 'AIzaSyDVX5KW2tLWng9Qcze1xzz_Z_8ApL8XTs8'
  ###

  @F6sCom           = "https://api.f6s.com/"
  @F6sSearch        = "https://www.f6s.com/system/search/autocomplete-investors"
  @Local            = { isLocal:true }
  @Innov            = { profile:"innovationpavilionx",        apikey:"gGar55En9K" }
  @Wellness         = { profile:"healthwellnesscallfordeals", apikey:"brl2Txl3PX" }
  @Actor            = "actor-id"
  @ThumbTh4         = "&thumbnail_size=th4"
  @TableNames       = ["mentors","teams","applications","members","leaders","investors","applicants","applicants","following","followers"]

  constructor:( @build, @stream, @setup ) ->
    @Database = Util.Import( 'data/Database'    )
    @Rest     = Util.Import( 'store/Store.Rest' )
    @uri      = if @setup.isLocal? then @Database.Databases['f6s'].uriLoc else F6s.F6sCom+@setup.profile
    @rest     = new @Rest( @stream, @uri )
    @rest.remember()
    Util.databases[@rest.dbName] = @rest.getMemoryTables()

  doSelects:() ->
    @selectTeams()

  doSelectsAll:() ->
    @selectProfiles()
    @selectMentors()
    @selectTeams()
    @selectApplications()
    @selectConnections( 'followers' )

  select:( table, params, onRows ) ->
    tableJson = if @setup.isLocal? then table+'.json' else table
    @rest.subscribe( table, 'none' , 'select', (rows) => onRows(rows)  )
    @rest.select(    tableJson, @Rest.W, "?api_key=#{@setup.apikey}"+params )

  selectProfiles: ( params=F6s.ThumbTh4 ) ->
    @select( 'profile', params, @onProfiles )

  selectMentors:( page='1', count='500' ) ->
    @select( 'mentors', "&page=#{page}&count=#{count}", @onMentors )

  # Most of the time the program is the profile
  selectTeams:( programs=@setup.profile ) ->
    @select( 'teams', "&programs=#{programs}", @onTeams )

  selectApplications:( order='newest', count='500' ) ->
    @select( 'applications', "&sort_by=#{order}&count=#{count}", @onApplications )

  # connection is either ["members","leaders","investors","applicants","applicants","following","followers" ]
  selectConnections:( connection ) ->
    if Util.contains( F6s.TableNames, connection )
     @select( connection, "", @onConnections )
    else
      Util.error( 'Fs6.selectConnections() unknown connection table', connection )

  onProfiles:(     profiles     ) -> Util.noop( profiles     )
  onMentors:(      mentors      ) -> Util.noop( mentors      )
  onTeams:(        teams        ) -> Util.noop( teams        )
  onApplications:( applications ) -> Util.noop( applications )
  onConnections:(  connections  ) -> Util.noop( connections  )



