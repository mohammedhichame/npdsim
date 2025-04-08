#' Generate generic Bass shapes
#'
#' @description
#' Generate generic Bass shapes for the demand of new products during their life cycle
#'
#' @param periods_number Number of time periods of the products life cycle
#' @param shape_number Number of generic shapes
#'
#' @return A numeric dateframe of three columns: time, shape and assigned_shape
#' @export
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @examples
#' shape_sim_bass(periods_number=20, shape_number=5)
shape_sim_bass <- function(periods_number,shape_number) {


  list1 <- list()

  for (i in 1:shape_number){

  # max and min of parameters of p and q were taken from Table 1 of Bass (1969)

  p_param <- stats::runif(1,min=0,max=0.03)

  q_param <- stats::runif(1,min=0.1,max=0.6)


  # generate a shape for a product life cycle of length 20, then extend it
  # to the required length.
  # we picked an original curve of 20 periods because we manage somehow
  # to have a good shape in that length
  # we first go to a time interval [0,1] then go to the required interval
  # [0,periods_number]

  t=1:20

  shape <- data.frame(time=c(0,t),
                      shape=c(0,npdsim_bass(p_param,q_param, t)))

  # extension to the interval [0,1]

  shape$time <- shape$time/20

  # extension to periods_number

  extension_ratio <- periods_number

  shape2 <- shape

  shape2$time <- shape2$time*extension_ratio


  # interpolate in the missing periods

  x_full <- 0:periods_number

  xout <- x_full[!(x_full %in% shape2$time)]

  yout <- stats::approx(x=shape2$time, y = shape2$shape, xout=xout, method = "linear")

  shape3 <- data.frame(time=xout,
                       shape=yout$y)

  shape2_bis <- shape2[(shape2$time %in% x_full),] # only take the the time
  # periods that are the intersection between shape2$time and x_full

  shape4 <- dplyr::bind_rows(shape2_bis, shape3)

  shape4 <- dplyr::arrange(shape4, .data$time)


  # normalize the shape

  shape4$shape <- shape4$shape/sum(shape4$shape)

  shape4$assigned_shape <- i

  list1[[i]] <- shape4

  }

  dplyr::bind_rows(list1)

}
