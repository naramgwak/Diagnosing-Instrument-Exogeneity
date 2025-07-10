rm(list = ls())

library(bootstrap)
library(AER)

# bootstrap_se
bootstrap_se <- function(fit_fun, data, B = 100) {
  estimates <- replicate(B, {
    idx <- sample(1:nrow(data), replace = TRUE)
    fit_fun(data[idx, ])
  })
  return(sd(estimates))
}

# theta 
theta <- function(x, tmp){
  dat <- tmp[x, ]
  m1 <- ivreg(Y ~ A | IV, data = dat)
  dat$D.s <- dat$Y - dat$P
  m2 <- lm(D.s ~ A, dat)
  
  return(coef(m1)['A'] - coef(m2)['A'])
}

# simulation
# scenario A
sim <- function(k, n.boot, n){
  IV <- rbinom(n, 1, .5)
  U <- k*IV + rnorm(n, 0, 1)
  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
  P <- U + rnorm(n, .5, 1)
  Y <- ifelse(A == 1, .333, 0)*A + U + rnorm(n)
  dat <- data.frame(IV, U, A, P, Y)

# scenario B
#sim <- function(k, n.boot, n){
#  IV <- rbinom(n, 1, .5)
#  U <- rnorm(n, 0, 1)
#  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
#  P <- (k+1)*U + rnorm(n, .5, 1)
#  Y <- k*IV + ifelse(A == 1, .333, 0)*A + U + rnorm(n)
#  dat <- data.frame(IV, U, A, P, Y)

# scenario C
#sim <- function(k, n.boot, n){
#  IV <- rbinom(n, 1, .5)
#  U <- k*IV + rnorm(n, 0, 1)
#  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
#  P <- k*IV + U + rnorm(n, .5, 1)
#  Y <- k*IV + ifelse(A == 1, .333, 0)*A + U + rnorm(n)
#  dat <- data.frame(IV, U, A, P, Y)

# scenario D
#sim <- function(k, n.boot, n){
#  IV <- rbinom(n, 1, .5)
#  U <- k*IV + rnorm(n, 0, 1)
#  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
#  P <- 3*U + rnorm(n, .5, 1)
#  Y <- ifelse(A == 1, .333, 0)*A + U + rnorm(n)
#  dat <- data.frame(IV, U, A, P, Y)

# scenario E
#sim <- function(k, n.boot, n){
#  IV <- rbinom(n, 1, .5)
#  U <- rnorm(n, 0, 1)
#  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
#  P <- 3*U + rnorm(n, .5, 1)
#  Y <- k*IV + ifelse(A == 1, .333, 0)*A + U + rnorm(n)
#  dat <- data.frame(IV, U, A, P, Y)

# scenario F
#sim <- function(k, n.boot, n){
#  IV <- rbinom(n, 1, .5)
#  U <- k*IV + rnorm(n, 0, 1)
#  A <- ifelse(IV == 0, 0, rbinom(n, 1, plogis(U)))
#  P <- 3*U + rnorm(n, .5, 1)
#  Y <- k*IV + ifelse(A == 1, .333, 0)*A + U + rnorm(n)
#  dat <- data.frame(IV, U, A, P, Y)

  # IV estimate
  m1_fit <- function(d) coef(ivreg(Y ~ A | IV, data = d))['A']
  m1_val <- m1_fit(dat)
  m1_se  <- bootstrap_se(m1_fit, dat, B = n.boot)

  # DiD estimate
  dat$D.s <- dat$Y - dat$P
  m2_fit <- function(d) coef(lm(D.s ~ A, data = d))['A']
  m2_val <- m2_fit(dat)
  m2_se  <- bootstrap_se(m2_fit, dat, B = n.boot)

  # bootstrapped confidence interval
  int <- bcanon(1:n, n.boot, theta, dat, alpha = c(.025, .975))$confpoints[, 2]

  # results
  return(c(cor(IV, A), m1_val, m1_se, m2_val, m2_se, m1_val - m2_val, int[1], int[2], ifelse(int[1] < 0 & int[2] > 0, 0, 1)))
}

# initialize a matrix to store simulation results
sim_rslt <- matrix(NA, nrow = 1, ncol = 11)

# define sample sizes
sizes <- c(1000)

# define a function to calculate statistics
cal <- function(rslt) {
  m.t <- apply(rslt, 1, mean)
  s.t <- apply(rslt, 1, sd)
  return(list(mean = m.t, sd = s.t))
}

# loop through sample sizes and k values
for (j in 1:1){
  for (i in 1:6){
    rslt <- replicate(100, sim(k = (i - 1)/10, n = sizes[j], n.boot = 1000), simplify = T)
    stats <- cal(rslt)
    
    # print results
    cat("----------------------------------------------------------------------\n")
    cat("n =", sizes[j], " & k =", (i - 1)/10, "\n")
    cat("Means:\n")
    print(stats$mean)
    cat("Standard Deviations:\n")
    print(stats$sd)
    
    # store result in simulation_results matrix
    sim_rslt[j, i] <- stats$mean[9]
  }
}