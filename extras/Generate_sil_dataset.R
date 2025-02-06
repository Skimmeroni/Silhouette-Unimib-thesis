# Import the MASS and ggplot2 library
library(MASS)
library(ggplot2)

# Generate four datapoints with a bivariate normal distribution
normal_A <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(10, 10))
normal_B <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(-10, 10))
normal_C <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(-10, -10))
normal_D <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(10, -10))

# Merge them together
result <- as.data.frame(rbind(normal_A, normal_B, normal_C, normal_D))
colnames(result) <- c("X", "Y")

# Write to output file
write.csv(result, "../data/sil_dataset.csv", row.names = FALSE)

