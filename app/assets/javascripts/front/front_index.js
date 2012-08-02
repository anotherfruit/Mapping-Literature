function ml_map_init(datasets, scrollTo) {

    return TimeMap.init({
      mapId: "map",               // Id of map div element (required)
      timelineId: "timeline",     // Id of timeline div element (required)
      options: {
        mapType: "physical",
        eventIconPath: "/assets/timemap/"
      },
      datasets: [ datasets ],
      bandInfo: [
        {
          width:          "85%",
          intervalUnit:   Timeline.DateTime.DECADE,
          intervalPixels: 210
        },
        {
          width:          "15%",
          intervalUnit:   Timeline.DateTime.CENTURY,
          intervalPixels: 150,
          showEventText:  false,
          trackHeight:    0.2,
          trackGap:       0.2
        }
      ],
      scrollTo: scrollTo || 'earliest'
    });
}


function ml_front_index_on_load(tm) {
    var initialLoad = true;

    // http://unscriptable.com/2009/03/20/debouncing-javascript-methods/
    var debounce = function (func, threshold) {
      var timeout;
      return function debounced () {
        if(initialLoad) return;
        var obj = this, args = arguments;
        function delayed () {
          func.apply(obj, args);
          timeout = null;
        };

        if (timeout) clearTimeout(timeout);

        timeout = setTimeout(delayed, threshold || 100);
      };
    }


    tm.timeline.getBand(0).addOnScrollListener(debounce(function(band) {
      $("#date_start").datepicker("setDate", band.getMinVisibleDate());
      $("#date_end").datepicker("setDate", band.getMaxVisibleDate());
      if($("#center_map").prop("checked")) tm.map.autoCenterAndZoom(true);
      else $("#filter-form").submit();
      // tm.map.load gets called after map is centred, which will submit the form.
    }, 200));

    if($("#center_map").prop("checked")) tm.map.autoCenterAndZoom(true);
    else {
      var bb = new mxn.BoundingBox($("#sw_lat").val(), $("#sw_lon").val(), $("#ne_lat").val(), $("#ne_lon").val());
      if (bb.isEmpty()) tm.map.autoCenterAndZoom(true);
      else tm.map.setBounds(bb);
    }

    function updateMapFilter(event_name, event_source, event_args) {
      var bounds = tm.map.getBounds();
      $("input[name='ne_lat']").val(bounds.getNorthEast().lat);
      $("input[name='ne_lon']").val(bounds.getNorthEast().lon);
      $("input[name='sw_lat']").val(bounds.getSouthWest().lat);
      $("input[name='sw_lon']").val(bounds.getSouthWest().lon);
      if(!initialLoad) $("#filter-form").submit();
    }

    tm.map.load.addHandler(function(event_name, event_source, event_args) {
      updateMapFilter.call(this, event_name, event_source, event_args);
      initialLoad=false;
    });
    tm.map.changeZoom.addHandler(debounce(updateMapFilter));
    tm.map.endPan.addHandler(debounce(updateMapFilter));

    function timemapClicked(item) {
      $("tr.creation").removeClass("highlight");
      $("tr[data-rapid-context='creation:"+item.opts.creationId+"']").addClass("highlight");
    }

    for(var i=0; i < tm.map.markers.length; i++) {
      tm.map.markers[i].click.addHandler(function(event_name, event_source, event_args) {
        timemapClicked(event_source.item);
      });
    }

    $("#center_map").change(function() {$("#filter-form input[name='center_map']").val($(this).prop('checked') ? 'on' : "") });
    $("form.search-form input[name='search']").change(function() {$("#filter-form input[name='search']").val($(this).val())});

    tm.timeline.getBand(0).getEventPainter().addOnSelectListener(function(eventID) {
      timemapClicked(tm.timeline.getBand(0).getEventSource().getEvent(eventID).item);
    });

    tm.timeline.getBand(1).getEventPainter().addOnSelectListener(function(eventID) {
      timemapClicked(tm.timeline.getBand(1).getEventSource().getEvent(eventID).item);
    });
}
