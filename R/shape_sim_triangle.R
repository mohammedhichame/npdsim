#' Generate triangular shapes
#'
#' @description
#' Generate triangular shapes for the demand of new products
#' during their life cycle
#'
#' @param periods_number Number of time periods of the products life cycle
#' @param shape_number Number of generic shapes
#'
#' @return A numeric dateframe of three columns: time, shape and assigned_shape
#' @export
#'
#' @import dplyr
#'
#' @examples
#' shape_sim_triangle(periods_number=20, shape_number=5)
shape_sim_triangle <- function(periods_number,shape_number) {


  list1 <- list()


  # 1 change point == 2 segments
  # we choose the change point to be close to the center of the interval
  # [1, periods_number]
  # if c_inter is the center of the interval
  # then we assume the change point to be between:
  # -20%*periods_number+c_inter and
  # 20%*periods_number+c_inter

  c_inter <- periods_number/2
  inter1 <- round(-0.2*periods_number+c_inter)
  inter2 <- round(0.2*periods_number+c_inter)

  # angles of the increasing segment
  # low:1, medium:2, high:3
  shape_angles <- data.frame(shape_type=1:3,
                             min=c(0,pi/6, pi/3),
                             max=c(pi/6, pi/3, pi/2*0.9))


  for (i in 1:shape_number){


  change_points <- sample(inter1:inter2, 1)


  # segment 1 (increeasing part)

  shape_type <- sample(1:3, 1) # low:1, medium:2, high:3

  min_range <- tan(shape_angles$min[shape_type])
  max_range <- tan(shape_angles$max[shape_type])

  slope1 <- stats::runif(1,min=min_range,max=max_range)

  intercept1 <- 0

  t <- 0:change_points[1] # from 0 to the first change point

  seg1 <- intercept1+slope1*t

  shape1 <- data.frame(time=t,shape=seg1)


  # segment 2 (decreasing part)

  intercept2 <- seg1[change_points[1]+1]

  t <- 1:(periods_number-change_points[1]) # time from change_points[1]+1 to periods_number (last point)


  min_slope2 <- -intercept2/(periods_number-change_points[1])

  # slope between 0 and min_slope2 (min_slope2: the slope that makes shape=0 at the last period)

  min_range <- min_slope2
  max_range <- 0

  slope2 <- stats::runif(1,min=min_range,max=max_range)

  seg2 <- intercept2+slope2*t

  shape2 <- data.frame(time=t+change_points[1],shape=seg2) # time from change_points[1]+1


  # combine the shapes of the 2 segments

  shape_simul <- dplyr::bind_rows(shape1,shape2)

  # normalize the shape

  shape_simul$shape <- shape_simul$shape/sum(shape_simul$shape)

  shape_simul$assigned_shape <- i

  list1[[i]] <- shape_simul

  }

  dplyr::bind_rows(list1)

}
