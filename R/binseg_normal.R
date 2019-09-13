binseg_normal <- structure(function
(data.vec,
  max.segments
){
  result <- .C(
    "binseg_normal_interface",
    data.vec=as.double(data.vec),
    n.data=as.integer(length(data.vec)),
    max.segments=as.integer(max.segments),
    seg.end=integer(max.segments),
    cost=double(max.segments),
    before.mean=double(max.segments),
    after.mean=double(max.segments),
    before.size=integer(max.segments),
    after.size=integer(max.segments),
    invalidates.index=integer(max.segments),
    invalidates.after=integer(max.segments),
    PACKAGE="binseg")
  with(result, data.table(
    seg.end=seg.end+1L,
    before.mean,
    after.mean,
    invalidates.index,
    invalidates.after))
}, ex=function(){

  library(binseg)
  library(data.table)
  binseg_normal(c(1, 2, 4, 4.1), 4)

})
