#' Simulate the demand for new products during their life cycle by specifying their life cycle shape
#'
#' @param products_number Number of products
#' @param periods_number Number of periods of the introduction and growth phases
#' @param shape_number Number of generic shapes
#' @param shape_type Type shape to generate. It can take the values: "triangle", "trapezoid", "bass", "random"
#'              The type "random" picks one the other types randomly for each product.
#' @param level_number Number of generic levels
#' @param level_range Range of values from which the level is sampled
#' @param noise_cv The coefficient of variation of the noise added to the simulated sales
#'
#' @return A date frame of three colunms product_id, shape and assigned_shape,
#'          level and assigned_level, demand_wn (demand without noise, not rounded),
#'          noise and demand. demand is the rounded value of the Max
#'          between (demand_wn+noise) and 0
#' @export
#'
#' @import dplyr
#'
#' @examples
#' demand_sim(products_number=100,periods_number=20,shape_number=5, level_number=20,
#' level_range=1000:10000,noise_cv=0.05)
#'
#' demand_sim(products_number=100,periods_number=20,shape_number=5, shape_type="bass", level_number=20,
#' level_range=1000:10000,noise_cv=0.05)
demand_sim <- function(products_number,periods_number,shape_number, shape_type="random",
                       level_number,level_range=1000:10000,
                       noise_cv) {


  stopifnot("products_number must be a numeric"=is.numeric(products_number))
  stopifnot("periods_number must be a numeric"=is.numeric(periods_number))
  stopifnot("shape_number must be a numeric"=is.numeric(shape_number))
  stopifnot("level_number must be a numeric"=is.numeric(level_number))
  stopifnot("level_range must be a numeric vector"=is.numeric(level_range))
  stopifnot("noise_cv must be a numeric"=is.numeric(noise_cv))


  # simulated levels

  level_table <- data.frame(assigned_level=1:level_number,
                        level=sample(x=level_range,size=level_number,replace=TRUE))


  # simulated shapes

  shapes_table <- shape_sim(periods_number,shape_number, shape_type)


  # assigned shapes and levels by product

  product_shapes_and_levels <- data.frame(product_id=1:products_number,
                              assigned_shape=sample(shape_number,products_number,replace = TRUE),
                              assigned_level=sample(level_number,products_number,replace = TRUE))

  # product sales

  product_sales <- data.frame(product_id=rep(1:products_number, each=periods_number),
                          time=rep(1:periods_number, times=products_number))

  product_sales <- dplyr::left_join(product_sales, product_shapes_and_levels)

  product_sales <- dplyr::left_join(product_sales, level_table)

  product_sales <- dplyr::left_join(product_sales, shapes_table)

  product_sales <- dplyr::mutate(product_sales, demand_wn=shape*level)

  # add noise

  product_sales$noise <- 0

  for (i in 1:length(product_sales$product_id)){

  product_sales$noise[i] <- stats::rnorm(1, mean=0, sd=noise_cv*product_sales$demand_wn[i])

  }

  # sale_modified=sale+noise

  product_sales$demand <- product_sales$sale + product_sales$noise

  # if sale+noise is negative, assign 0
  product_sales$demand[product_sales$demand<0] <- 0

  # round sale_modified (demand has to be an integer)

  product_sales$demand <- round(product_sales$demand)


  product_sales

}

