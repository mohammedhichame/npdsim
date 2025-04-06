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
#' @param attribute_type Type of relationship between attributes and shape and level.
#'       There can be independent attributes or dependent attributes. attribute_type takes
#'       one of the two values: "dep" and "ind". Check `attribute_sim_dep` and `attribute_sim_dep`.
#' @param product_shapes_and_levels A numeric dateframe of three columns: product_id, assigned_shape and assigned_level
#' @param attributes_number The number of attributes
#' @param shape_attributes_number The number of attributes assigned to shape
#' @param level_attributes_number The number of attributes assigned to level
#'
#'
#' @return A date frame that contains the following columns: product_id, demand and attributes.
#' @export
#'
#' @import dplyr
#' @import tidyr
#'
#' @examples
#' npd_data_sim(products_number=100,
#' periods_number=30,
#' shape_number=5,
#' level_number=20)
#'
#' npd_data_sim(products_number=100,
#' periods_number=20,
#' shape_number=5,
#' shape_type="bass",
#' level_number=20,
#' level_range=1000:10000,
#' noise_cv=0.05,
#' attribute_type="ind",
#' attributes_number=15,
#' shape_attributes_number=7,
#' level_attributes_number=5)
#'
#'
npd_data_sim <- function(products_number,
                         periods_number,
                         shape_number,
                         shape_type="random",
                       level_number,
                       level_range=1000:10000,
                       noise_cv=0.05,
                       attribute_type="ind",
                       attributes_number=10,
                       shape_attributes_number=5,
                       level_attributes_number=3) {


demand_np <- demand_sim(products_number,
             periods_number,
             shape_number,
             shape_type,
             level_number,
             level_range,
             noise_cv)

demand_np1 <- dplyr::select(demand_np, product_id, assigned_shape, assigned_level)

demand_np1 <- dplyr::distinct(demand_np1)

  if (attribute_type=="dep") {

    attribute_np <- attribute_sim_dep(product_shapes_and_levels=demand_np1,
                      attributes_number,
                      shape_attributes_number,
                      level_attributes_number)
  }


  if (attribute_type=="ind") {

    attribute_np <- attribute_sim_ind(product_shapes_and_levels=demand_np1,
                      attributes_number,
                      shape_attributes_number,
                      level_attributes_number)

  }


demand_np <- dplyr::left_join(demand_np,
                              attribute_np,
                              by = join_by(product_id,
                                           assigned_shape,
                                           assigned_level))

dplyr::select(demand_np,-c(assigned_shape,
                             assigned_level,
                             level,
                             shape,
                             demand_wn,
                             noise))


}
