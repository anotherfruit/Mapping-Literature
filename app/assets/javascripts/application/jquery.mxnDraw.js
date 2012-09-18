/*
 * Map draw component based on Mapstraction and jQuery
 *
 * Author: Hiroyuki Sakai <hiroyuki.sakai@alumni.tuwien.ac.at>
 * Year: 2012
 */

Number.prototype.mod = function(n) {
    return ((this % n) + n) % n;
};

(function( $ ){
    $.fn.mxnDraw = function(options)
    {
        var $self = this;
        args = Array.prototype.slice.apply(arguments);
        
        
        var types = {
            MULTI_POINT: 0,
            LINE_STRING: 1,
            POLYGON: 2
        };
        
        var jsonTypes = []
        jsonTypes[types.MULTI_POINT] = "MultiPoint";
        jsonTypes[types.LINE_STRING] = "LineString";
        jsonTypes[types.POLYGON] = "Polygon";
        
        
        var settings = {
            $map: $self,
            $addButtonMarkers: $("#addButtonMultiPoint"),
            $addButtonPolylineOpen: $("#addButtonLineString"),
            $addButtonPolylineClosed: $("#addButtonPolygon"),
            $list: $("#features"),
            $log: $("#log"),

            mapstraction: $self.data('map'),
            addButtonClassActive: "active",
            anchorClassActive: "active",
            anchorClassSelect: "select",
            anchorClassRemove: "remove",
            anchorClassHide: "hide",
            anchorClassShow: "show",
            anchorLabelRemove: "Remove",
            anchorLabelHide: "Hide",
            anchorLabelShow: "Show",
            iconUrl: "/assets/mxnDraw/marker.png",
            iconSize: [12, 12],
            iconAnchor: [6, 6],
            startIconUrl: "/assets/mxnDraw/markerA.png",
            startIconSize: [12, 12],
            startIconAnchor: [6, 0],
            endIconUrl: "/assets/mxnDraw/markerB.png",
            endIconSize: [12, 12],
            endIconAnchor: [6, 12],
            editIconUrl: "/assets/mxnDraw/markerEdit.png",
            editIconSize: [12, 12],
            editIconAnchor: [6, 6],
            multipleFeatures: false,
            polylineColor: "#FF0000",
            polylineFillColor: "#FF0000",
            polylineOpacity: 0.75,
            logSpace: 2
        };
        
        
        var collection = {
            type: "FeatureCollection",
            features: []
        };
        
        var feature;
        
        
        var methods = {
            addFeature: function(type) {
                if ($.inArray(type, types) && (settings.multipleFeatures || collection.features.length < 1))
                {
                    for (var i = 0; i < $addButtons.length; i++)
                    {
                        $addButtons[i].removeClass(settings.addButtonClassActive);
                    }
                    
                    $addButtons[type].addClass(settings.addButtonClassActive);
                    
                    
                    feature = {
                        type: "Feature",
                        geometry: {
                            type: jsonTypes[type],
                            coordinates: []
                        },
                        properties: {
                            internal: {
                                mxnMarkers: []
                            }
                        }
                    };
                    
                    if (type == types.LINE_STRING || type == types.POLYGON)
                    {
                        feature.properties.internal.mxnEditMarkers = [];
                    }
                    
                    collection.features.push(feature)
                    
                    
                    if (settings.$list != undefined)
                    {
                        //var $anchor = $('<li><a href="#" class="' + settings.anchorClassHide + '">' + settings.anchorLabelHide + '</a><a href="#" class="' + settings.anchorClassSelect + '">' + feature.geometry.type + '</a><a href="#" class="' + settings.anchorClassRemove + '">' + settings.anchorLabelRemove + '</a></li>');
                        var $anchor = $('<li><a href="#" class="' + settings.anchorClassHide + '">' + settings.anchorLabelHide + '</a>' + feature.geometry.type + '<a href="#" class="' + settings.anchorClassRemove + '">' + settings.anchorLabelRemove + '</a></li>');
                        // cross-reference
                        $anchor.data("feature", feature);
                        feature.properties.internal.$anchor = $anchor;
                        settings.$list.append($anchor);
                    }
                    
                    
                    methods.selectFeature(feature);
                }
                else
                {
                    feature = undefined;
                }
            },
            selectFeature: function(myFeature) {
                if (myFeature != undefined)
                {
                    feature = myFeature;
                    
                    
                    if (settings.$list != undefined)
                    {
                        settings.$list.children("li").removeClass(settings.anchorClassActive);
                        feature.properties.internal.$anchor.addClass(settings.anchorClassActive);
                    }
                }
            },
            removeFeature: function(myFeature) {
                if (myFeature != undefined)
                {
                    methods.selectFeature(myFeature);
                    
                    for (var i = 0; i < myFeature.properties.internal.mxnMarkers.length; i++)
                    {
                        settings.mapstraction.removeMarker(myFeature.properties.internal.mxnMarkers[i]);
                    }
                    
                    if (feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON])
                    {
                        for (var i = 0; i < myFeature.properties.internal.mxnEditMarkers.length; i++)
                        {
                            settings.mapstraction.removeMarker(myFeature.properties.internal.mxnEditMarkers[i]);
                        }
                    }
                    
                    if (myFeature.properties.internal.mxnPolyline != undefined)
                    {
                        settings.mapstraction.removePolyline(myFeature.properties.internal.mxnPolyline);
                    }
                    
                    if (settings.$list != undefined)
                    {
                        myFeature.properties.internal.$anchor.remove();
                    }
                    
                    collection.features.splice($.inArray(myFeature, collection.features), 1);
                    feature = undefined;
                }
            },
            hideFeature: function(myFeature) {
                if (myFeature != undefined)
                {
                    methods.selectFeature(myFeature);
                    
                    for (var i = 0; i < myFeature.properties.internal.mxnMarkers.length; i++)
                    {
                        myFeature.properties.internal.mxnMarkers[i].hide();
                    }
                    
                    if (feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON])
                    {
                        for (var i = 0; i < myFeature.properties.internal.mxnEditMarkers.length; i++)
                        {
                            myFeature.properties.internal.mxnEditMarkers[i].hide();
                        }
                        
                        if (myFeature.properties.internal.mxnPolyline != undefined)
                        {
                            settings.mapstraction.removePolyline(myFeature.properties.internal.mxnPolyline);
                            delete feature.properties.internal.mxnPolyline;
                        }
                    }
                }
            },
            showFeature: function(myFeature) {
                if (myFeature != undefined)
                {
                    methods.selectFeature(myFeature);
                    
                    for (var i = 0; i < myFeature.properties.internal.mxnMarkers.length; i++)
                    {
                        myFeature.properties.internal.mxnMarkers[i].show();
                    }
                    
                    if (feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON])
                    {
                        for (var i = 0; i < myFeature.properties.internal.mxnEditMarkers.length; i++)
                        {
                            myFeature.properties.internal.mxnEditMarkers[i].show();
                        }
                        
                        methods.drawLine();
                    }
                }
            },
            // "add or replace ..."
            addCoordinate: function(location, attributes, index, insert) {
                if (feature != undefined)
                {
                    var marker = new mxn.Marker(location);
                    
                    if (attributes != undefined)
                    {
                        marker.attributes = attributes;
                    }
                    
                    // cross-reference
                    marker.setAttribute("feature", feature);
                    marker.setDraggable(true);
                    
                    // set up marker click handler: remove marker
                    marker.click.addHandler(function(eventName, eventSource, eventArgs)
                    {
                        methods.selectFeature(marker.getAttribute("feature"));
                        
                        settings.mapstraction.removeMarker(marker);
                        var index = $.inArray(marker, feature.properties.internal.mxnMarkers);
                        feature.properties.internal.mxnMarkers.splice(index, 1);
                        
                        
                        if (feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON])
                        {
                            if (feature.properties.internal.mxnMarkers.length > 0)
                            {
                                if (index == 0)
                                {
                                    methods.updateMarker(index);
                                }
                                else
                                {
                                    methods.updateMarker(index - 1);
                                }
                            }
                            
                            
                            var previousEditMarkerIndex;
                            
                            for (var key in marker.attributes.editMarkers)
                            {
                                settings.mapstraction.removeMarker(marker.attributes.editMarkers[key]);
                                var editMarkerIndex = $.inArray(marker.attributes.editMarkers[key], feature.properties.internal.mxnEditMarkers);
                                
                                if (key == "previous")
                                {
                                    previousEditMarkerIndex = editMarkerIndex;
                                }
                                
                                feature.properties.internal.mxnEditMarkers.splice(editMarkerIndex, 1);
                            }
                            
                            if (feature.properties.internal.mxnEditMarkers.length == 1)
                            {
                                // update only edit marker to reflect eventual direction change
                                settings.mapstraction.removeMarker(feature.properties.internal.mxnEditMarkers[0]);
                                feature.properties.internal.mxnEditMarkers.splice($.inArray(feature.properties.internal.mxnEditMarkers[0], feature.properties.internal.mxnEditMarkers), 1);
                                delete feature.properties.internal.mxnMarkers[0].attributes.editMarkers.previous;
                                delete feature.properties.internal.mxnMarkers[1].attributes.editMarkers.next;
                                
                                methods.addEditMarker(feature.properties.internal.mxnMarkers[0], feature.properties.internal.mxnMarkers[1]);
                            }
                            else if (feature.properties.internal.mxnEditMarkers.length > 1 && ((index > 0 && index < feature.properties.internal.mxnMarkers.length) || feature.geometry.type == jsonTypes[types.POLYGON]))
                            {
                                methods.addEditMarker(feature.properties.internal.mxnMarkers[(index - 1).mod(feature.properties.internal.mxnMarkers.length)], feature.properties.internal.mxnMarkers[index.mod(feature.properties.internal.mxnMarkers.length)], previousEditMarkerIndex);
                            }
                            
                            if (feature.geometry.type == jsonTypes[types.LINE_STRING] && feature.properties.internal.mxnMarkers.length > 0)
                            {
                                if (index == 0)
                                {
                                    delete feature.properties.internal.mxnMarkers[0].attributes.editMarkers.previous;
                                }
                                else if (index == feature.properties.internal.mxnMarkers.length)
                                {
                                    delete feature.properties.internal.mxnMarkers[feature.properties.internal.mxnMarkers.length - 1].attributes.editMarkers.next;
                                }
                            }
                            
                            methods.drawLine();
                        }
                    });
                    
                    marker.dragEnd.addHandler(function() {
                        methods.selectFeature(marker.getAttribute("feature"));
                        
                        if (feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON])
                        {
                            // update edit marker positions
                            for (var key in marker.attributes.editMarkers)
                            {
                                settings.mapstraction.removeMarker(marker.attributes.editMarkers[key]);
                                var index = $.inArray(marker.attributes.editMarkers[key], feature.properties.internal.mxnEditMarkers);
                                feature.properties.internal.mxnEditMarkers.splice(index, 1);
                                methods.addEditMarker(marker.attributes.editMarkers[key].attributes.markers.previous, marker.attributes.editMarkers[key].attributes.markers.next, index);
                            }
                            
                            methods.drawLine();
                        }
                    });
                    
                    
                    // replace existing marker (to reset icon)
                    if (typeof(index) == "number")
                    {
                        // insert marker
                        if (insert)
                        {
                            feature.properties.internal.mxnMarkers.splice(index, 0, marker);
                            methods.addEditMarker(feature.properties.internal.mxnMarkers[(index - 1).mod(feature.properties.internal.mxnMarkers.length)], marker);
                            
                            if ((index > 0 && index < feature.properties.internal.mxnMarkers.length) || feature.geometry.type == jsonTypes[types.POLYGON])
                            {
                                methods.addEditMarker(marker, feature.properties.internal.mxnMarkers[(index + 1).mod(feature.properties.internal.mxnMarkers.length)]);
                            }
                            
                            methods.drawLine();
                        }
                        // replace existing marker
                        else
                        {
                            // update references of edit markers
                            if (marker.attributes.editMarkers.previous != undefined)
                            {
                                marker.attributes.editMarkers.previous.attributes.markers.next = marker;
                            }
                            if (marker.attributes.editMarkers.next != undefined)
                            {
                                marker.attributes.editMarkers.next.attributes.markers.previous = marker;
                            }
                            
                            feature.properties.internal.mxnMarkers[index] = marker;
                        }
                        
                        if ((feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON]))
                        {
                            if (index == 0)
                            {
                                marker.setIcon(settings.startIconUrl, settings.startIconSize, settings.startIconAnchor);
                            }
                            else if (index == feature.properties.internal.mxnMarkers.length - 1)
                            {
                                methods.updateMarker(feature.properties.internal.mxnMarkers.length - 2);
                                marker.setIcon(settings.endIconUrl, settings.endIconSize, settings.endIconAnchor);
                            }
                            else
                            {
                                marker.setIcon(settings.iconUrl, settings.iconSize, settings.iconAnchor);
                            }
                        }
                        else
                        {
                            marker.setIcon(settings.iconUrl, settings.iconSize, settings.iconAnchor);
                        }
                    }
                    // add new marker
                    else
                    {
                        feature.properties.internal.mxnMarkers.push(marker);
                        
                        if ((feature.geometry.type == jsonTypes[types.LINE_STRING] || feature.geometry.type == jsonTypes[types.POLYGON]))
                        {
                            // create edit marker
                            if (feature.properties.internal.mxnMarkers.length > 1)
                            {
                                if (feature.geometry.type == jsonTypes[types.POLYGON] && feature.properties.internal.mxnEditMarkers.length > 2)
                                {
                                    settings.mapstraction.removeMarker(feature.properties.internal.mxnEditMarkers.pop());
                                }
                                
                                methods.addEditMarker(feature.properties.internal.mxnMarkers[feature.properties.internal.mxnMarkers.length - 2], marker);
                                
                                if (feature.geometry.type == jsonTypes[types.POLYGON] && feature.properties.internal.mxnEditMarkers.length > 1)
                                {
                                    methods.addEditMarker(marker, feature.properties.internal.mxnMarkers[0]);
                                }
                            }
                            
                            
                            // set icon for first marker
                            if (feature.properties.internal.mxnMarkers.length == 1)
                            {
                                marker.setIcon(settings.startIconUrl, settings.startIconSize, settings.startIconAnchor);
                            }
                            else
                            {
                                if (feature.properties.internal.mxnMarkers.length > 2)
                                {
                                    methods.updateMarker(feature.properties.internal.mxnMarkers.length - 2);
                                }
                                
                                marker.setIcon(settings.endIconUrl, settings.endIconSize, settings.endIconAnchor);
                            }
                            
                            methods.drawLine();
                        }
                        else
                        {
                            marker.setIcon(settings.iconUrl, settings.iconSize, settings.iconAnchor);
                        }
                    }
                    
                    
                    settings.mapstraction.addMarker(marker);
                }
            },
            updateMarker: function(index){
                if (feature != undefined)
                {
                    if (feature.properties.internal.mxnMarkers[index].attributes != undefined)
                    {
                        var markerAttributes = feature.properties.internal.mxnMarkers[index].attributes;
                    }
                    
                    settings.mapstraction.removeMarker(feature.properties.internal.mxnMarkers[index]);
                    methods.addCoordinate(feature.properties.internal.mxnMarkers[index].location, markerAttributes, index);
                }
            },
            addEditMarker: function(marker1, marker2, index) {
                if (feature != undefined)
                {
                    var editMarker = new mxn.Marker(new mxn.LatLonPoint((marker1.location.lat + marker2.location.lat) / 2, (marker1.location.lon + marker2.location.lon) / 2));
                    
                    // cross-reference
                    editMarker.setAttribute("feature", feature);
                    
                    // save cross-reference from and to new edit marker
                    editMarker.attributes.markers = {
                        previous: marker1,
                        next: marker2
                    }
                    
                    editMarker.setDraggable(true);
                    editMarker.setIcon(settings.editIconUrl, settings.editIconSize, settings.editIconAnchor);
                    
                    editMarker.dragEnd.addHandler(function() {
                        methods.selectFeature(editMarker.getAttribute("feature"));
                        methods.addCoordinate(editMarker.location, undefined, $.inArray(editMarker.attributes.markers.previous, feature.properties.internal.mxnMarkers) + 1, true);
                        
                        settings.mapstraction.removeMarker(editMarker);
                        feature.properties.internal.mxnEditMarkers.splice($.inArray(editMarker, feature.properties.internal.mxnEditMarkers), 1);
                    });
                    
                    
                    if (marker1.attributes.editMarkers == undefined)
                    {
                        marker1.attributes.editMarkers = {};
                    }
                    marker1.attributes.editMarkers.next = editMarker;
                    
                    if (marker2.attributes.editMarkers == undefined)
                    {
                        marker2.attributes.editMarkers = {};
                    }
                    marker2.attributes.editMarkers.previous = editMarker;
                    
                    
                    if (index != undefined)
                    {
                        feature.properties.internal.mxnEditMarkers.splice(index, 0, editMarker);
                    }
                    else
                    {
                        feature.properties.internal.mxnEditMarkers.push(editMarker);
                    }
                    
                    
                    settings.mapstraction.addMarker(editMarker);
                }
            },
            drawLine: function() {
                if (feature != undefined)
                {
                    if (feature.properties.internal.mxnMarkers.length == 0)
                    {
                        settings.mapstraction.removePolyline(feature.properties.internal.mxnPolyline);
                        delete feature.properties.internal.mxnPolyline;
                    }
                    else if (feature.properties.internal.mxnMarkers.length > 0)
                    {
                        var points = [];
                        
                        for (var i = 0; i < feature.properties.internal.mxnMarkers.length; i++)
                        {
                            var marker = feature.properties.internal.mxnMarkers[i];
                            points.push(new mxn.LatLonPoint(marker.location.lat, marker.location.lon));
                        }
                        
                        if (feature.properties.internal.mxnPolyline != undefined)
                        {
                            settings.mapstraction.removePolyline(feature.properties.internal.mxnPolyline);
                        }
                        
                        // cross-reference
                        feature.properties.internal.mxnPolyline = new mxn.Polyline(points);
                        feature.properties.internal.mxnPolyline.setAttribute("feature", feature);
                        
                        feature.properties.internal.mxnPolyline.setColor(settings.polylineColor);
                        feature.properties.internal.mxnPolyline.setOpacity(settings.polylineOpacity);
                        
                        if (feature.geometry.type == jsonTypes[types.POLYGON])
                        {
                            feature.properties.internal.mxnPolyline.setClosed(true);
                            feature.properties.internal.mxnPolyline.setFillColor(settings.polylineFillColor);
                        }
                        
                        settings.mapstraction.addPolyline(feature.properties.internal.mxnPolyline);
                    }
                }
            },
            updateCollection: function() {
                for (var i = 0; i < collection.features.length; i++)
                {
                    if (collection.features[i].geometry.type == jsonTypes[types.POLYGON])
                    {
                        collection.features[i].geometry.coordinates[0] = [];
                        
                        for (var j = 0; j < collection.features[i].properties.internal.mxnMarkers.length; j++)
                        {
                            collection.features[i].geometry.coordinates[0][j] = [collection.features[i].properties.internal.mxnMarkers[j].location.lon, collection.features[i].properties.internal.mxnMarkers[j].location.lat];
                        }
                        
                        collection.features[i].geometry.coordinates[0][j] = [collection.features[i].properties.internal.mxnMarkers[0].location.lon, collection.features[i].properties.internal.mxnMarkers[0].location.lat];
                    }
                    else
                    {
                        for (var j = 0; j < collection.features[i].properties.internal.mxnMarkers.length; j++)
                        {
                            collection.features[i].geometry.coordinates[j] = [collection.features[i].properties.internal.mxnMarkers[j].location.lon, collection.features[i].properties.internal.mxnMarkers[j].location.lat];
                        }
                    }
                }
            },
            logCollection: function() {
                if (settings.$log != undefined)
                {
                    settings.$log.html(JSON.stringify(collection, function(key, val) {
                        if (key == "properties")
                        {
                            return undefined;
                        }
                        
                        return val;
                    }, settings.logSpace));
                }
            }
        }
        
        
        var instanceMethods = {
            getCollection: function() {
                methods.updateCollection();
                
                return collection;
            }
        }
        
        
        if ($self.data("mxnDraw-defined"))
        {
            settings = $self.data("mxnDraw-settings");
            collection = $self.data("mxnDraw-collection");
            
            if (args.length > 0)
            {
                return instanceMethods[args[0]].apply(this,args.slice(1, args.length));
            }
        }
        else
        {
            $self.data("mxnDraw-defined", true);
            
            if (args.length > 0 && $.isPlainObject(args[0]))
            {
                settings = $.extend(settings, args[0]);
            }
            
            $self.data("mxnDraw-settings", settings);
            $self.data("mxnDraw-collection", collection);
            
            
            var $addButtons = [];
            $addButtons[types.MULTI_POINT] = settings.$addButtonMarkers;
            $addButtons[types.LINE_STRING] = settings.$addButtonPolylineOpen;
            $addButtons[types.POLYGON] = settings.$addButtonPolylineClosed;
            
            
            if (settings.collection != undefined)
            {
                for (var i = 0; i < settings.collection.features.length; i++)
                {
                    if (settings.collection.features[i].geometry.type == jsonTypes[types.MULTI_POINT])
                    {
                        methods.addFeature(types.MULTI_POINT);
                    }
                    else if (settings.collection.features[i].geometry.type == jsonTypes[types.LINE_STRING])
                    {
                        methods.addFeature(types.LINE_STRING);
                    }
                    else if (settings.collection.features[i].geometry.type == jsonTypes[types.POLYGON])
                    {
                        methods.addFeature(types.POLYGON);
                    }
                    

                    if (settings.collection.features[i].geometry.type == jsonTypes[types.POLYGON])
                    {
                        for (var j = 0; j < settings.collection.features[i].geometry.coordinates[0].length; j++)
                        {
                            methods.addCoordinate(new mxn.LatLonPoint(settings.collection.features[i].geometry.coordinates[0][j][1], settings.collection.features[i].geometry.coordinates[0][j][0]));
                        }
                    }
                    else
                    {
                        for (var j = 0; j < settings.collection.features[i].geometry.coordinates.length; j++)
                        {
                            methods.addCoordinate(new mxn.LatLonPoint(settings.collection.features[i].geometry.coordinates[j][1], settings.collection.features[i].geometry.coordinates[j][0]));
                        }
                    }
                }
            }
            
            
            // set up button handlers
            settings.$addButtonMarkers.click(function(event) {
                event.preventDefault();
                methods.addFeature(types.MULTI_POINT);
            });
            
            settings.$addButtonPolylineOpen.click(function(event) {
                event.preventDefault();
                methods.addFeature(types.LINE_STRING);
            });
            
            settings.$addButtonPolylineClosed.click(function(event) {
                event.preventDefault();
                methods.addFeature(types.POLYGON);
            });
            
            
            if (settings.$list != undefined)
            {
                settings.$list.find("a." + settings.anchorClassSelect).live("click", function() {
                    methods.selectFeature($(this).parent().data("feature"));
                });
                
                settings.$list.find("a." + settings.anchorClassRemove).live("click", function() {
                    methods.removeFeature($(this).parent().data("feature"));
                });
                
                settings.$list.find("a." + settings.anchorClassHide).live("click", function() {
                    $this = $(this);
                    methods.hideFeature($this.parent().data("feature"));
                    $this.removeClass(settings.anchorClassHide).addClass(settings.anchorClassShow);
                    $this.html(settings.anchorLabelShow);
                });
                
                settings.$list.find("a." + settings.anchorClassShow).live("click", function() {
                    $this = $(this);
                    methods.showFeature($(this).parent().data("feature"));
                    $this.removeClass(settings.anchorClassShow).addClass(settings.anchorClassHide);
                    $this.html(settings.anchorLabelHide);
                });
            }
            
            
            // set up map click handler: create new coordinate
            settings.mapstraction.click.addHandler(function(eventName, eventSource, eventArgs) {
                methods.addCoordinate(eventArgs.location);
            });
        }
        
        
        return $self;
    };
})( jQuery );
