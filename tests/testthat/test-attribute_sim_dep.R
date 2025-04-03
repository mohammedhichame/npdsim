test_that("example works", {

  abc <- attribute_sim_dep(product_shapes_and_levels=data.frame(product_id=1:4,assigned_shape=c(1,1,2,2), assigned_level=c(5,3,3,3)),
                           attributes_number=15,
                           shape_attributes_number=7,
                           level_attributes_number=4)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(4,18))
  expect_type(abc$assigned_shape, "double")
  expect_type(abc$assigned_level, "double")
})
