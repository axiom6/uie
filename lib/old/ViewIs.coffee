isGroupId:( id ) ->
  return false if not @groups?
  for group in @groups when @groups?
    return true if group.key is id
  false

isPaneId:( id ) ->
  return false if not @panes?
  for pane in @panes
    return true if pane.key is id
  false

isStudyId:( id ) ->
  return false if not @panes?
  for pane in @panes
    for own key, study of pane.spec.Studies
      return true if key is id
false