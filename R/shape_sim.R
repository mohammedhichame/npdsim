#' Generate the shape of demand of new products by specifying their life cycle shape and and the length of their life cycle
#'
#' @param periods_number Number of time periods of the products life cycle
#' @param shape_number Number of generic shapes
#' @param shape_type Type shape to generate. It can take the values: "triangle", "trapezoid", "bass", "random"
#'              The type "random" picks one the other types randomly for each product.
#'
#' @return A numeric dateframe of three colunms: time, shape and assigned_shape
#' @export
#'
#' @examples
#' shape_sim(periods_number=20, shape_number=5)
#' shape_sim(periods_number=20, shape_number=5,shape_type="trapezoid")
shape_sim <- function(periods_number,shape_number,shape_type="random") {


  if (shape_type=="triangle") {

    return(shape_sim_triangle(periods_number,
                              shape_number))

  }


  if (shape_type=="trapezoid") {

    return(shape_sim_trapezoid(periods_number,
                              shape_number))

  }


  if (shape_type=="bass") {

    return(shape_sim_bass(periods_number,
                              shape_number))

  }


  if (shape_type=="random") {


    return(shape_sim_random(periods_number,
                           shape_number))

  }

}
