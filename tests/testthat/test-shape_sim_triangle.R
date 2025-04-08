test_that("example 1 works", {

  abc <- shape_sim_triangle(periods_number=20, shape_number=5)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(105,3))
  expect_type(abc$shape, "double")
})
