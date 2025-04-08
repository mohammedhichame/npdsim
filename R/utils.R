# global variables: to solve the note:
# no visible binding for global variable '...'

# demand_sim
utils::globalVariables(c("product_id", "assigned_level", "time",
                         "assigned_shape", "shape", "level"))

# attribute_sim_dep & attribute_sim_ind
utils::globalVariables(c("attribute", "value"))

# npd_data_sim
utils::globalVariables(c("demand_wn", "noise"))
