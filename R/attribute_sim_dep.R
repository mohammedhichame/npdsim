#' Simulate the Attributes with the Assumption of Dependent Attributes
#'
#' @description
#' Simulate the attributes for each product with the assumption
#' that some of the attributes related to shapes are also related to some
#' of the attributes of levels.
#' We mean by dependence the fact that some attributes are related at the same time
#' to shape and level.
#'
#'
#' @param product_shapes_and_levels A numeric dateframe of three columns: product_id, assigned_shape and assigned_level
#' @param attributes_number The number of attributes
#' @param shape_attributes_number The number of attributes assigned to shape
#' @param level_attributes_number The number of attributes assigned to level
#'
#' @return A numeric dateframe of three columns: product_id, assigned_shape and assigned_level and attributes (as columns)
#' @export
#'
#' @examples
#' attribute_sim_dep(product_shapes_and_levels=data.frame(product_id=1:4,assigned_shape=c(1,1,2,2), assigned_level=c(5,3,3,3)),
#' attributes_number=15,
#' shape_attributes_number=7,
#' level_attributes_number=4)
#'
attribute_sim_dep <- function(product_shapes_and_levels,attributes_number,
                              shape_attributes_number, level_attributes_number) {

  stopifnot("attributes_number must be a numeric"=is.numeric(attributes_number))

  stopifnot("shape_attributes_number must be a numeric"=is.numeric(shape_attributes_number))

  stopifnot("level_attributes_number must be a numeric"=is.numeric(level_attributes_number))

  stopifnot("shape_attributes_number must be less than or equal to attributes_number"=(shape_attributes_number<=attributes_number))

  stopifnot("level_attributes_number must be less than or equal to attributes_number"=(level_attributes_number<=attributes_number))

  stopifnot("attributes_number has to be greater than 0"=(attributes_number>0))

  stopifnot("shape_attributes_number has to be greater than 0"=(shape_attributes_number>0))

  stopifnot("level_attributes_number has to be greater than 0"=(level_attributes_number>0))



  shape_set <- unique(product_shapes_and_levels$assigned_shape)

  level_set <- unique(product_shapes_and_levels$assigned_level)

  # which attributes are related to shape
  shape_attributes_name <- sample(x = 1:attributes_number,
                                  size = shape_attributes_number,
                                  replace = FALSE)

  # which attributes are related to level (different than the attributes related to shape)

  level_attributes_name <- sample(x = 1:attributes_number,
                                  size = level_attributes_number,
                                  replace = FALSE)

  # attributes values per shape but unrelated to level

  a1 <- (1:attributes_number) %in% shape_attributes_name

  a2 <- (1:attributes_number) %in% level_attributes_name

  only_shape_attributes_name <- (1:attributes_number)[a1 & !a2]

  only_attributes_per_shape <- data.frame(assigned_shape=rep(shape_set,each=length(only_shape_attributes_name)),
                                          attribute=rep(only_shape_attributes_name, times=length(shape_set)),
                                          value=runif(n=length(only_shape_attributes_name)*length(shape_set), min = 0, max = 1))


  only_attributes_per_shape <- tidyr::pivot_wider(data = only_attributes_per_shape,
                                                  names_from = attribute,
                                                  names_prefix = "attribute",
                                                  values_from = value)


  # attributes values per level but unrelated to shape

  a1 <- (1:attributes_number) %in% shape_attributes_name

  a2 <- (1:attributes_number) %in% level_attributes_name

  only_level_attributes_name <- (1:attributes_number)[!a1 & a2]


  only_attributes_per_level <- data.frame(assigned_level=rep(level_set,each=length(only_level_attributes_name)),
                                          attribute=rep(only_level_attributes_name, times=length(level_set)),
                                          value=runif(n=length(only_level_attributes_name)*length(level_set), min = 0, max = 1))

  only_attributes_per_level <- tidyr::pivot_wider(data = only_attributes_per_level,
                                                  names_from = attribute,
                                                  names_prefix = "attribute",
                                                  values_from = value)


  # output: attribute per each combination of shape and level

  attribute_shapes_and_levels <- data.frame(assigned_shape=rep(shape_set, each=length(level_set)),
                                            assigned_level=rep(level_set, times=length(shape_set)))


  # assign to it the common (dependent) attributes

  a1 <- (1:attributes_number) %in% shape_attributes_name

  a2 <- (1:attributes_number) %in% level_attributes_name

  common_attributes_name <- (1:attributes_number)[a1 & a2]

  common_attribute_shapes_and_levels <- data.frame(assigned_shape=rep(attribute_shapes_and_levels$assigned_shape,
                                                                      times=length(common_attributes_name)))

  common_attribute_shapes_and_levels$assigned_level <- rep(attribute_shapes_and_levels$assigned_level,
                                                           times=length(common_attributes_name))

  common_attribute_shapes_and_levels$attribute <- rep(common_attributes_name,
                                                      each=length(shape_set)*length(level_set))

  common_attribute_shapes_and_levels$value <- runif(n=length(common_attribute_shapes_and_levels$attribute),
                                                      min = 0,
                                                      max = 1)


  common_attribute_shapes_and_levels <- tidyr::pivot_wider(data = common_attribute_shapes_and_levels,
                                                           names_from = attribute,
                                                           names_prefix = "attribute",
                                                           values_from = value)


  # assign to it the unassigned attributes

  # a1 <- (1:attributes_number) %in% shape_attributes_name
  #
  # a2 <- (1:attributes_number) %in% level_attributes_name
  #
  # unassigned_attributes_name <- (1:attributes_number)[!(a1 | a2)]
  #
  # unassigned_attribute_shapes_and_levels <- data.frame(assigned_shape=rep(attribute_shapes_and_levels$assigned_shape,
  #                                                                         times=length(unassigned_attributes_name)))
  #
  # unassigned_attribute_shapes_and_levels$assigned_level <- rep(attribute_shapes_and_levels$assigned_level,
  #                                                              times=length(unassigned_attributes_name))
  #
  # unassigned_attribute_shapes_and_levels$attribute <- rep(unassigned_attributes_name,
  #                                                         each=length(shape_set)*length(level_set))
  #
  # unassigned_attribute_shapes_and_levels$value <-  runif(n=length(unassigned_attribute_shapes_and_levels$attribute),
  #                                                         min = 0,
  #                                                         max = 1)
  #
  #
  # unassigned_attribute_shapes_and_levels <- tidyr::pivot_wider(data = unassigned_attribute_shapes_and_levels,
  #                                                              names_from = attribute,
  #                                                              names_prefix = "attribute",
  #                                                              values_from = value)
  #

  # assign to all the attributes

  attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                  common_attribute_shapes_and_levels,
                                                  by = join_by(assigned_shape, assigned_level))

  # attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
  #                                                 unassigned_attribute_shapes_and_levels,
  #                                                 by = join_by(assigned_shape, assigned_level))

  attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                  only_attributes_per_shape,
                                                  by = join_by(assigned_shape))

  attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                  only_attributes_per_level,
                                                  by = join_by(assigned_level))

  # assign the attributes to products

  product_shapes_and_levels <- dplyr::left_join(product_shapes_and_levels,
                                                attribute_shapes_and_levels,
                                                by = join_by(assigned_shape, assigned_level))


  # assign the unassigned attributes


  a1 <- (1:attributes_number) %in% shape_attributes_name

  a2 <- (1:attributes_number) %in% level_attributes_name

  unassigned_attributes_name <- (1:attributes_number)[!(a1 | a2)]

  unassigned_attribute_product <- data.frame(product_id=rep(product_shapes_and_levels$product_id,
                                                            times=length(unassigned_attributes_name)))

  unassigned_attribute_product$attribute <- rep(unassigned_attributes_name,
                                                each=length(product_shapes_and_levels$product_id))

  unassigned_attribute_product$value <- runif(n=length(unassigned_attribute_product$attribute),
                                              min = 0,
                                              max = 1)


  unassigned_attribute_product <- tidyr::pivot_wider(data = unassigned_attribute_product,
                                                     names_from = attribute,
                                                     names_prefix = "attribute",
                                                     values_from = value)

  # join the unassigned attributes with each product

  product_shapes_and_levels <- dplyr::left_join(product_shapes_and_levels,
                                                unassigned_attribute_product,
                                                by = join_by(product_id))


  # add some noise only to the assigned attributes (noise per product)

  for (i in 1:(attributes_number-length(unassigned_attributes_name))) {

    product_shapes_and_levels[,i+3] <- product_shapes_and_levels[,i+3]+  runif(n=length(product_shapes_and_levels$product_id),
                                                                               min = -0.05,
                                                                               max = 0.05)
  }

  product_shapes_and_levels


}
