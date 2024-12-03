sc_dataset <- function() {
	# Import the MASS library
	library(MASS)

	# Generate two datapoints with a bivariate normal distribution
	normal_A <- mvrnorm(n = 100, mu = c(-5, 5),
                        Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                        nrow = 2, ncol = 2))
	normal_B <- mvrnorm(n = 100, mu = c(5, -5),
                        Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                        nrow = 2, ncol = 2))

	# Merge the two together in one dataset
	dataset <- rbind(normal_A, normal_B)

	return(dataset)
}
