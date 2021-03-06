degree.adjustRange <- function(deg, range.out=c(-180,180)) {
    ## this function adjusts angles given in degrees to the range of -180 to +180 degrees (i.e., longitude EU-centered)
    range.in <- range(deg, na.rm=T)
    if (all(findInterval(range.in, c(-181, 195)) == 1)) {
        outsides <- TRUE
        which.out <- which(deg>180)
        out.lag <- deg[which.out]-180
        deg[which.out] <- 179.99999999
    } else {
        outsides <- FALSE
    }
    if (diff(range.out) != 360) stop("** ERROR ** 'range.out' should span 360 degrees (diff(range.out) != 360) *****")
    deg.range <- findInterval(deg, range.out)
    if (all(deg.range[!is.na(deg.range)]==1)) return(deg)
    which.neg <- which(deg.range==0)
    which.pos <- which(deg.range==2)
    if (length(which.neg) > 0) {
        negvals <- deg[which.neg]
        nadd <- ceiling(-(negvals-range.out[1])/360)
        negvals <- negvals+360*nadd
        deg[which.neg] <- negvals
    }
    if (length(which.pos) > 0) {
        posvals <- deg[which.pos]
        nadd <- ceiling((posvals-range.out[2])/360)
        posvals <- posvals-360*nadd
        deg[which.pos] <- posvals
    }
    if (outsides) deg[which.out] = deg[which.out]+out.lag
    return(deg)
}
