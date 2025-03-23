#' Calculate the Bass probability
#'
#' @description
#' Calculate the Bass probability density function of purchase f(t)
#'
#' @param p_param Coefficient of innovation
#' @param q_param Coefficient of imitation
#' @param t A numeric vector of time periods
#'
#' @return A numeric vector of the probability density function of purchase at time t, f(t)
#' @export
#'
#' @examples
#' npdsim_bass(p_param=0.01,q_param=0.2, t=1:20)
npdsim_bass <- function(p_param,q_param, t) {

  exp((p_param+q_param)*t)*p_param*((p_param+q_param)^2)/(p_param*exp((p_param+q_param)*t)+q_param)^2

}
