test_that("first example works", {

  abc <- shape_sim(periods_number=20, shape_number=5)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(105,3))
  expect_type(abc$shape, "double")
  expect_type(abc$assigned_shape, "integer")
})



test_that("second example works", {

  abc <- shape_sim(periods_number=20,
                   shape_number=5,
                   shape_type="trapezoid")

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(105,3))
  expect_type(abc$shape, "double")
  expect_type(abc$assigned_shape, "integer")
})
