test_that("example 1 works", {

  abc <- demand_sim(products_number=100,
                    periods_number=20,
                    shape_number=5,
                    level_number=20)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(2000,9))
  expect_type(abc$shape, "double")
  expect_type(abc$demand, "double")
})


test_that("example 2 works", {

  abc <- demand_sim(products_number=100,
                    periods_number=20,
                    shape_number=5,
                    shape_type="bass",
                    level_number=20,
                    level_range=1000:10000,
                    noise_cv=0.05)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(2000,9))
  expect_type(abc$shape, "double")
  expect_type(abc$demand, "double")
})



test_that("detection of shape type works", {

  expect_error(demand_sim(products_number=100,
                          periods_number=20,
                          shape_number=5,
                          shape_type="intro",
                          level_number=20,
                          level_range=1000:10000,
                          noise_cv=0.05))
})


test_that("simulation for big numbers of products works", {

  abc <- demand_sim(products_number=1000,
                    periods_number=20,
                    shape_number=3,
                    shape_type="bass",
                    level_number=50,
                    level_range=1000:10000,
                    noise_cv=0.05)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(20000,9))
  expect_type(abc$shape, "double")
  expect_type(abc$demand, "double")

})



test_that("using a big number of shapes works", {

  abc <- demand_sim(products_number=100,
                    periods_number=20,
                    shape_number=300,
                    shape_type="bass",
                    level_number=50,
                    level_range=1000:10000,
                    noise_cv=0.05)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(2000,9))
  expect_type(abc$shape, "double")
  expect_type(abc$demand, "double")

})



test_that("using a big number of levels works", {

  abc <- demand_sim(products_number=100,
                    periods_number=20,
                    shape_number=20,
                    shape_type="bass",
                    level_number=300,
                    level_range=1000:1200,
                    noise_cv=0.05)

  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(2000,9))
  expect_type(abc$shape, "double")
  expect_type(abc$demand, "double")

})
