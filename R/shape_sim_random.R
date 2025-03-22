#' Generate random (Bass, Trapezoidal or Triangular) shapes for the demand of new products during their life cycle
#'
#' @param periods_number Number of time periods of the products life cycle
#' @param shape_number Number of generic shapes
#'
#' @return A numeric dateframe of three colunms: time, shape and assigned_shape
#' @export
#'
#' @examples
#' shape_sim_random(periods_number=20, shape_number=5)
shape_sim_random <- function(periods_number,shape_number) {

  list1 <- list()


  for (i in 1:shape_number){


    sampled_shape <- sample(x=c("triangle", "trapezoid", "bass"),
                            size=1)


    if (sampled_shape=="triangle") {

      shape_simul <- shape_sim_triangle(periods_number,
                                shape_number=1)

    }


    if (sampled_shape=="trapezoid") {

      shape_simul <- shape_sim_trapezoid(periods_number,
                                 shape_number=1)

    }


    if (sampled_shape=="bass") {

      shape_simul <- shape_sim_bass(periods_number,
                            shape_number=1)

    }


    shape_simul$assigned_shape <- i

    list1[[i]] <- shape_simul


  }

  dplyr::bind_rows(list1)

}
