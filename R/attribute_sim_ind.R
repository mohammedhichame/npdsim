#' Simulate the Attributes with the Assumption of Independent Attributes
#'
#' @description
#' Simulate the attributes for each product with the assumption
#' that the attributes of shapes are independent of the attributes of levels
#' We mean by independence the fact that each attribute is related to one of
#' the following: shape, level or nothing
#'
#' @param product_shapes_and_levels A numeric dateframe of three colunms: product_id, assigned_shape and assigned_level
#' @param attributes_number The number of attributes
#' @param shape_attributes_number The number of attributes assigned to shape
#' @param level_attributes_number The number of attributes assigned to level
#'
#' @return A numeric dateframe of three colunms: product_id, assigned_shape and assigned_level and attributes (as columns)
#' @export
#'
#' @examples
#' attribute_sim_ind(product_shapes_and_levels=data.frame(product_id=1:3,assigned_shape=c(1,1,2), assigned_level=c(5,3,1)),
#' attributes_number=15,
#' shape_attributes_number=7,
#' level_attributes_number=4)
#'
attribute_sim_ind <- function(product_shapes_and_levels,attributes_number,
                          shape_attributes_number, level_attributes_number) {


stopifnot("attributes_number must be a numeric"=is.numeric(attributes_number))

stopifnot("shape_attributes_number must be a numeric"=is.numeric(shape_attributes_number))

stopifnot("level_attributes_number must be a numeric"=is.numeric(level_attributes_number))

stopifnot("shape_attributes_number+level_attributes_number has to be less than or equal to attributes_number"=((shape_attributes_number+level_attributes_number)<=attributes_number))

stopifnot("attributes_number has to be greater than 0"=(attributes_number>0))

stopifnot("shape_attributes_number has to be greater than 0"=(shape_attributes_number>0))

stopifnot("level_attributes_number has to be greater than 0"=(level_attributes_number>0))



shape_set <- unique(product_shapes_and_levels$assigned_shape)

level_set <- unique(product_shapes_and_levels$assigned_level)

# which attributes are related to shape
shape_attributes_name <- sample(x = 1:attributes_number,
                                size = shape_attributes_number,
                                replace = FALSE)

# which attributes are related to level (different than the attribuates related to shape)
level_attributes_name <- sample(x = (1:attributes_number)[-shape_attributes_name],
                                size = level_attributes_number,
                                replace = FALSE)

# attributes values per shape
attributes_per_shape <- data.frame(assigned_shape=rep(shape_set,each=shape_attributes_number),
                                   attribute=rep(shape_attributes_name, times=length(shape_set)),
                                   value=sample(x = 1:20,size = shape_attributes_number*length(shape_set),replace = TRUE))

attributes_per_shape <- tidyr::pivot_wider(data = attributes_per_shape,
                                           names_from = attribute,
                                           names_prefix = "attribute",
                                           values_from = value)


# attributes values per level
attributes_per_level <- data.frame(assigned_level=rep(level_set,each=level_attributes_number),
                                   attribute=rep(level_attributes_name, times=length(level_set)),
                                   value=sample(x = 1:20,size = level_attributes_number*length(level_set),replace = TRUE))

attributes_per_level <- tidyr::pivot_wider(data = attributes_per_level,
                                           names_from = attribute,
                                           names_prefix = "attribute",
                                           values_from = value)


# output: attribute per each combination of shape and level

attribute_shapes_and_levels <- data.frame(assigned_shape=rep(shape_set, each=length(level_set)),
                                          assigned_level=rep(level_set, times=length(shape_set)))

# assign to it the unassigned attributes

unassigned_attributes_name <- (1:attributes_number)[-c(shape_attributes_name,level_attributes_name)]


unassigned_attribute_shapes_and_levels <- data.frame(assigned_shape=rep(attribute_shapes_and_levels$assigned_shape,
                                                                        times=length(unassigned_attributes_name)))

unassigned_attribute_shapes_and_levels$assigned_level <- rep(attribute_shapes_and_levels$assigned_level,
                                                             times=length(unassigned_attributes_name))

unassigned_attribute_shapes_and_levels$attribute <- rep(unassigned_attributes_name,
                                                        each=length(shape_set)*length(level_set))

unassigned_attribute_shapes_and_levels$value <- sample(x = 1:20,
                                                       size = length(unassigned_attribute_shapes_and_levels$attribute),
                                                       replace = TRUE)


unassigned_attribute_shapes_and_levels <- tidyr::pivot_wider(data = unassigned_attribute_shapes_and_levels,
                                                             names_from = attribute,
                                                             names_prefix = "attribute",
                                                             values_from = value)


# assign to all the attributes

attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                unassigned_attribute_shapes_and_levels,
                                                by = join_by(assigned_shape, assigned_level))

attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                attributes_per_shape,
                                                by = join_by(assigned_shape))

attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                attributes_per_level,
                                                by = join_by(assigned_level))


# assign the attributes to products

dplyr::left_join(product_shapes_and_levels,
                 attribute_shapes_and_levels,
                 by = join_by(assigned_shape, assigned_level))


}
