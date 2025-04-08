test_that("example 1 works", {

 abc <- npd_data_sim(products_number=100,
 periods_number=30,
 shape_number=5,
 level_number=20)

    expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(3000,13))
  expect_type(abc$demand, "double")
})




test_that("example 2 works", {

  abc <- npd_data_sim(products_number=100,
               periods_number=20,
               shape_number=5,
               shape_type="bass",
               level_number=20,
               level_range=1000:10000,
               noise_cv=0.05,
               attribute_type="ind",
               attributes_number=15,
               shape_attributes_number=7,
               level_attributes_number=5)


  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(2000,18))
  expect_type(abc$demand, "double")
})



test_that("simulating data for one product works", {

  abc <- npd_data_sim(products_number=1,
                      periods_number=20,
                      shape_number=5,
                      shape_type="bass",
                      level_number=20,
                      level_range=1000:10000,
                      noise_cv=0.05,
                      attribute_type="ind",
                      attributes_number=15,
                      shape_attributes_number=7,
                      level_attributes_number=5)


  expect_s3_class(abc, "data.frame")
  expect_equal(dim(abc), c(20,18))
  expect_type(abc$demand, "double")
})
