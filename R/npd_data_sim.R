#' Simulate the demand and attributes for new products
#'
#' @description
#' Simulate the demand and attributes for new products during their life cycle by
#' specifying their life cycle type of shape and providing information about
#' their attributes.
#'
#' @param products_number Number of products
#' @param periods_number Number of periods of the introduction and growth phases
#' @param shape_number Number of generic shapes
#' @param shape_type Type of shape to generate. It can take the values: "triangle",
#'            "trapezoid", "bass", "random" and "intro & growth".
#'              The type "random" picks one of the types "triangle",
#'            "trapezoid", "bass" randomly for each product.
#'            The type "intro & growth" is used for the shapes of the introduction
#'            and growth phases.
#' @param level_number Number of generic levels
#' @param level_range Range of values from which the level is sampled
#' @param noise_cv The coefficient of variation of the noise added to the simulated sales
#'
#' @return A date frame that contains the following columns: product_id, shape and assigned_shape,
#'          level and assigned_level, demand_wn (demand without noise, not rounded),
#'          noise and demand. demand is the rounded value of the Max
#'          between (demand_wn+noise) and 0
#' @export
#'
#' @import dplyr
#' @import tidyr
#'
#' @examples
#' npd_data_sim(products_number=100,periods_number=20,shape_number=5, level_number=20)
#'
#' npd_data_sim(products_number=100,periods_number=20,shape_number=5, shape_type="bass", level_number=20,
#' level_range=1000:10000,noise_cv=0.05)
npd_data_sim <- function(products_number,periods_number,shape_number, shape_type="random",
                       level_number,level_range=1000:10000,
                       noise_cv=0.05,
                       attributes_number,
                       shape_attributes_number,
                       level_attributes_number) {



demand_np <- demand_sim(products_number = ,
             periods_number = ,
             shape_number = ,
             shape_type = ,
             level_number = ,
             level_range = ,
             noise_cv = )


  if (attribute_type=="dep") {

    attribute_sim_dep(product_shapes_and_levels,
                      attributes_number,
                      shape_attributes_number,
                      level_attributes_number)


  }


  if (attribute_type=="ind") {

    attribute_sim_ind(product_shapes_and_levels,
                      attributes_number,
                      shape_attributes_number,
                      level_attributes_number)


  }



}
