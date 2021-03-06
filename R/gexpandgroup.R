##' @include gframe.R
NULL

##' toolkit constructor
##'
##' @export
##' @rdname gWidgets2RGtk2-undocumented
##' @method .gexpandgroup guiWidgetsToolkitRGtk2
## @export .gexpandgroup guiWidgetsToolkitRGtk2
.gexpandgroup.guiWidgetsToolkitRGtk2 <- function(toolkit,
                                                 text, markup,  horizontal=TRUE,
                                                 handler=NULL, action=NULL,
                                                 container=NULL, ...) {
  GExpandGroup$new(toolkit, text=text, markup=markup, horizontal=horizontal, handler=handler, action=action, container=container, ...)
}

## base class from gframe
GExpandGroup <- setRefClass("GExpandGroup",
                            contains="GGroupBase",
                            fields=list(
                              "markup"="logical"
                              ),
                            methods=list(
                              initialize=function(toolkit=NULL, text, markup=FALSE, horizontal=TRUE, handler, action, container=NULL, ..., expand=FALSE, fill=FALSE) {

                                horizontal <<- horizontal
                                if(is(widget, "uninitializedField")) 
                                  make_widget(text, markup)
                                
                                handler_id <<- add_handler_changed(handler, action)
                                add_to_parent(container, .self, expand, fill, ...)
                                
                                callSuper(toolkit, horizontal=horizontal, ...)
                              },
                              make_widget = function(text, markup) {
                                if(horizontal)
                                  widget <<- gtkHBox()
                                else
                                  widget <<- gtkVBox()
                                
                                markup <<- markup
                                block <<- gtkExpanderNew()
                                if(markup)
                                  block$setUseMarkup(TRUE)
                                block$add(widget)
                                
                                set_names(text)
                              },
                              get_names=function(...) {
                                block$getLabel()
                              },
                              set_names=function(value, ...) {
                                block$setLabel(value)
                              },
                              get_visible = function() {
                                block$getExpanded()
                              },
                              set_visible = function(value) {
                                block$setExpanded(as.logical(value))
                              },
                              set_font = function(value) {
                                label <- block[[2]] # dig it out!
                                 set_rgtk2_font(label, value)
                              },
                              add_handler_changed=function(handler, action, ...) {
                                add_handler("activate", handler, action, ...)
                              }
                              ))
                            
