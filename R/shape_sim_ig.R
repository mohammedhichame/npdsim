#' Generate generic shapes for the introduction and growth phases
#'
#' @description
#' Generate piece-wise linear (4 segments) generic shapes for the introduction and growth phases
#'
#' @param periods_number Number of periods of the introduction and growth phases
#' @param shape_number Number of generic shapes
#'
#' @return A numeric dateframe of three colunms: time, shape and assigned_shape
#' @export
#'
#' @import dplyr
#'
#' @examples
#'piecewise_shape_sim(periods_number=20, shape_number=5)
#'
piecewise_shape_sim <- function(periods_number,
                                shape_number) {


  stopifnot("periods_number must be a numeric"=is.numeric(periods_number))
  stopifnot("shape_number must be a numeric"=is.numeric(shape_number))


  list1 <- list()

  # low:1, medium:2, high:3
  shape_angles <- data.frame(shape_type=1:3,
                         min=c(0,pi/6, pi/3),
                         max=c(pi/6, pi/3, pi/2*0.9))


  for (i in 1:shape_number){


    # 3 change points == 4 segments

    change_points <- sample(1:(periods_number-1), 3, replace=FALSE)

    change_points <- sort(change_points)


    # segment 1

    shape_type <- sample(1:3, 1) # low:1, medium:2, high:3

    min_range <- tan(shape_angles$min[shape_type])
    max_range <- tan(shape_angles$max[shape_type])


    slope1 <- stats::runif(1,min=min_range,max=max_range)

    intercept1 <- 0

    t <- 0:change_points[1] # from 0 to the first change point

    seg1 <- intercept1+slope1*t

    shape1 <- data.frame(time=t,shape=seg1)


    # segment 2

    shape_type <- sample(1:3, 1) # low:1, medium:2, high:3

    min_range <- tan(shape_angles$min[shape_type])
    max_range <- tan(shape_angles$max[shape_type])


    slope2 <- stats::runif(1,min=min_range,max=max_range)

    intercept2 <- seg1[change_points[1]+1]

    t <- 1:(change_points[2]-change_points[1]) # time from change_points[1]+1 to change_points[2]

    seg2 <- intercept2+slope2*t

    shape2 <- data.frame(time=t+change_points[1],shape=seg2) # time from change_points[1]+1


    # segment 3

    shape_type <- sample(1:3, 1) # low:1, medium:2, high:3

    min_range <- tan(shape_angles$min[shape_type])
    max_range <- tan(shape_angles$max[shape_type])

    slope3 <- stats::runif(1,min=min_range,max=max_range)

    intercept3 <- seg2[(change_points[2]-change_points[1])] # shape[change_points[2]]

    t <- 1:(change_points[3]-change_points[2]) # time from change_points[2]+1

    seg3 <- intercept3+slope3*t

    shape3 <- data.frame(time=t+change_points[2],shape=seg3)


    # segment 4

    shape_type <- sample(1:3, 1) # low:1, medium:2, high:3

    min_range <- tan(shape_angles$min[shape_type])
    max_range <- tan(shape_angles$max[shape_type])

    slope4 <- stats::runif(1,min=min_range,max=max_range)

    intercept4 <- seg3[(change_points[3]-change_points[2])]

    t <- 1:(periods_number-change_points[3]) # time from change_points[3]+1

    seg4 <- intercept4+slope4*t

    shape4 <- data.frame(time=t+change_points[3],shape=seg4)

    # combine the shapes of the 4 segments

    shape_simul <- dplyr::bind_rows(shape1,shape2,shape3,shape4)

    # normalize the shape

    shape_simul$shape <- shape_simul$shape/sum(shape_simul$shape)

    shape_simul$assigned_shape <- i

    list1[[i]] <- shape_simul

  }

  dplyr::bind_rows(list1)

}
