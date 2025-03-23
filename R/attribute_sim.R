attribute_sim <- function(product_shapes_and_levels,attributes_number,
                          shape_attributes_number, level_attributes_number) {


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
                                                unassigned_attribute_shapes_and_levels)

attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                attributes_per_shape)

attribute_shapes_and_levels <- dplyr::left_join(attribute_shapes_and_levels,
                                                attributes_per_level)

attribute_shapes_and_levels

}
