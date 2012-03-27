class App.Collections.Gates extends Backbone.Collection
  model: App.Models.Gate

  initialize: ->
    masterRouter.count_plans.bind "reset", @fetchIfCurrentCountPlan, this

    # whenever GateGroup's are modified, update the coloring of the segments
    @bind "add", @addOrChangeSegmentColor, this
    @bind "change", @addOrChangeSegmentColor, this
    @bind "remove", @removeSegmentColor, this

  url: ->
    "/api/projects/#{masterRouter.projects.getCurrentProjectId()}/count_plans/#{masterRouter.count_plans.getCurrentCountPlan().id}/gates"

  fetchIfCurrentCountPlan: ->
    @fetch() if masterRouter.count_plans.getCurrentCountPlan()

  addOrChangeSegmentColor: (gate) ->
    # set the gateGroupColor attribute for the appropriate segment 
    masterRouter.segments.get(gate.get 'segment_id').set
      gateGroupLabel: gate.getGateGroup().get 'label'
    # reloading SegmentLayer will redraw the coloring
    masterRouter.segment_layer.layer.reload()

  removeSegmentColor: (gate) ->
    # unset the gateGroupColor attribute for the appropriate segment 
    masterRouter.segments.get(gate.get 'segment_id').unset 'gateGroupLabel'
    # reloading SegmentLayer will redraw the coloring
    masterRouter.segment_layer.layer.reload()